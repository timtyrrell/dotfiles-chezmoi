return {
  'github/copilot.vim',
  'nvim-lua/plenary.nvim',
  { 'romgrk/fzy-lua-native', build = 'make' },
  'MunifTanjim/nui.nvim',
  {
    'vuki656/package-info.nvim',
    config = function()
      require('package-info').setup({
        hide_up_to_date = true,
        package_manager = 'yarn',
      })
    end,
  },
  'christoomey/vim-tmux-navigator',
  'christoomey/vim-system-copy',
  'tmux-plugins/vim-tmux',
  'preservim/vimux',
  'tyru/open-browser.vim',
  'voldikss/vim-browser-search',
  {
    'rmagatti/auto-session',
    lazy = false,
    opts = {
      suppressed_dirs = { '~/', '~/Downloads', '~/code', '~/code/timtyrrell', '~/code/brandfolder' },
      git_use_branch_name = true,
      git_auto_restore_on_branch_change = true,
      log_level = 'error',
    },
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  {
    'oysandvik94/curl.nvim',
    cmd = { 'CurlOpen' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = true,
  },
  {
    'mistweaverco/kulala.nvim',
    keys = {
      { '<leader>Rs', desc = 'Send request' },
      { '<leader>Ra', desc = 'Send all requests' },
      { '<leader>Rb', desc = 'Open scratchpad' },
    },
    ft = { 'http', 'rest' },
    opts = {
      global_keymaps = false,
      global_keymaps_prefix = '<leader>R',
      kulala_keymaps_prefix = '',
    },
  },
}
