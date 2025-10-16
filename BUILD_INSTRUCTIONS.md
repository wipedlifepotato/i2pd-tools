# Apple Silicon Build Instructions

## Quick Start

For Apple Silicon Mac users, follow these steps to build i2pd-tools:

### Prerequisites

1. **Install Homebrew** (if not already installed):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Install dependencies**:
   ```bash
   brew install boost openssl@3
   ```

### Building

1. **Clone the repository**:
   ```bash
   git clone --recursive https://github.com/purplei2p/i2pd-tools
   cd i2pd-tools
   ```

2. **Apply Apple Silicon patches**:
   ```bash
   git apply apple_silicon_main.patch
   cd i2pd
   git apply ../i2pd_makefile_osx.patch
   cd ..
   ```

3. **Build the project**:
   ```bash
   make clean
   make
   ```

4. **Verify the build**:
   ```bash
   ./keygen test_key.dat
   rm test_key.dat
   ```

## What This Patch Does

### Automatic Architecture Detection

The patch automatically detects whether you're running on:
- **Apple Silicon Mac** (M1/M2) → Uses `/opt/homebrew/opt/openssl@3` paths
- **Intel Mac** → Uses `/usr/local/opt/openssl@1.1` paths (original behavior)

### Library Updates

- **Removes `boost_system`**: This library was merged into other Boost libraries in newer versions
- **Removes `atomic`**: This library is built into macOS standard library
- **Updates OpenSSL paths**: Uses correct paths for Apple Silicon Homebrew installation

## Compatibility

✅ **Fully compatible** with all platforms:
- **macOS Apple Silicon**: ✅ Supported (new)
- **macOS Intel**: ✅ Supported (backward compatible)
- **Linux**: ✅ No changes, works as before
- **FreeBSD**: ✅ No changes, works as before
- **Windows**: ✅ No changes, works as before

## Troubleshooting

### Build Errors

If you encounter build errors:

1. **Check Homebrew installation**:
   ```bash
   brew --version
   brew list | grep -E "(openssl|boost)"
   ```

2. **Verify OpenSSL paths**:
   ```bash
   ls -la /opt/homebrew/opt/openssl@3/include/openssl/sha.h
   ```

3. **Clean and rebuild**:
   ```bash
   make clean
   make
   ```

### Common Issues

- **"openssl/sha.h not found"**: Make sure OpenSSL@3 is installed via Homebrew
- **"boost_system not found"**: This is expected - the patch removes this dependency
- **"atomic library not found"**: This is expected - the patch removes this dependency

## Tools Included

After successful build, you'll have these tools available:

- `autoconf` - Configuration helper for i2pd
- `b33address` - B33 address generator
- `famtool` - Router family management tool
- `i2pbase64` - Base64 encoder/decoder for I2P
- `keygen` - I2P private key generator
- `keyinfo` - Key information analyzer
- `offlinekeys` - Offline key management
- `regaddr` - Domain registration for reg.i2p
- `regaddr_3ld` - Subdomain registration (3-level domains)
- `regaddralias` - Alias registration for existing domains
- `routerinfo` - Router information analyzer
- `vain` - Vanity address generator
- `verifyhost` - Host signature verification
- `x25519` - X25519 key pair generator

## Contributing

If you encounter issues or want to improve Apple Silicon support:

1. Test the patch on your Apple Silicon Mac
2. Report any issues with detailed error messages
3. Suggest improvements for the build process

## License

This patch follows the same license as the original i2pd-tools project.
