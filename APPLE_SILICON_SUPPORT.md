# Apple Silicon Support for i2pd-tools

This patch adds support for building i2pd-tools on macOS with Apple Silicon (M1/M2) processors.

## Problem

The original Makefile assumes OpenSSL is installed in `/usr/local/opt/openssl@1.1`, but on Apple Silicon Macs with Homebrew, OpenSSL is installed in `/opt/homebrew/opt/openssl@3`.

## Solution

The patch adds automatic detection of the architecture and uses the appropriate paths:

- **Apple Silicon**: Uses `/opt/homebrew/opt/openssl@3` paths
- **Intel Mac**: Uses `/usr/local/opt/openssl@1.1` paths (backward compatible)
- **Other platforms**: No changes (Linux, FreeBSD, Windows unaffected)

## Changes

### 1. Main Makefile
- Removes `boost_system` dependency (merged into other Boost libraries in newer versions)
- Removes `atomic` library dependency (built into macOS standard library)
- Adds automatic architecture detection for macOS

### 2. i2pd/Makefile.osx (submodule)
- Updates paths for Apple Silicon Homebrew installation
- Maintains backward compatibility with Intel Mac paths

## How to Apply

1. **Apply the main patch:**
   ```bash
   git apply apple_silicon_main.patch
   ```

2. **Apply the submodule patch:**
   ```bash
   cd i2pd
   git apply ../i2pd_makefile_osx.patch
   cd ..
   ```

3. **Build the project:**
   ```bash
   make clean
   make
   ```

## Compatibility

✅ **Fully backward compatible** - works on all platforms:
- Linux: No changes
- FreeBSD: No changes  
- Windows: No changes
- macOS Intel: Uses original paths
- macOS Apple Silicon: Uses new paths

## Testing

The patch has been tested and successfully builds all 14 tools:
- autoconf, b33address, famtool, i2pbase64, keygen, keyinfo
- offlinekeys, regaddr, regaddr_3ld, regaddralias, routerinfo
- vain, verifyhost, x25519
