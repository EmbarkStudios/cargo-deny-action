#!/bin/sh -l
set -e

PATH=$PATH:/usr/local/cargo/bin

if [ -f "rust-toolchain.toml" ]; then
    rm rust-toolchain.toml
fi

if [ -n "$1" ]; then
    rustup set profile minimal
    rustup default "$1"
else
    # Ensure active toolchain is installed if explicit rust-version is not passed.
    # Starting with v1.28, rustup is not going to install active toolchain by default,
    # and this is needed to install the active toolchain if it's not installed.
    # See https://blog.rust-lang.org/2025/03/02/Rustup-1.28.0.html#whats-new-in-rustup-1280
    rustup show active-toolchain || rustup toolchain install
fi

rustup show

if [ -n "$2" ]; then
    git config --global credential.helper store
    git config --global --replace-all url.https://github.com/.insteadOf ssh://git@github.com/
    git config --global --add url.https://github.com/.insteadOf git@github.com:

    echo "$2" >"$HOME/.git-credentials"
    chmod 600 "$HOME/.git-credentials"
fi

if [ -n "$3" ]; then
    mkdir -p "/root/.ssh"
    chmod 0700 "/root/.ssh"
    echo "${3}" >"/root/.ssh/id_rsa"
    chmod 0600 "/root/.ssh/id_rsa"
fi

if [ -n "$4" ]; then
    mkdir -p "/root/.ssh"
    chmod 0700 "/root/.ssh"
    echo "${4}" >"/root/.ssh/known_hosts"
    chmod 0600 "/root/.ssh/known_hosts"
fi

if [ -n "$5" ]; then
    export CARGO_NET_GIT_FETCH_WITH_CLI="$5"
fi

shift
shift
shift
shift
shift

# Due to how github actions run containers we need to explicitly force colors
# as TTY detection fails inside them
export CARGO_TERM_COLOR="always"

cargo-deny $*
