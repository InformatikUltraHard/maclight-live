#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT="$ROOT"

# The live-build configuration is currently inside .github/workflows.
if [[ ! -d "$PROJECT/config" && -d "$ROOT/.github/workflows/config" ]]; then
    PROJECT="$ROOT/.github/workflows"
fi

echo "Maclight Live ISO builder"
echo "Repository: $ROOT"
echo "Configuration: $PROJECT"

if ! command -v lb >/dev/null 2>&1; then
    echo "ERROR: live-build is not installed."
    exit 1
fi

if [[ ! -d "$PROJECT/config" ]]; then
    echo "ERROR: Cannot find the live-build config directory."
    exit 1
fi

cd "$PROJECT"

echo "Configuring Debian Live..."
lb config

echo "Building ISO..."
lb build

echo "Searching for the generated ISO..."
ISO="$(find "$PROJECT" -maxdepth 2 -type f -name '*.iso' -print -quit)"

if [[ -z "$ISO" ]]; then
    echo "ERROR: Build finished but no ISO file was found."
    exit 1
fi

DEST="$ROOT/$(basename "$ISO")"

if [[ "$ISO" != "$DEST" ]]; then
    cp "$ISO" "$DEST"
fi

echo "ISO created: $DEST"
ls -lh "$DEST"
