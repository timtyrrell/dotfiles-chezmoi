return {
  -- NOTE: vim-commentary removed — Neovim 0.10+ has built-in gc/gcc commenting
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'tpope/vim-unimpaired',
  'tpope/vim-abolish',
  'tpope/vim-eunuch',
  'tpope/vim-sleuth',
  'tpope/vim-projectionist',
  'tpope/vim-apathy',
  'tpope/vim-rails',
  'tpope/vim-rake',
  'tpope/vim-bundler',
  'tpope/vim-scriptease',
  {
    'kana/vim-textobj-user',
    dependencies = {
      'kana/vim-textobj-line',
      'michaeljsmith/vim-indent-object',
      'rhysd/vim-textobj-anyblock',
    },
  },
  'gabrielpoca/replacer.nvim',
  {
    'windwp/nvim-spectre',
    config = function()
      require('spectre').setup()
    end,
  },
  'mileszs/ack.vim',
  { 'nvim-mini/mini.splitjoin', version = '*' },
  {
    'mcauley-penney/tidy.nvim',
    config = function()
      require('tidy').setup()
    end,
  },
  'meain/vim-printer',
  'AndrewRadev/undoquit.vim',
  'kazhala/close-buffers.nvim',
  'barrett-ruth/import-cost.nvim',
  {
    'sheerun/vim-polyglot',
    init = function()
      vim.g.polyglot_disabled = { 'autoindent' }
      vim.g.markdown_fenced_languages = { 'ruby', 'sh', 'javascript', 'typescript', 'json' }
    end,
  },
}
