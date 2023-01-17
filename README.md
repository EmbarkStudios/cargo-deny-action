<!-- action-docs-description -->

## Description

Help manage Cargo crate dependencies and validate licenses

<!-- action-docs-description -->

<!-- action-docs-inputs -->

## Inputs

| parameter         | description                                                                                                   | required | default        |
| ----------------- | ------------------------------------------------------------------------------------------------------------- | -------- | -------------- |
| command           | The command to run with cargo-deny                                                                            | `false`  | check          |
| arguments         | The arguments to pass to cargo-deny                                                                           | `false`  | --all-features |
| command-arguments | The arguments to pass to the command                                                                          | `false`  |                |
| log-level         | The log level for cargo-deny                                                                                  | `false`  | warn           |
| rust-version      | The Rust version that is updated to before running cargo deny                                                 | `false`  | stable         |
| credentials       | The git credentials for credential.helper store using github username and github's private access token (PAT) | `false`  |                |

<!-- action-docs-inputs -->

<!-- action-docs-outputs -->

<!-- action-docs-outputs -->

<!-- action-docs-runs -->

## Runs

This action is a `composite` action.

<!-- action-docs-runs -->
