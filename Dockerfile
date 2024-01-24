FROM rust:1.71.0-alpine3.18

ENV deny_version="0.14.10"

RUN set -eux; \
    apk update; \
    apk add bash curl git tar; \
    curl --silent -L https://github.com/EmbarkStudios/cargo-deny/releases/download/$deny_version/cargo-deny-$deny_version-x86_64-unknown-linux-musl.tar.gz | tar -xzv -C /usr/bin --strip-components=1;

# Ensure rustup is up to date.
RUN bash -c "sh <(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs) -y"

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
