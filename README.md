# Tribufu Rust

Open source Rust SDK for the public Tribufu API at `https://api.tribufu.com`.

[![MIT License][mit-badge]][mit-url]
[![Discord Chat][discord-badge]][discord-url]

[mit-badge]: https://img.shields.io/badge/license-MIT-blue.svg
[mit-url]: https://github.com/Tribufu/TribufuRust/blob/main/LICENSE.txt
[discord-badge]: https://img.shields.io/discord/276504514616623104.svg?logo=discord&style=flat-square
[discord-url]: https://www.tribufu.com/discord

[Website](https://www.tribufu.com) |
[Discord](https://www.tribufu.com/discord)

## Development

Use Rust 1.88 or newer. The Cargo package is `tribufu-sdk`; the library is imported as `tribufu`.

```sh
cargo build --workspace
cargo test --workspace
```

Generate bindings from the public API with `./scripts/windows/generate.ps1`. Its default schema is
`https://api.tribufu.com/openapi.json`; `-Spec <path-or-url>` selects another OpenAPI document.
`./scripts/windows/publish.ps1` publishes the `tribufu-sdk` package.

## License

This project is licensed under the [MIT License].

[MIT License]: https://github.com/Tribufu/TribufuRust/blob/main/LICENSE.txt
