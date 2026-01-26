# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managed by [chezmoi](https://www.chezmoi.io/). The repository contains configuration files for:
- **Shell**: zsh with zcomet plugin manager and powerlevel10k theme
- **Editor**: Multiple neovim configurations (full, minimal, single-file)
- **Terminal**: kitty terminal emulator and tmux multiplexer
- **Tools**: bat, eza, ranger, and various CLI utilities

## Chezmoi File Naming Conventions

Files in this repository follow chezmoi naming conventions:
- `dot_filename` → `.filename` in target directory
- `private_dot_config/` → `.config/` with private permissions
- `empty_filename` → creates empty file
- `executable_filename` → creates executable file

## Common Commands

### Chezmoi Management
```bash
# Apply changes to target files
chezmoi apply

# See what changes would be applied
chezmoi diff

# Add a new dotfile to management
chezmoi add ~/.filename

# Edit a managed file
chezmoi edit ~/.filename

# Update from source and apply
chezmoi update
```

### Neovim Configurations

Multiple nvim configurations are available via aliases:
- `nvim` - Full configuration with lazy.nvim plugin manager
- `nm` - Minimal configuration (`mini.vim`)
- `nn` - Full config without auto-session
- `no` - No configuration at all
- `np` - No plugins
- `nv` - LSP-focused configuration

The main configuration uses lazy.nvim and is organized with:
- `init.lua` - Main modular configuration
- `init-single.lua` - Single-file configuration
- `plugin/` - Plugin-specific configurations
- `after/ftplugin/` - File-type specific settings

### Shell Utilities

Key aliases and functions available:
- `ls` → `eza` with icons and git status
- `cat` → `bat` with syntax highlighting
- `gw_add()` - Create git worktree
- `gw_add_branch()` - Create git worktree from branch with file sync

## Architecture Notes

### Neovim Plugin Structure
- Uses lazy.nvim for plugin management
- Modular configuration in `plugin/` directory
- File-type specific configurations in `after/ftplugin/`
- Custom snippets organized by language in `ultisnips/`

### Shell Configuration
- Main zsh configuration loads zcomet plugin manager
- Aliases organized in `zsh/aliases.zsh`
- Git utilities in `zsh/utils.zsh`
- Performance debugging tools included for zsh startup optimization

### Terminal Setup
- Kitty terminal with custom configuration
- Tmux with Tokyo Night theme
- Integrated with various CLI tools (eza, bat, ranger)