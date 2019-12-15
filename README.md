# ❌ cargo-deny GitHub Action

[![Build Status](https://github.com/EmbarkStudios/cargo-deny-action/workflows/Test/badge.svg)](https://github.com/EmbarkStudios/cargo-deny-action/actions?workflow=Test)
[![Contributor Covenant](https://img.shields.io/badge/contributor%20covenant-v1.4%20adopted-ff69b4.svg)](CODE_OF_CONDUCT.md)
[![Embark](https://img.shields.io/badge/embark-open%20source-blueviolet.svg)](https://embark.dev)

GitHub Action for running [`cargo-deny`](https://github.com/EmbarkStudios/cargo-deny) to help manage Cargo crate dependencies and validate licenses.

🚧 This repo is still work-in-progress `v0`, feel free to test it but avoid rely on it until `v1` (see [#1](https://github.com/EmbarkStudios/cargo-deny-action/issues/1)) 🚧

## Usage

Create a `deny.toml` file in the root of the repo to use as rules for the action ([example](https://github.com/EmbarkStudios/cargo-deny/blob/master/deny.toml)).
See [`cargo-deny`](https://github.com/EmbarkStudios/cargo-deny) for instructions and details of the format and capabilities.

This action will run `cargo-deny check` and report failure if any banned crates or disallowed open souce licenses are found used in the crate or its dependencies.

### Example pipeline

```yaml
name: CI
on: [push, pull_request]
jobs:
  cargo-deny:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - uses: EmbarkStudios/cargo-deny-action@v0
```

## Users

Repositories using this action (PR to add your repo):

- [ash-molten](https://github.com/EmbarkStudios/ash-molten)
- [cargo-about](https://github.com/EmbarkStudios/cargo-about)
- [cargo-fetcher](https://github.com/EmbarkStudios/cargo-fetcher)
- [physx-rs](https://github.com/EmbarkStudios/physx-rs)
- [tame-gcs](https://github.com/EmbarkStudios/tame-gcs)
- [tame-oauth](https://github.com/EmbarkStudios/tame-oauth)
- [texture-synthesis](https://github.com/EmbarkStudios/texture-synthesis)

## Contributing

We welcome community contributions to this project.

Please read our [Contributor Guide](CONTRIBUTING.md) for more information on how to get started.

## License

Licensed under either of

* Apache License, Version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
* MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)

at your option.

### Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted for inclusion in the work by you, as defined in the Apache-2.0 license, shall be dual licensed as above, without any additional terms or conditions.
