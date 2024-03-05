#!/bin/sh -l
set -e

PATH=$PATH:/usr/local/cargo/bin

if [ -n "$1" ]
then
    rustup set profile minimal
    rustup default "$1"
fi

if [ -n "$2" ]
then
    git config --global credential.helper store
    git config --global --replace-all url.https://github.com/.insteadOf ssh://git@github.com/
    git config --global --add url.https://github.com/.insteadOf git@github.com:

    echo "$2" > "$HOME/.git-credentials"
    chmod 600 "$HOME/.git-credentials"
fi

shift
shift

# Due to how github actions run containers we need to explicitly force colors
# as TTY detection fails inside them
export CARGO_TERM_COLOR="always"

cargo-deny $*
