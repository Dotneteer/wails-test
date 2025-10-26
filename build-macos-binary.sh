#!/usr/bin/env bash
set -euo pipefail

# build-macos-binary.sh
# Builds the frontend and produces a macOS .app bundle.
# Usage: ./build-macos-binary.sh [arch]
#   arch - optional target architecture (e.g. arm64, amd64). If omitted this script
#          will use the host architecture.

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FRONTEND_DIR="$PROJECT_ROOT/frontend"
OUT_DIR="$PROJECT_ROOT/build/bin"

# Optionally accept target arch
TARGET_ARCH="${1:-}"  # pass 'arm64' or 'amd64' if you want to override

echo "Project root: ${PROJECT_ROOT}"

# Ensure Go bin is available (GOBIN or GOPATH/bin)
if [ -d "$HOME/go/bin" ]; then
  export PATH="$PATH:$HOME/go/bin"
fi

if ! command -v wails >/dev/null 2>&1; then
  echo "wails CLI not found in PATH. Make sure Go bin is in your PATH or install wails (e.g. 'go install github.com/wailsapp/wails/v2/cmd/wails@latest')." >&2
  exit 1
fi

# Build frontend
echo "Building frontend..."
cd "$FRONTEND_DIR"
# Install dependencies if node_modules missing
if [ ! -d "node_modules" ]; then
  echo "Installing frontend dependencies (npm install)..."
  npm install
fi
npm run build

# Build Go app with packaging to create .app bundle
mkdir -p "$OUT_DIR"
cd "$PROJECT_ROOT"

WAILS_CMD=(wails build)
# If a target arch was provided, set platform accordingly (darwin/ARCH)
if [ -n "$TARGET_ARCH" ]; then
  PLATFORM="darwin/$TARGET_ARCH"
  WAILS_CMD+=( -platform "$PLATFORM" )
fi

echo "Running: ${WAILS_CMD[*]}"
# Execute the command
"${WAILS_CMD[@]}"

echo "Built macOS application bundle: $OUT_DIR/wails-react-starter.app"
echo "You can run it with: open $OUT_DIR/wails-react-starter.app"
