set nocompatible
filetype plugin indent on
syntax on
set hidden

"sessions
set sessionoptions-=buffers
set sessionoptions-=help
set sessionoptions-=folds
set sessionoptions-=blank

" nvim/shada is dumb with marks, don't save for new session
" https://www.reddit.com/r/neovim/comments/q7bgwo/comment/hghwogp/?context=3
set shada=!,'0,f0,<50,s10,h

call plug#begin('~/.config/nvim/plugged')

Plug 'rmagatti/auto-session'

call plug#end()

lua << EOF

require('auto-session').setup {
  -- cwd_change_handling = {
  --   restore_upcoming_session = false,
  -- },
  log_level = 'info',
  auto_session_enabled = true,
  auto_save_enabled = true,
  auto_restore_enabled = true,
  auto_session_use_git_branch = true,
  auto_session_suppress_dirs = {'~/', '~/code', '~/code/timtyrrell', '~/code/brandfolder'},
  -- auto_session_allow_dirs = {'~/code/*', '~/.local/share/chezmoi'},
  -- pre_save_cmds = {"lua require'nvim-tree'.setup()", "tabdo NvimTreeClose", "BDelete! nameless", "BDelete! hidden", "BDelete glob=yode*", "cclose"}
}

EOF
