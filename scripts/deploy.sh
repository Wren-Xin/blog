#!/usr/bin/env bash
# Deploy the static site to a remote host over SSH.
# All target details come from the environment — no host, path, port or
# credential is stored in this repository.
#
#   DEPLOY_HOST=user@example.com   required
#   DEPLOY_PATH=/var/www/site      required
#   DEPLOY_PORT=22                 optional
#   DEPLOY_SSH_KEY=/path/to/key    optional
#
# Usage:  DEPLOY_HOST=... DEPLOY_PATH=... ./scripts/deploy.sh

set -euo pipefail

: "${DEPLOY_HOST:?DEPLOY_HOST is required}"
: "${DEPLOY_PATH:?DEPLOY_PATH is required}"
PORT="${DEPLOY_PORT:-22}"

SSH_OPTS=(-p "$PORT" -o StrictHostKeyChecking=accept-new)
if [[ -n "${DEPLOY_SSH_KEY:-}" ]]; then
  SSH_OPTS+=(-i "$DEPLOY_SSH_KEY")
fi

SRC_DIR="$(cd "$(dirname "$0")/.." && pwd)"
STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT

# Only publish the files the site actually needs.
cp -R "$SRC_DIR/index.html" "$SRC_DIR/assets" "$STAGE/"

echo "Deploying to ${DEPLOY_HOST}:${DEPLOY_PATH} (port ${PORT})"
ssh "${SSH_OPTS[@]}" "$DEPLOY_HOST" "mkdir -p '$DEPLOY_PATH'"
scp "${SSH_OPTS[@]}" -r "$STAGE"/. "$DEPLOY_HOST:$DEPLOY_PATH/"
echo "Done."
