return {
  -- NOTE: vim-commentary removed — Neovim 0.10+ has built-in gc/gcc commenting
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'tpope/vim-unimpaired', -- [n/]n conflict nav, yo* toggles not in nvim 0.11+
  'tpope/vim-abolish',
  {
    'tpope/vim-eunuch',
    init = function() vim.g.eunuch_no_maps = 1 end,
  },
  'tpope/vim-sleuth',
  {
    'tpope/vim-projectionist',
    event = 'VeryLazy',
    init = function()
      vim.g.projectionist_ignore_term = 1
      vim.g.rails_projections = {
        ['app/views/*.html.slim'] = {
          type = 'view',
          alternate = 'app/controllers/{dirname}_controller.rb',
        },
      }
      vim.g.projectionist_heuristics = {
        ['package.json'] = {
          ['*.js'] = {
            alternate = {
              '{dirname}/{basename}.test.js',
              '{dirname}/../{basename}.js',
              '{dirname}/__tests__/{basename}.js',
              '{dirname}/__tests__/{basename}.test.js',
            },
            related = {
              '{dirname}/{basename}.module.scss',
              '{dirname}/styles/{basename}.module.scss',
            },
            type = 'jssource',
          },
          ['*.test.js'] = {
            alternate = { '{dirname}/{basename}.js', '{dirname}/../{basename}.js' },
            type = 'jstest',
          },
          ['*.ts'] = {
            alternate = {
              '{dirname}/{basename}.test.ts',
              '{dirname}/../{basename}.ts',
              '{dirname}/__tests__/{basename}.ts',
              '{dirname}/__tests__/{basename}.test.ts',
              '{dirname}/../../__tests__/{basename}.test.ts',
              '{dirname}/../../__tests__/api/{basename}.test.ts',
            },
            related = {
              '{dirname}/{basename}.module.scss',
              '{dirname}/styles/{basename}.module.scss',
            },
            type = 'tssource',
          },
          ['*.test.ts'] = {
            alternate = {
              '{dirname}/{basename}.ts',
              '{dirname}/../{basename}.ts',
              '{dirname}/../../pages/{basename}.ts',
              '{dirname}/../../pages/api/{basename}.ts',
            },
            type = 'tstest',
          },
          ['*.jsx'] = {
            alternate = {
              '{dirname}/{basename}.test.jsx',
              '{dirname}/__tests__/{basename}.jsx',
              '{dirname}/__tests__/{basename}.test.jsx',
              '{dirname}/../{basename}.jsx',
            },
            related = {
              '{dirname}/{basename}.module.scss',
              '{dirname}/styles/{basename}.module.scss',
            },
            type = 'jsxsource',
          },
          ['*.test.jsx'] = {
            alternate = { '{dirname}/{basename}.jsx', '{dirname}/../{basename}.jsx' },
            type = 'jsxtest',
          },
          ['*.tsx'] = {
            alternate = {
              '{dirname}/{basename}.test.tsx',
              '{dirname}/../{basename}.tsx',
              '{dirname}/__tests__/{basename}.tsx',
              '{dirname}/__tests__/{basename}.test.tsx',
              '{dirname}/../../__tests__/{basename}.test.tsx',
              '{dirname}/../../__tests__/api/{basename}.test.tsx',
            },
            related = {
              '{dirname}/{basename}.module.scss',
              '{dirname}/styles/{basename}.module.scss',
            },
            type = 'tsxsource',
          },
          ['*.test.tsx'] = {
            alternate = {
              '{dirname}/{basename}.tsx',
              '{dirname}/../{basename}.tsx',
              '{dirname}/../../pages/{basename}.tsx',
              '{dirname}/../../pages/api/{basename}.tsx',
            },
            type = 'tsxtest',
          },
          ['*.scss'] = {
            alternate = {
              '{dirname}/{basename}.js',
              '{dirname}/{basename}.jsx',
              '{dirname}/{basename}.ts',
              '{dirname}/{basename}.tsx',
              '{dirname}/../{basename}.js',
              '{dirname}/../{basename}.jsx',
              '{dirname}/../{basename}.ts',
              '{dirname}/../{basename}.tsx',
            },
            type = 'scss',
          },
          ['package.json'] = {
            alternate = { 'package-lock.json', 'yarn.lock' },
          },
          ['package-lock.json'] = { alternate = 'package.json' },
          ['yarn.lock'] = { alternate = 'package.json' },
        },
      }
    end,
  },
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
    keys = {
      { '<leader>S', function() require('spectre').open() end },
      { '<leader>sw', function() require('spectre').open_visual({ select_word = true }) end },
      { '<leader>s', function() require('spectre').open_visual() end, mode = 'v' },
      { '<leader>sp', "viw:lua require('spectre').open_file_search()<cr>" },
    },
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
  {
    'meain/vim-printer',
    init = function()
      vim.g.vim_printer_print_below_keybinding = '<leader>cl'
      vim.g.vim_printer_print_above_keybinding = '<leader>cL'
      vim.g.vim_printer_items = {
        javascript = "console.log('{$}:', {$});",
        typescriptreact = "console.log('{$}:', {$});",
        typescript = "console.log('{$}:', {$});",
        javascriptreact = "console.log('{$}:', {$});",
        ruby = 'puts "{$}", {$}',
        eruby = '<%= puts "{$}", {$} %>',
        slim = 'puts "{$}", {$}',
      }
    end,
  },
  'AndrewRadev/undoquit.vim',
  {
    'kazhala/close-buffers.nvim',
    keys = {
      { '<leader>bdo', ':BDelete other<CR>', mode = '' },
      { '<leader>bdh', ':BDelete hidden<CR>', mode = '' },
      { '<leader>bda', ':BDelete all<CR>', mode = '' },
      { '<leader>bdt', ':BDelete this<CR>', mode = '' },
      { '<leader>bdn', ':BDelete nameless<CR>', mode = '' },
    },
  },
  {
    'barrett-ruth/import-cost.nvim',
    init = function()
      vim.g.import_cost = { package_manager = 'yarn' }
    end,
  },
}
