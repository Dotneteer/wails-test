#!/bin/bash
export PATH=$PATH:/Users/dotneteer/go/bin
cd /Users/dotneteer/source/wails-test
echo "Starting Wails development server..."

# Run fix script in background to monitor and fix generated files
(
  sleep 5  # Wait for initial generation
  ./fix-wailsjs.sh
) &

wails dev