#!/usr/bin/env bash
set -euo pipefail

# run.sh
# Convenience script to run the built Wails application.
# Usage: ./run.sh

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_BUNDLE="$PROJECT_ROOT/build/bin/wails-react-starter.app"
BINARY_PATH="$APP_BUNDLE/Contents/MacOS/wails-test"

echo "Wails App Runner"
echo "================"

# Check if .app bundle exists
if [ ! -d "$APP_BUNDLE" ]; then
  echo "Error: Application bundle not found at: $APP_BUNDLE"
  echo ""
  echo "Please build the application first:"
  echo "  ./build-macos-binary.sh"
  echo ""
  echo "Or run in development mode:"
  echo "  ./run-dev.sh"
  exit 1
fi

# Check if binary exists inside the bundle
if [ ! -f "$BINARY_PATH" ]; then
  echo "Error: Application bundle is incomplete (executable not found)."
  echo "Please rebuild the application:"
  echo "  ./build-macos-binary.sh"
  exit 1
fi

echo "Starting application: $APP_BUNDLE"
echo ""

# Open the .app bundle (preferred macOS way)
open "$APP_BUNDLE"
