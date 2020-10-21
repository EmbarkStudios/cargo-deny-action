FROM rust:1.47-alpine3.12

ENV deny_version=0.8.0

RUN set -eux; \
    apk update; \
    apk add curl; \
    curl --silent -L https://github.com/EmbarkStudios/cargo-deny/releases/download/$deny_version/cargo-deny-$deny_version-x86_64-unknown-linux-musl.tar.gz | tar -xzv -C /usr/bin --strip-components=1;

ENTRYPOINT ["cargo-deny"]
