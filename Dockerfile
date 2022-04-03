FROM rust:1.59.0-alpine3.15@sha256:b57e3379714cf4f784ce1de9e6143eda24b385085b94e7f3a4ff115d71ee986c

ENV deny_version="0.11.3"

RUN set -eux; \
    apk update; \
    apk add bash curl; \
    curl --silent -L https://github.com/EmbarkStudios/cargo-deny/releases/download/$deny_version/cargo-deny-$deny_version-x86_64-unknown-linux-musl.tar.gz | tar -xzv -C /usr/bin --strip-components=1;

# Ensure rustup is up to date.
RUN bash -c "sh <(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs) -y"

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
