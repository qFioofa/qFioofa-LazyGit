# qFioofa-LazyGit

Personal LazyGit config. **yugen-ash** theme, modular layout mirroring the
[wezterm](../wezterm) config.

```
src/config.yml              # decoration/GUI (borders, icons, layout)
src/themes/palette.yml      # yugen-ash palette reference
src/themes/yugen-ash.yml    # theme → lazygit color mapping
scripts/deploy.sh           # merge src/ → ~/.config/lazygit/config.yml
```

## Deploy

```sh
scripts/deploy.sh
```

Lazygit auto-loads only a single `config.yml`, so deploy deep-merges the `src/`
modules (`config.yml` + every `themes/*.yml`) into
`~/.config/lazygit/config.yml`. Needs `python3` and a Nerd Font.
