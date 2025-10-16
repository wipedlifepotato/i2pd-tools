# Quick Setup for Apple Silicon Macs

## One-Command Setup

```bash
# Clone, patch, and build in one go
git clone --recursive https://github.com/purplei2p/i2pd-tools && \
cd i2pd-tools && \
git apply apple_silicon_main.patch && \
cd i2pd && git apply ../i2pd_makefile_osx.patch && cd .. && \
make clean && make
```

## Manual Steps

### 1. Install Dependencies
```bash
brew install boost openssl@3
```

### 2. Apply Patches
```bash
# Main Makefile patch
git apply apple_silicon_main.patch

# Submodule patch
cd i2pd
git apply ../i2pd_makefile_osx.patch
cd ..
```

### 3. Build
```bash
make clean
make
```

### 4. Test
```bash
./keygen test_key.dat && rm test_key.dat
```

## What's Fixed

- ✅ **OpenSSL paths**: Automatically detects Apple Silicon vs Intel Mac
- ✅ **Boost libraries**: Removes obsolete `boost_system` dependency
- ✅ **Atomic library**: Removes unnecessary `atomic` dependency
- ✅ **Cross-platform**: No impact on Linux/FreeBSD/Windows builds

## Files Modified

- `Makefile` - Main build configuration
- `i2pd/Makefile.osx` - Submodule build configuration

## Compatibility

- **Apple Silicon Mac**: ✅ Fully supported
- **Intel Mac**: ✅ Backward compatible
- **Linux/FreeBSD/Windows**: ✅ Unchanged
