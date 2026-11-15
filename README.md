# qFioofa-LazyGit

Personal LazyGit config. **yugen-ash** theme

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

## Credits

- Neovim editor integration (`os` settings): [phtea/dotfiles](https://github.com/phtea/dotfiles/blob/main/lazygit/.config/lazygit/config.yml).
