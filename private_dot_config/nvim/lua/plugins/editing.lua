return {
  -- NOTE: vim-commentary removed — Neovim 0.10+ has built-in gc/gcc commenting
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'tpope/vim-unimpaired', -- [n/]n conflict nav, yo* toggles not in nvim 0.11+
  'tpope/vim-abolish',
  'tpope/vim-eunuch',
  'tpope/vim-sleuth',
  'tpope/vim-projectionist',
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
  {
    'mhinz/vim-grepper',
    cmd = { 'Grepper', 'GrepperRg' },
    keys = {
      { '<leader><bs>', '<cmd>Grepper -tool rg -cword -nojump<cr>' },
      { '<space><bs>', '<cmd>Grepper -tool rg -cword -nojump -buffers<cr>' },
      { 'gs', '<plug>(GrepperOperator)', mode = { 'n', 'x' } },
    },
  },
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
}
