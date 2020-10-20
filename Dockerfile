FROM rust:1.47-slim-buster as build

ENV deny_version=0.8.0

RUN set -eux; \
    apt-get update; \
    apt-get install -y \
        git \
        musl-tools \
        make; \
    rustup target add x86_64-unknown-linux-musl; \
    git clone https://github.com/EmbarkStudios/cargo-deny code; \
    cd code; \
    git checkout $deny_version; \
    cargo build --release --target x86_64-unknown-linux-musl; \
    strip target/x86_64-unknown-linux-musl/release/cargo-deny; \
    cp target/x86_64-unknown-linux-musl/release/cargo-deny /cargo-deny;

FROM rust:1.47-alpine3.12 as run

COPY --from=build /cargo-deny /usr/bin

ENTRYPOINT ["cargo-deny"]
