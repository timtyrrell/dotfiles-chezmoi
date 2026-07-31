# dotfiles
My personal and current dotfiles managed by [chezmoi](https://www.chezmoi.io/)

Current tools I am using daily:
[kitty](https://sw.kovidgoyal.net/kitty/)
[tmux HEAD](https://github.com/tmux/tmux)
[neovim HEAD](https://github.com/neovim/neovim)
[zsh](https://www.zsh.org/)

## Homebrew packages

`dot_Brewfile` deploys to `~/.Brewfile` and lists installed taps, formulae, and casks.

- On a new machine, after `chezmoi apply`: `brew-install` (`brew bundle install --global`)
- After installing/removing packages, regenerate it: `brew-dump` (`brew bundle dump --global --force --describe`), then review the diff and `chezmoi add ~/.Brewfile`

## setup/

Files in `setup/` are version-controlled but listed in `.chezmoiignore`, so `chezmoi apply` never writes them anywhere. They're app-specific artifacts kept for rebuilding a machine, imported through each app's own UI.

- `Default.bttpreset` — [BetterTouchTool](https://folivora.ai/) preset. Import via BTT Preferences → Presets → `+`. Re-export from the same panel to update. Note that global-trigger launch paths are absolute; the Google Meet entry points at `~/Applications/Chrome Apps.localized/`, which only exists once that Chrome app shortcut is recreated.
