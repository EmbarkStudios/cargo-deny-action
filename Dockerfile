FROM rust:alpine

RUN apk add --no-cache curl

RUN curl --silent -L --output cargo-deny.tar.gz https://github.com/EmbarkStudios/cargo-deny/releases/download/0.5.2/cargo-deny-0.5.2-x86_64-unknown-linux-musl.tar.gz
RUN tar -xzvf cargo-deny.tar.gz -C . --strip-components=1

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
