# Neovim 0.12 Kickstart configuration

This configuration is based on Kickstart `master` commit `626c660f54054953e630bef85fdf65e159c7516a` (2026-08-19).

## Ownership

- Python: `ty` owns language intelligence; Ruff owns diagnostics/code actions; Conform runs Ruff import sorting and formatting; debugpy owns debugging.
- Java: `ftplugin/java.lua` starts `nvim-jdtls`; do not add `jdtls` to `vim.lsp.enable()`. JDTLS owns formatting; java-debug and java-test provide DAP/test support.
- Rust: rustaceanvim alone starts rust-analyzer; do not add `rust_analyzer` to `vim.lsp.enable()`. rust-analyzer runs Clippy; Conform runs rustfmt; CodeLLDB owns debugging.
- JSON: Conform runs jq.
- Markdown: nvim-lint runs markdownlint-cli2.

## Install

Requirements: Neovim 0.12+, Git, Make, unzip, a C compiler, the tree-sitter CLI, Java 21+, Node.js/npm, ripgrep, fd, and a Nerd Font if icons are desired.

Install Rust tools outside Mason so they stay aligned with the active Rust toolchain:

```sh
rustup component add rust-analyzer rustfmt clippy rust-src
```

Back up the existing configuration, then copy this `nvim` directory to `~/.config/nvim`. Start Neovim twice: the first run installs plugins and Mason tools; the second loads every installed tool. Run:

```vim
:checkhealth
:checkhealth rustaceanvim
:Mason
:LspInfo
:ConformInfo
```

Update plugins with `:lua vim.pack.update()` and commit `nvim-pack-lock.json` after accepting updates.

If Mason reports npm `EPERM`, the npm cache is not writable. Start Neovim with a writable cache (for example `npm_config_cache=~/.cache/npm nvim`) or repair that cache's ownership before retrying `:MasonToolsInstallSync`.

## Main keys

- `<leader>e`: toggle Neo-tree; `<leader>E`: reveal the current file.
- `<leader>sg`, `<leader>sd`: Telescope grep and diagnostics; `gO`, `gW`: document/workspace symbols.
- `]h`, `[h`, `<leader>hs`, `<leader>hr`, `<leader>hp`, `<leader>hb`: Git hunks.
- `<leader>f`: format; `<F5>/<F10>/<F11>/<F12>`: debug; `<leader>du`: DAP UI.
- `<leader>jo`, `<leader>jt`, `<leader>jT`: Java imports, nearest test, test class.

## Verification performed

- Neovim 0.12.4 loaded every plugin from a clean, isolated data directory.
- Python opened with exactly one `ty` client and one `ruff` client.
- Two Java buffers in one Maven project shared exactly one `jdtls` client.
- Ruff import sorting/formatting, jq formatting, and markdownlint-cli2 diagnostics ran successfully.
- `:checkhealth rustaceanvim` found no configuration or plugin conflict. Runtime attachment still requires the `rust-analyzer` prerequisite above.
