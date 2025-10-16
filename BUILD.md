# i2pd-tools Build Guide

## Overview
i2pd-tools is a collection of utilities for working with I2P (Invisible Internet Project) networks.

## Prerequisites

### Windows (MSYS2)
```bash
# Install MSYS2 from https://www.msys2.org/
# Then install required packages:
pacman -S mingw-w64-x86_64-toolchain
pacman -S mingw-w64-x86_64-boost
pacman -S mingw-w64-x86_64-openssl
pacman -S mingw-w64-x86_64-zlib
pacman -S make
```

### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install build-essential libboost-all-dev libssl-dev zlib1g-dev
```

### macOS
```bash
# Using Homebrew
brew install boost openssl zlib
```

## Building

### Quick Start
```bash
# Clone repository
git clone https://github.com/wipedlifepotato/i2pd-tools.git
cd i2pd-tools

# Initialize submodules
git submodule update --init --recursive

# Build all tools
make
```

### Build with Different Compilers

#### GCC (Default)
```bash
make CXX=g++
```

#### Clang
```bash
make CXX=clang++
```

### Build Individual Tools
```bash
make keygen      # Generate I2P keys
make vain        # Generate vanity addresses
make famtool     # Family router tools
make routerinfo  # Router information
# ... and more
```

## Available Tools

| Tool | Description |
|------|-------------|
| `keygen` | Generate I2P cryptographic keys |
| `vain` | Generate vanity I2P addresses |
| `keyinfo` | Display key information |
| `famtool` | Family router management |
| `routerinfo` | Router information display |
| `regaddr` | Domain registration |
| `regaddr_3ld` | Subdomain registration |
| `regaddralias` | Alias registration |
| `i2pbase64` | Base64 encoding/decoding |
| `offlinekeys` | Offline key management |
| `b33address` | B33 address utilities |
| `x25519` | X25519 key generation |
| `verifyhost` | Host verification |
| `autoconf` | Configuration helper |

## Troubleshooting

### Windows Build Issues
- Ensure MSYS2 is properly installed
- Use mingw64 paths (not clang64)
- Check that BOOST_SUFFIX is set to `-mt`
- Include boost_filesystem library

### Common Errors
- **Undefined reference to boost::filesystem**: Add `-lboost_filesystem` to LDLIBS
- **Cannot find -lboost_program_options**: Check Boost installation and paths
- **Multiple definition errors**: Ensure consistent compiler usage

## Development

### Clean Build
```bash
make clean
```

### Debug Build
```bash
make CXXFLAGS="-g -O0"
```

### Cross-Platform Notes
- Windows: Uses MSYS2 with mingw64 toolchain
- Linux: Uses system package manager
- macOS: Uses Homebrew
- FreeBSD: Uses ports/pkg

## Contributing
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test on your platform
5. Submit a pull request

## License
See LICENSE file for details.
