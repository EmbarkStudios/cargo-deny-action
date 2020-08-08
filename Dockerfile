FROM rust:alpine

RUN apk add --no-cache curl

ENV version 0.7.3

RUN curl -L https://github.com/EmbarkStudios/cargo-deny/releases/download/${version}/cargo-deny-${version}-x86_64-unknown-linux-musl.tar.gz | tar xzv -C . --strip-components=1

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
