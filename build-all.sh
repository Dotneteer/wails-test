#!/bin/bash

# Multi-platform build script for Wails
# Usage: ./build-all.sh [platform] [--nopackage]
# If no platform specified, builds for all platforms
# Use --nopackage flag to build single binaries instead of app bundles

export PATH=$PATH:/Users/dotneteer/go/bin

PLATFORMS="${1:-all}"
BUILD_FLAGS=""
HOST_OS=$(uname -s | tr '[:upper:]' '[:lower:]')

# Check for --nopackage flag
if [[ "$*" == *"--nopackage"* ]]; then
    BUILD_FLAGS="-nopackage"
    echo "Building single binaries (no packaging)"
    echo ""
fi

can_build() {
    local platform=$1
    
    # Check if cross-compilation is supported
    if [ "$HOST_OS" = "darwin" ] && [ "$platform" = "linux" ]; then
        echo "⚠ Skipping $platform (cross-compilation from macOS not supported)"
        return 1
    fi
    return 0
}

build_platform() {
    local platform=$1
    local arch=$2
    
    if ! can_build "$platform"; then
        echo ""
        return
    fi
    
    echo "Building for $platform/$arch..."
    wails build -platform "$platform/$arch" $BUILD_FLAGS
    if [ $? -eq 0 ]; then
        echo "✓ Successfully built for $platform/$arch"
    else
        echo "✗ Failed to build for $platform/$arch"
    fi
    echo ""
}

echo "=== Wails Multi-Platform Build ==="
echo ""

case $PLATFORMS in
    "windows")
        build_platform "windows" "amd64"
        build_platform "windows" "arm64"
        ;;
    "linux")
        build_platform "linux" "amd64"
        build_platform "linux" "arm64"
        ;;
    "darwin"|"mac"|"macos")
        build_platform "darwin" "amd64"
        build_platform "darwin" "arm64"
        build_platform "darwin" "universal"
        ;;
    "all")
        echo "Building for all platforms..."
        echo ""
        
        # macOS
        build_platform "darwin" "amd64"
        build_platform "darwin" "arm64"
        build_platform "darwin" "universal"
        
        # Windows
        build_platform "windows" "amd64"
        build_platform "windows" "arm64"
        
        # Linux
        build_platform "linux" "amd64"
        build_platform "linux" "arm64"
        ;;
    *)
        echo "Usage: ./build-all.sh [windows|linux|darwin|all] [--nopackage]"
        echo ""
        echo "Platforms:"
        echo "  windows - Build for Windows (x64, ARM)"
        echo "  linux   - Build for Linux (x64, ARM)"
        echo "  darwin  - Build for macOS (Intel, Apple Silicon, Universal)"
        echo "  all     - Build for all platforms (default)"
        echo ""
        echo "Options:"
        echo "  --nopackage - Build single binaries instead of app bundles"
        echo ""
        echo "Examples:"
        echo "  ./build-all.sh                    # Build all platforms with packaging"
        echo "  ./build-all.sh windows            # Build Windows only with packaging"
        echo "  ./build-all.sh --nopackage        # Build all platforms as single binaries"
        echo "  ./build-all.sh darwin --nopackage # Build macOS as single binaries"
        exit 1
        ;;
esac

echo "=== Build Complete ==="
echo "Binaries are in the build/bin directory"
