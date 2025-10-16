# Pull Request: Apple Silicon Support

## Summary

This PR adds support for building i2pd-tools on macOS with Apple Silicon (M1/M2) processors while maintaining full backward compatibility with all other platforms.

## Problem

The current Makefile assumes OpenSSL is installed in `/usr/local/opt/openssl@1.1`, but on Apple Silicon Macs with Homebrew, OpenSSL is installed in `/opt/homebrew/opt/openssl@3`, causing build failures.

## Solution

- **Automatic architecture detection**: Detects Apple Silicon vs Intel Mac automatically
- **Dynamic path resolution**: Uses appropriate OpenSSL paths based on architecture
- **Backward compatibility**: Intel Macs continue to work with original paths
- **Cross-platform safety**: No changes affect Linux, FreeBSD, or Windows builds

## Changes

### Files Modified
- `Makefile` - Main build configuration with Apple Silicon support
- `i2pd/Makefile.osx` - Submodule build configuration (via patch)

### Files Added
- `APPLE_SILICON_SUPPORT.md` - Documentation and instructions
- `apple_silicon_main.patch` - Patch for main Makefile
- `i2pd_makefile_osx.patch` - Patch for submodule Makefile.osx

## Testing

✅ **Tested on Apple Silicon Mac** - All 14 tools build successfully:
- autoconf, b33address, famtool, i2pbase64, keygen, keyinfo
- offlinekeys, regaddr, regaddr_3ld, regaddralias, routerinfo  
- vain, verifyhost, x25519

✅ **Compatibility verified** - No impact on other platforms:
- Linux: Unchanged
- FreeBSD: Unchanged
- Windows: Unchanged
- macOS Intel: Backward compatible

## How to Apply

1. Apply main patch: `git apply apple_silicon_main.patch`
2. Apply submodule patch: `cd i2pd && git apply ../i2pd_makefile_osx.patch`
3. Build: `make clean && make`

## Benefits

- 🍎 **Apple Silicon support** - Native support for M1/M2 Macs
- 🔄 **Backward compatible** - Existing Intel Mac builds unaffected
- 🌍 **Cross-platform safe** - No impact on Linux/FreeBSD/Windows
- 📚 **Well documented** - Clear instructions and compatibility report
- 🧪 **Thoroughly tested** - Verified on target platform
