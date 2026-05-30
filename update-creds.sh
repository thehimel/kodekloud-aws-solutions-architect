#!/usr/bin/env bash
# update-creds.sh — paste new AWS credentials after each env reset
# Usage: ./update-creds.sh

ENV_FILE="$(dirname "$0")/.env"

echo ""
echo "  AWS Credential Updater"
echo "  Paste the values from your AWS lab panel."
echo ""

read -rp "  AWS_ACCESS_KEY_ID     : " key_id
read -rp "  AWS_SECRET_ACCESS_KEY : " secret_key
read -rp "  AWS_SESSION_TOKEN     : " session_token
read -rp "  AWS_DEFAULT_REGION    [us-east-1]: " region
region="${region:-us-east-1}"

cat > "$ENV_FILE" <<EOF
export AWS_ACCESS_KEY_ID="${key_id}"
export AWS_SECRET_ACCESS_KEY="${secret_key}"
export AWS_SESSION_TOKEN="${session_token}"
export AWS_DEFAULT_REGION="${region}"
EOF

echo ""
echo "  .env updated. Loading into current shell..."
# shellcheck source=.env
source "$ENV_FILE"

echo "  Done! Verifying with AWS STS..."
echo ""
aws sts get-caller-identity 2>/dev/null \
  && echo "  Credentials are valid." \
  || echo "  Warning: sts check failed — double-check the values above."
echo ""
