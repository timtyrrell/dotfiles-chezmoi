return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = false,
    build = ':TSUpdate',
    dependencies = {
      {
        'abecodes/tabout.nvim',
        config = function()
          require('tabout').setup {
            act_as_tab = true,
            act_as_shift_tab = false,
            default_tab = '<C-t>',
            default_shift_tab = '<C-d>',
            enable_backwards = true,
            completion = false,
          }
        end,
      },
      -- 'JoosepAlviste/nvim-ts-context-commentstring', -- TODO: uncomment after upstream fixes nvim 0.12 compat (PR #124)
      'nvim-treesitter/nvim-treesitter-textobjects',
      'mfussenegger/nvim-treehopper',
      'RRethy/nvim-treesitter-endwise',
      'windwp/nvim-ts-autotag',
    },
    config = function()
      require('nvim-treesitter.configs').setup {
        auto_install = true,
        ensure_installed = {
          'bash', 'css', 'embedded_template', 'graphql', 'html', 'http',
          'javascript', 'jsdoc', 'json', 'jsonc', 'lua', 'regex', 'ruby',
          'tsx', 'typescript', 'vimdoc',
        },
        ignore_install = { 'phpdoc', 'comment' },
        endwise = { enable = true },
        highlight = { enable = true },
        indent = { enable = true },
        matchup = { enable = true },
        autotag = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['aS'] = '@statement.outer',
              ['iS'] = '@statement.inner',
              ['aC'] = '@conditional.outer',
              ['iC'] = '@conditional.inner',
              ['aL'] = '@loop.outer',
              ['iL'] = '@loop.inner',
              ['am'] = '@call.outer',
              ['im'] = '@call.inner',
              ['iP'] = '@parameter.inner',
              ['aP'] = '@parameter.outer',
            },
            selection_modes = {
              ['@parameter.outer'] = 'v',
              ['@function.outer'] = 'V',
              ['@class.outer'] = '<c-v>',
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
        },
        query_linter = {
          enable = false,
          use_virtual_text = true,
          lint_events = { 'BufWrite', 'CursorHold' },
        },
      }
    end,
  },
}
