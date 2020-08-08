#!/bin/sh -l

PATH=$PATH:/usr/local/cargo/bin

if [ "$USE_LATEST" = "true" ]; then
    latest=$(curl --silent --fail https://api.github.com/repos/EmbarkStudios/cargo-deny/releases/latest | grep -oP '(?<=\"tag_name\": \").+?(?=\")')
    current=$(/cargo-deny -V | cut -d' ' -f 2)

    if [ ! "$latest" = "$current" ]; then
        echo "::warning ::cargo-deny version $current is out of date, updating to $latest"
        curl -L https://github.com/EmbarkStudios/cargo-deny/releases/download/"${latest}"/cargo-deny-"${latest}"-x86_64-unknown-linux-musl.tar.gz | tar xzv -C . --strip-components=1
    fi
fi

/cargo-deny $*
