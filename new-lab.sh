#!/usr/bin/env bash
# new-lab.sh — scaffold a new lab folder
# Usage: ./new-lab.sh 02-services-networking/17-elastic-ip-demo

set -e

LAB_PATH="$1"
ROOT_DIR="$(dirname "$0")"

if [[ -z "$LAB_PATH" ]]; then
  echo "Usage: ./new-lab.sh <section>/<lab>"
  echo "Example: ./new-lab.sh 02-services-networking/17-elastic-ip-demo"
  exit 1
fi

LAB_DIR="$ROOT_DIR/$LAB_PATH"

if [[ -d "$LAB_DIR" ]]; then
  echo "Lab already exists: $LAB_DIR"
  exit 1
fi

mkdir -p "$LAB_DIR"

# Copy provider.tf from root
cp "$ROOT_DIR/provider.tf" "$LAB_DIR/provider.tf"

# Create empty main.tf
cat > "$LAB_DIR/main.tf" <<TFEOF
# $LAB_PATH
TFEOF

echo ""
echo "  Lab created: $LAB_DIR"
echo ""
echo "  Files:"
echo "    main.tf       (edit this)"
echo "    provider.tf   (copied from root)"
echo ""
echo "  Next:"
echo "    cd $LAB_PATH"
echo "    terraform init"
echo ""
