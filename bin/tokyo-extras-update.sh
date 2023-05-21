# bat
cp ~/.config/nvim/plugged/tokyonight.nvim/extras/sublime/* ~/.config/bat/themes/
cd "$(bat --config-dir)/themes"
bat cache --build

# kitty
cp ~/.config/nvim/plugged/tokyonight.nvim/extras/kitty/* ~/.config/kitty/

# tmux
cp ~/.config/nvim/plugged/tokyonight.nvim/extras/tmux/* ~/.tmux/themes/
