#!/usr/bin/env bash
# Sync Enso's standard labels from labels.json to GitHub.
# Creates or updates every label in the file, and deletes any label
# not in the file, except per-repo "client: ..." labels.
# Usage:
#   ./scripts/sync-labels.sh              # every active repo in the org
#   ./scripts/sync-labels.sh repo-name    # one repo
#   DRY_RUN=1 ./scripts/sync-labels.sh    # show what would be pruned, change nothing
set -euo pipefail

ORG="ensoinnovative"
LABELS_FILE="$(dirname "$0")/../labels.json"
KEEP_PREFIX="client: "
DRY_RUN="${DRY_RUN:-0}"

if [[ $# -gt 0 ]]; then
  repos=("$1")
else
  mapfile -t repos < <(gh repo list "$ORG" --no-archived --limit 200 --json name --jq '.[].name')
fi

mapfile -t wanted < <(jq -r '.[].name' "$LABELS_FILE")

for repo in "${repos[@]}"; do
  echo "== $ORG/$repo"

  # Prune labels not in labels.json (client: labels are kept)
  mapfile -t existing < <(gh label list --repo "$ORG/$repo" --limit 500 --json name --jq '.[].name')
  for label in "${existing[@]}"; do
    [[ "$label" == "$KEEP_PREFIX"* ]] && continue
    if ! printf '%s\n' "${wanted[@]}" | grep -Fxq -- "$label"; then
      if [[ "$DRY_RUN" == "1" ]]; then
        echo "  would prune: $label"
      else
        gh label delete "$label" --repo "$ORG/$repo" --yes >/dev/null
        echo "  pruned: $label"
      fi
    fi
  done

  [[ "$DRY_RUN" == "1" ]] && continue

  # Create or update every label in labels.json
  jq -c '.[]' "$LABELS_FILE" | while read -r entry; do
    name=$(jq -r '.name' <<< "$entry")
    color=$(jq -r '.color' <<< "$entry")
    desc=$(jq -r '.description' <<< "$entry")
    gh label create "$name" --repo "$ORG/$repo" --color "$color" --description "$desc" --force >/dev/null
    echo "  synced: $name"
  done
done

echo "Done."
