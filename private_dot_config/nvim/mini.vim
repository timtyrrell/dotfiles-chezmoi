set nocompatible
filetype plugin indent on
syntax on
set hidden

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
