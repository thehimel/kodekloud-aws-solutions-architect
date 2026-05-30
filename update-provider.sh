#!/usr/bin/env bash
# update-provider.sh — sync root provider.tf to all lab folders
# Usage: ./update-provider.sh

set -e

ROOT_DIR="$(dirname "$0")"
PROVIDER="$ROOT_DIR/provider.tf"

if [[ ! -f "$PROVIDER" ]]; then
  echo "provider.tf not found at project root."
  exit 1
fi

UPDATED=0

while IFS= read -r -d '' lab_provider; do
  lab_dir="$(dirname "$lab_provider")"
  cp "$PROVIDER" "$lab_provider"
  echo "  updated: $lab_dir/provider.tf"
  ((UPDATED++))
done < <(find "$ROOT_DIR" -mindepth 3 -maxdepth 3 -name "provider.tf" -print0)

echo ""
if [[ $UPDATED -eq 0 ]]; then
  echo "  No lab provider.tf files found."
else
  echo "  $UPDATED lab(s) updated."
fi
echo ""
