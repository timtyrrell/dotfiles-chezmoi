local map = vim.keymap.set

return {
  {
    'github/copilot.vim',
    event = 'VeryLazy',
    init = function()
      vim.g.copilot_no_tab_map = true
    end,
    config = function()
      map('n', '<Leader>cp', '<cmd>Copilot<CR>', { silent = true })
      map('n', '<Leader>ce', '<cmd>Copilot enable<CR>', { silent = true })
      map('n', '<Leader>cx', '<cmd>Copilot disable<CR>', { silent = true })
      map('i', '<Up>', '<Plug>(copilot-previous)')
      map('i', '<Down>', '<Plug>(copilot-next)')
      map('i', '<Left>', '<Plug>(copilot-dismiss)')
      map('i', '<Right>', "copilot#Accept('<CR>')", { script = true, expr = true, silent = true })
    end,
  },
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
  {
    'christoomey/vim-tmux-navigator',
    init = function()
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end,
  },
  'christoomey/vim-system-copy',
  'tmux-plugins/vim-tmux',
  {
    'preservim/vimux',
    event = 'VeryLazy',
    config = function()
      map('', '<Leader>vv', ':call v:lua.VimuxZoomInspectRunner()<CR>')
      map('', '<Leader>vp', ':VimuxPromptCommand<CR>')
      map('', '<Leader>vl', ':VimuxRunLastCommand<CR>')
      map('', '<Leader>vi', ':VimuxInspectRunner<CR>')
      map('', '<leader>vz', ':VimuxZoomRunner<CR>')
      map('', '<Leader>vq', ':VimuxCloseRunner<CR>')
      map('', '<Leader>v<C-l>', ':VimuxClearTerminalScreen<CR>')
      map('', '<Leader>vc', ':VimuxClearRunnerHistory<CR>')
      map('', '<Leader>vx', ':VimuxInterruptRunner<CR>')

      -- REPL usage
      map('v', '<leader>vs', '"vy :call v:lua.VimuxSlime()<CR>')
      map('n', '<leader>vs', 'vip<leader>vs<CR>')
      map('n', '<leader>vb', 'ggVG<leader>vs<CR>')
      map('n', '<Leader>vf', ':call VimuxRunCommand("clear; node " . bufname("%"))<CR>')
    end,
  },
  {
    'tyru/open-browser.vim',
    init = function()
      vim.g.openbrowser_default_search = 'duckduckgo'
    end,
    keys = {
      { 'gx', '<Plug>(openbrowser-smart-search)', mode = 'n' },
      { 'gx', '<Plug>(openbrowser-smart-search)', mode = 'v' },
    },
  },
  {
    'voldikss/vim-browser-search',
    init = function()
      vim.g.browser_search_default_engine = 'duckduckgo'
    end,
    keys = {
      { '<Leader>bs', '<Plug>SearchNormal', mode = 'n', silent = true },
      { '<Leader>bs', '<Plug>SearchVisual', mode = 'v', silent = true },
    },
  },
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
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_force_echo_notifications = 1
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
