#!/bin/bash
# Script to remove @ts-check from auto-generated Wails files

find frontend/wailsjs -name "*.js" -type f -exec sed -i '' '1{/^\/\/ @ts-check$/d;}' {} \;
echo "Removed @ts-check comments from wailsjs files"
