#!/bin/bash

# i2pd-tools Build Script
# Supports Windows (MSYS2), Linux, and macOS

set -e

echo "=== i2pd-tools Build Script ==="
echo "Detecting platform..."

# Detect platform
if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    PLATFORM="windows"
    echo "Platform: Windows (MSYS2)"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    PLATFORM="linux"
    echo "Platform: Linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    PLATFORM="macos"
    echo "Platform: macOS"
else
    echo "Unknown platform: $OSTYPE"
    exit 1
fi

# Check dependencies
echo "Checking dependencies..."

if [[ "$PLATFORM" == "windows" ]]; then
    # Check MSYS2 packages
    if ! pacman -Q mingw-w64-x86_64-gcc >/dev/null 2>&1; then
        echo "Error: mingw-w64-x86_64-gcc not installed"
        echo "Run: pacman -S mingw-w64-x86_64-toolchain"
        exit 1
    fi
    
    if ! pacman -Q mingw-w64-x86_64-boost >/dev/null 2>&1; then
        echo "Error: mingw-w64-x86_64-boost not installed"
        echo "Run: pacman -S mingw-w64-x86_64-boost"
        exit 1
    fi
    
    if ! pacman -Q mingw-w64-x86_64-openssl >/dev/null 2>&1; then
        echo "Error: mingw-w64-x86_64-openssl not installed"
        echo "Run: pacman -S mingw-w64-x86_64-openssl"
        exit 1
    fi
fi

# Initialize submodules
echo "Initializing submodules..."
git submodule update --init --recursive

# Clean previous build
echo "Cleaning previous build..."
make clean || true

# Build
echo "Building i2pd-tools..."
make

# Count built tools
TOOL_COUNT=$(ls -1 *.exe 2>/dev/null | wc -l || ls -1 | grep -E '^[a-zA-Z0-9_-]+$' | grep -v '\.' | wc -l)
echo "Built $TOOL_COUNT tools successfully!"

# List tools
echo "Built tools:"
if [[ "$PLATFORM" == "windows" ]]; then
    ls -la *.exe
else
    ls -la | grep -E '^[a-zA-Z0-9_-]+$' | grep -v '\.'
fi

echo "=== Build completed successfully! ==="
