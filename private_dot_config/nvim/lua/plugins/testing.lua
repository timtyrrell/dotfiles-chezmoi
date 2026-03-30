return {
  'vim-test/vim-test',
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
