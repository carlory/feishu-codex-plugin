#!/usr/bin/env bash
set -euo pipefail

UPSTREAM_REPO="${UPSTREAM_REPO:-https://github.com/larksuite/cli.git}"
UPSTREAM_REF="${1:-main}"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PLUGIN_DIR="$ROOT_DIR/plugins/lark-cli"
SKILLS_DIR="$PLUGIN_DIR/skills"
TMP_DIR="$(mktemp -d)"

cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

git clone --depth 1 --branch "$UPSTREAM_REF" "$UPSTREAM_REPO" "$TMP_DIR/cli"
UPSTREAM_COMMIT="$(git -C "$TMP_DIR/cli" rev-parse HEAD)"

rm -rf "$SKILLS_DIR"
mkdir -p "$PLUGIN_DIR"
cp -R "$TMP_DIR/cli/skills" "$SKILLS_DIR"

cat > "$PLUGIN_DIR/UPSTREAM.md" <<EOF
# Upstream

Skills are mirrored from:

https://github.com/larksuite/cli/tree/main/skills

Tracked ref: \`$UPSTREAM_REF\`

Last synced commit: \`$UPSTREAM_COMMIT\`

The \`plugins/lark-cli/skills/\` directory is generated from upstream and should not be hand-edited. Local plugin metadata, marketplace configuration, docs, scripts, and assets are maintained in this repository.
EOF

echo "Synced larksuite/cli skills from $UPSTREAM_COMMIT"
