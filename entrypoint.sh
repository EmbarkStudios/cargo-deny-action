#!/bin/sh -l

PATH=$PATH:/usr/local/cargo/bin

# HACK(eddyb) print rustup version
rustup --version

cargo-deny $*
