return {
  {
    'vim-test/vim-test',
    event = 'VeryLazy',
    init = function()
      vim.g['test#ruby#rspec#executable'] = 'bundle exec rspec'
      vim.g['test#strategy'] = 'vimux'
      vim.g['test#typescriptreact#jest#options'] = {
        nearest = '--backtrace',
        file = '--format documentation',
        suite = '--tag ~slow',
      }
    end,
    keys = {
      { '<leader>tt', ':TestNearest<CR>', silent = true },
      { '<leader>tf', ':TestFile<CR>', silent = true },
      { '<leader>tl', ':TestLast<CR>', silent = true },
      { '<leader>tv', ':TestVisit<CR>', silent = true },
      -- Note: <leader>ts conflicts with 'tab sp' — keeping both as original
    },
  },
  'tpope/vim-dispatch',
  'David-Kunz/jester',
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        'mfussenegger/nvim-dap-python',
        ft = 'python',
        config = function()
          local py = vim.fn.expand('~/.venvs/debugpy/bin/python')
          require('dap-python').setup(py)
          require('dap-python').test_runner = 'pytest'
        end,
      },
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
    },
    config = function()
      local dapui = require('dapui')
      dapui.setup()
      local dap = require('dap')
      dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
      dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
      dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
    end,
  },
  'nvim-neotest/nvim-nio',
}
