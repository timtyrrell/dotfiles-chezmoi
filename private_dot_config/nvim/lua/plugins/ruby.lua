local map = vim.keymap.set

return {
  {
    'tpope/vim-rails',
    event = 'VeryLazy',
    config = function()
      -- Rails-specific fzf file finding
      map('n', '<Leader>ea', ':Files app/assets<CR>', { silent = true })
      map('n', '<Leader>ec', ':Files app/controllers<CR>', { silent = true })
      map('n', '<Leader>eh', ':Files app/helpers<CR>', { silent = true })
      map('n', '<Leader>ei', ':Files config/initializers<CR>', { silent = true })
      map('n', '<Leader>ej', ':Files app/javascript<CR>', { silent = true })
      map('n', '<Leader>em', ':Files app/models<CR>', { silent = true })
      map('n', '<Leader>es', ':Files spec<CR>', { silent = true })
      map('n', '<Leader>ev', ':Files app/views<CR>', { silent = true })
    end,
  },
  'tpope/vim-rake',
  'tpope/vim-bundler',
  'tpope/vim-apathy',
}
