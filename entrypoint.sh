#!/bin/sh -l

PATH=$PATH:/usr/local/cargo/bin

cargo-deny $*
