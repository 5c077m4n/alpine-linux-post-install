PATH="${PATH}:~/.local/bin"

# Rust init
source $HOME/.cargo/env

export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/library"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
