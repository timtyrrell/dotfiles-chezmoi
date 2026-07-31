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
