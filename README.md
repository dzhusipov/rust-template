# Rust template
### Including: 
```
env
logs
reqwest
tokio
```

### Targets: 
```
x86_64-unknown-linux-gnu
x86_64-unknown-linux-musl
x86_64-pc-windows-gnu
```

Dockerfile for apple silicon. 
Before make all:
```
rustup target add x86_64-unknown-linux-gnu
rustup target add x86_64-unknown-linux-musl
rustup target add x86_64-pc-windows-gnu

// Ubuntu
sudo apt update
sudo apt install musl-tools
sudo apt-get install gcc-mingw-w64

// MacOS 
brew install filosottile/musl-cross/musl-cross
brew install mingw-w64

// then just
make
```