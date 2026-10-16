#!/usr/bin/env bash
# Sync Enso's standard labels from labels.json to GitHub.
# Usage:
#   ./scripts/sync-labels.sh              # every active repo in the org
#   ./scripts/sync-labels.sh repo-name    # one repo
set -euo pipefail

ORG="ensoinnovative"
LABELS_FILE="$(dirname "$0")/../labels.json"
GITHUB_DEFAULTS=("bug" "documentation" "duplicate" "enhancement" "good first issue" "help wanted" "invalid" "question" "wontfix")

if [[ $# -gt 0 ]]; then
  repos=("$1")
else
  mapfile -t repos < <(gh repo list "$ORG" --no-archived --limit 200 --json name --jq '.[].name')
fi

for repo in "${repos[@]}"; do
  echo "== $ORG/$repo"

  # Remove GitHub's default labels (replaced by the prefixed set)
  for label in "${GITHUB_DEFAULTS[@]}"; do
    if gh label delete "$label" --repo "$ORG/$repo" --yes >/dev/null 2>&1; then
      echo "  removed: $label"
    fi
  done

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