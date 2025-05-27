<div align="center">

# ❌ cargo-deny GitHub Action

**GitHub Action for running [`cargo-deny`](https://github.com/EmbarkStudios/cargo-deny) to help manage Cargo crate dependencies and validate licenses.**

[![Build Status](https://github.com/EmbarkStudios/cargo-deny-action/workflows/Test/badge.svg)](https://github.com/EmbarkStudios/cargo-deny-action/actions?workflow=Test)
[![Contributor Covenant](https://img.shields.io/badge/contributor%20covenant-v1.4%20adopted-ff69b4.svg)](CODE_OF_CONDUCT.md)
[![Embark](https://img.shields.io/badge/embark-open%20source-blueviolet.svg)](https://embark.dev)

</div>

## Usage

Create a `deny.toml` file in the root of the repo to use as rules for the action ([example](https://github.com/EmbarkStudios/cargo-deny/blob/master/deny.toml)).
See [`cargo-deny`](https://github.com/EmbarkStudios/cargo-deny) for instructions and details of the format and capabilities.

This action will run `cargo-deny check` and report failure if any banned crates or disallowed open source licenses are found used in the crate or its dependencies.

The action has three optional inputs

* `rust-version`: The rust/cargo version to use, updated before cargo-deny is run. Defaults to the version in the image, which is currently **1.71.0**.
* `log-level`: The log level to use for `cargo-deny`, default is `warn`
* `command`: The command to use for `cargo-deny`, default is `check`
* `arguments`: The argument to pass to `cargo-deny`, default is `--all-features`. See [Common Options](https://embarkstudios.github.io/cargo-deny/cli/common.html) for a list of the available options.
* `manifest-path`: The path to a Cargo.toml file to use as the root. Defaults to `./Cargo.toml`. Note this argument is always passed, so you can't have it in `arguments` as well, just set it it to the value you had in `arguments` if you were using it there.
* `command-arguments` The argument to pass to the command, default is emtpy. See options for [each command](https://embarkstudios.github.io/cargo-deny/cli/index.html).
* `credentials` This argument stores the credentials in the file `$HOME/git-credentials`, and configures git to use it. The credential must match the format `https://user:pass@github.com`

### Example pipeline

```yaml
name: CI
on: [push, pull_request]
jobs:
  cargo-deny:
    runs-on: ubuntu-22.04
    steps:
    - uses: actions/checkout@v4
    - uses: EmbarkStudios/cargo-deny-action@v2
```

### Example pipeline with custom options using default values

```yaml
name: CI
on: [push, pull_request]
jobs:
  cargo-deny:
    runs-on: ubuntu-22.04
    steps:
    - uses: actions/checkout@v4
    - uses: EmbarkStudios/cargo-deny-action@v2
      with:
        log-level: warn
        manifest-path: ./Cargo.toml
        command: check
        arguments: --all-features
        command-arguments: ""
        credentials: https://${{ secrets.GITHUB_USER }}:${{ secrets.GITHUB_PAT }}@github.com
```

### Use specific Rust version

```yaml
name: CI
on: [push, pull_request]
jobs:
  cargo-deny:
    runs-on: ubuntu-22.04
    steps:
    - uses: actions/checkout@v4
    - uses: EmbarkStudios/cargo-deny-action@v2
      with:
        rust-version: "1.60.0"
        log-level: warn
        command: check
        arguments: --all-features
```

### Recommended pipeline if not using advisories, to only run on dependency changes

If you use this pipeline, you should have `Cargo.lock` files checked into your
repository.

```yaml
name: CI
on:
  pull_request:
    paths:
      - '**/Cargo.lock'
      - '**/Cargo.toml'
      - '**/deny.toml'
jobs:
  cargo-deny:
    runs-on: ubuntu-22.04
    steps:
    - uses: actions/checkout@v4
    - uses: EmbarkStudios/cargo-deny-action@v2
      with:
        command: check bans licenses sources
```

### Recommended pipeline if using advisories, to avoid sudden breakages

```yaml
name: CI
on: [push, pull_request]
jobs:
  cargo-deny:
    runs-on: ubuntu-22.04
    strategy:
      matrix:
        checks:
          - advisories
          - bans licenses sources

    # Prevent sudden announcement of a new advisory from failing ci:
    continue-on-error: ${{ matrix.checks == 'advisories' }}

    steps:
    - uses: actions/checkout@v4
    - uses: EmbarkStudios/cargo-deny-action@v2
      with:
        command: check ${{ matrix.checks }}
```

## Users

Repositories using this action (PR to add your repo):

* [ash-molten](https://github.com/EmbarkStudios/ash-molten)
* [asn1rs](https://github.com/kellerkindt/asn1rs)
* [cargo-about](https://github.com/EmbarkStudios/cargo-about)
* [cargo-fetcher](https://github.com/EmbarkStudios/cargo-fetcher)
* [Defguard](https://github.com/DefGuard/defguard)
* [gitoxide](https://github.com/Byron/gitoxide)
* [glam-rs](https://github.com/bitshifter/glam-rs)
* [linkerd2-proxy](https://github.com/linkerd/linkerd2-proxy)
* [OctaSine](https://github.com/greatest-ape/OctaSine)
* [PackSquash](https://github.com/ComunidadAylas/PackSquash)
* [physx-rs](https://github.com/EmbarkStudios/physx-rs)
* [smush](https://github.com/gwihlidal/smush-rs)
* [tame-gcs](https://github.com/EmbarkStudios/tame-gcs)
* [tame-oauth](https://github.com/EmbarkStudios/tame-oauth)
* [texture-synthesis](https://github.com/EmbarkStudios/texture-synthesis)
* [tonic](https://github.com/hyperium/tonic)
* ⚡️[dotenv-linter](https://github.com/dotenv-linter/dotenv-linter)
* [wasm-oidc-plugin](https://github.com/antonengelhardt/wasm-oidc-plugin)
* [rama](https://github.com/plabayo/rama)

## Contributing

We welcome community contributions to this project.

Please read our [Contributor Guide](CONTRIBUTING.md) for more information on how to get started.

## License

Licensed under either of

* Apache License, Version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or <http://www.apache.org/licenses/LICENSE-2.0>)
* MIT license ([LICENSE-MIT](LICENSE-MIT) or <http://opensource.org/licenses/MIT>)

at your option.

### Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted for inclusion in the work by you, as defined in the Apache-2.0 license, shall be dual licensed as above, without any additional terms or conditions.
