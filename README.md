# qFioofa-LazyGit

Personal LazyGit config. **yugen-ash** theme

```
src/config.yml              # GUI, diff pagers, keybindings, custom commands
src/themes/palette.yml      # yugen-ash palette reference
src/themes/yugen-ash.yml    # theme → lazygit color mapping
scripts/deploy.sh           # merge src/ → ~/.config/lazygit/config.yml
```

## Diff rendering

The main diff uses `delta` with syntax highlighting, palette-matched colors and
clickable line numbers. Press `|` (or `\`) to cycle through the configured
renderers: `delta` → `delta --side-by-side` → `difft` → built-in.

Inside a diff, `h`/`l` (or `←`/`→`) jump between hunks; `J`/`K` scroll the whole
view. `{`/`}` change context, `<ctrl+w>` toggles whitespace.

## Deploy

With Home Manager, rebuild the flake that imports this module (`nix flake update`
if needed, then `home-manager switch`). The module also installs `lazygit`,
`delta`, `difftastic`, `bat`, `gitflow`, `gh`, `wl-clipboard` and `xdg-utils`.

Without Home Manager, run:

```sh
scripts/deploy.sh
```

Lazygit auto-loads only a single `config.yml`, so deploy deep-merges the `src/`
modules (`config.yml` + every `themes/*.yml`) into
`~/.config/lazygit/config.yml`. Needs `python3` and a Nerd Font. Clipboard
integration uses `wl-copy`/`wl-paste` (Wayland).

## Credits

- Neovim editor integration (`os` settings): [phtea/dotfiles](https://github.com/phtea/dotfiles/blob/main/lazygit/.config/lazygit/config.yml).
