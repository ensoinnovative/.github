#!/usr/bin/env bash
# Applies Enso's standard merge settings to one repo or every org repo.
# Usage: scripts/repo-settings.sh [repo-name]
set -euo pipefail
ORG="ensoinnovative"

apply() {
  echo "Applying settings to $ORG/$1"
  gh api -X PATCH "repos/$ORG/$1" --silent \
    -F allow_squash_merge=true \
    -F allow_merge_commit=false \
    -F allow_rebase_merge=false \
    -F delete_branch_on_merge=true \
    -F allow_update_branch=true \
    -f squash_merge_commit_title=PR_TITLE \
    -f squash_merge_commit_message=PR_BODY
}

if [[ $# -ge 1 ]]; then
  apply "$1"
else
  for repo in $(gh repo list "$ORG" --no-archived --limit 200 --json name -q '.[].name'); do
    apply "$repo"
  done
fi
