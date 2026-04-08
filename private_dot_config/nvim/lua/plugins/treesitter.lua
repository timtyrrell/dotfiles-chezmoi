return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
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
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-textobjects',
      {
        'mfussenegger/nvim-treehopper',
        keys = {
          { 'm', "<Cmd>lua require('tsht').nodes()<CR>", mode = 'o', silent = true },
          { 'm', ":lua require('tsht').nodes()<CR>",     mode = 'x', silent = true },
        },
      },
      'RRethy/nvim-treesitter-endwise',
      'windwp/nvim-ts-autotag',
    },
    config = function()
      vim.g.vim_jsx_pretty_colorful_config = 1

      -- main branch: nvim-treesitter is a parser/query manager only
      -- highlight + indent are built-in on nvim 0.12
      -- parsers: install via :TSInstall

      local select = require('nvim-treesitter-textobjects.select')
      local move = require('nvim-treesitter-textobjects.move')

      require('nvim-treesitter-textobjects').setup {
        select = {
          lookahead = true,
          selection_modes = {
            ['@parameter.outer'] = 'v',
            ['@function.outer'] = 'V',
            ['@class.outer'] = '<c-v>',
          },
        },
        move = {
          set_jumps = true,
        },
      }

      -- select keymaps
      local select_maps = {
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
      }
      for key, query in pairs(select_maps) do
        vim.keymap.set({ 'x', 'o' }, key, function()
          select.select_textobject(query, 'textobjects')
        end)
      end

      -- move keymaps
      local move_maps = {
        { ']m', move.goto_next_start,     '@function.outer' },
        { ']]', move.goto_next_start,     '@class.outer' },
        { ']M', move.goto_next_end,       '@function.outer' },
        { '][', move.goto_next_end,       '@class.outer' },
        { '[m', move.goto_previous_start, '@function.outer' },
        { '[[', move.goto_previous_start, '@class.outer' },
        { '[M', move.goto_previous_end,   '@function.outer' },
        { '[]', move.goto_previous_end,   '@class.outer' },
      }
      for _, map in ipairs(move_maps) do
        vim.keymap.set({ 'n', 'x', 'o' }, map[1], function()
          map[2](map[3], 'textobjects')
        end)
      end
    end,
  },
}
