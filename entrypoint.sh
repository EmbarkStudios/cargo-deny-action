#!/bin/sh -l
set -e

PATH=$PATH:/usr/local/cargo/bin

if [ -n "$1" ]
then
    rustup set profile minimal
    rustup default "$1"
fi

shift

cargo-deny "$@"
