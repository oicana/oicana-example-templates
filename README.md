# Oicana example templates

> Note: while the [oicana package](https://github.com/oicana/oicana/tree/main/integrations/typst) is not published on the Typst Universe yet, the tempalates in this repository require it to be installed locally. Please follow [the instructions on the website for how to install a Typst package locally](https://docs.oicana.com/oicana-templates/dependencies).

This repository contains Oicana templates for generating documents.

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


### Formatting

You can use [typstyle] to format Typst files. After installing according to the Projects Readme, run `typstyle -i .` to format all `.typ` files in the repository.

## Using the Oicana CLI

Example commands to compile templates:

- `oicana compile templates/invoice -f pdf -j invoice=templates/invoice/invoice.json -b banner=templates/invoice/oicana.png`
- `oicana compile templates/test -j data=templates/test/sample.json`
- `oicana compile templates/dependency -j data=templates/package/sample.json`

Example commands to package templates:

- `oicana pack --all` to pack all templates in the current directory (including child directories)
- `oicana pack templates/invoice -o packed` to pack the template in the `templates/invoice` directory and put the tar ball into the `packed` directory

Run the snapshot tests: `oicana test -a`


[typstyle]: https://github.com/Enter-tainer/typstyle/
[typst-oicana]: https://github.com/oicana/oicana/tree/main/integrations/typst
[invoice-harness]: https://github.com/oicana/invoice-harness
