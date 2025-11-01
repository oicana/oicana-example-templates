# Oicana example templates

This repository contains example Oicana templates. These templates can be packed with the Oicana CLI and used to create documents through integrations.

See the documentation for more info: https://docs.oicana.com

## Setup

You should set up an IDE with support for Typst for intelli sense and live previews. There are a couple options, but for the sake of simplicity the following documents the setup for VS Code:

1. Get/install VS Code https://code.visualstudio.com/download
2. Install the `Tinymist Typst` and `Even Better TOML` plugins
3. Open the entrypoint file of the template you would like a preview for
    - Open the [Command Palette](https://code.visualstudio.com/api/ux-guidelines/command-palette) ([Ctrl + Shift + P](https://code.visualstudio.com/shortcuts/keyboard-shortcuts-windows.pdf))
    - Search and select the command "Typst Preview: preview current file"
    - alternatively use the preview key binding `Ctrl + K V`

You can repeat `3.` for multiple templates. Any change in a template will trigger a rerender of the preview.

The preview is interactive. For most parts of the output you can click to jump to the relevant position in the code.

You can use [typstyle] to format Typst files. After installing according to the projects Readme, run `typstyle -i .` to format all `.typ` files in the repository.

## Minimal example

The minimal Oicana template has no dynamic inputs and consists of two files: `typst.toml` and `main.typ`

The minimal manifest `typst.toml` looks like
```toml
[package]
name = "minimal"
version = "0.1.0"
entrypoint = "main.typ"

[tool.oicana]
manifest_version = 1
```

And the `main.typ` file contains "normal" Typst content:
```typst
= Hello from Typst

This template will always render to the same text.
To use the full potential of Oicana, #link("https://docs.oicana.com/templates/inputs")[introduce some dynamic inputs].
```

## Using the Oicana CLI

To use a template with an integration (the C# package for example), it has to be packed.
Here are some example commands to pack templates:

- `oicana pack --all` to pack all templates in the current directory (including child directories)
- `oicana pack templates/invoice -o packed` to pack the template in the `templates/invoice` directory and put the tar ball into the `packed` directory

For testing purposes, you can also compile (not packed) templates with the Oicana CLI. Compilation output is placed in the `output` directory.
Blob and json inputs can be given as file paths:

- `oicana compile templates/invoice -f png -j invoice=templates/invoice/invoice.json -b banner=templates/invoice/oicana.png`
- `oicana compile templates/table -j data=templates/table/tests/largerTable.json`
- `oicana compile templates/dependency -j data=templates/dependency/sample.json`

Templates [can define snapshot tests][snapshot-tests]. You can run all of the tests for all templates in a directory with `oicana test -a`.


[typstyle]: https://github.com/Enter-tainer/typstyle/
[typst-oicana]: https://github.com/oicana/oicana/tree/main/integrations/typst
[invoice-harness]: https://github.com/oicana/invoice-harness
[snapshot-tests]: https://docs.oicana.com/templates/tests
