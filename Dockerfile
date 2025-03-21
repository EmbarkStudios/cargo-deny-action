FROM rust:1.85.0-alpine3.20@sha256:f0cef6c65992995b1c7816cb667de95799852e3fbed9d06f95855cbc512a0fd0

ENV deny_version="0.18.2"

RUN set -eux; \
    apk update; \
    apk add bash curl git tar openssh; \
    curl --silent -L https://github.com/EmbarkStudios/cargo-deny/releases/download/$deny_version/cargo-deny-$deny_version-x86_64-unknown-linux-musl.tar.gz | tar -xzv -C /usr/bin --strip-components=1;

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
