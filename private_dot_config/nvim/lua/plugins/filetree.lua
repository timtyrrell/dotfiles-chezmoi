return {
  {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup {
        git = { ignore = false },
        disable_netrw = false,
        hijack_netrw = false,
        hijack_cursor = true,
        reload_on_bufenter = true,
        diagnostics = { enable = true },
        hijack_directories = {
          enable = true,
          auto_open = false,
        },
        update_focused_file = {
          enable = false,
          update_cwd = false,
          ignore_list = {},
        },
        filters = { custom = {} },
        view = {
          side = 'left',
          width = 45,
          float = {
            enable = false,
            open_win_config = {
              relative = 'editor',
              border = 'rounded',
              width = 30,
              height = 30,
              row = 1,
              col = 1,
            },
          },
        },
        renderer = {
          highlight_git = true,
          highlight_opened_files = 'icon',
          icons = {
            web_devicons = {
              file = { enable = true, color = true },
              folder = { enable = false, color = true },
            },
            git_placement = 'before',
            modified_placement = 'after',
            diagnostics_placement = 'signcolumn',
            bookmarks_placement = 'signcolumn',
            padding = ' ',
            symlink_arrow = ' ➛ ',
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
              modified = true,
              diagnostics = true,
              bookmarks = true,
            },
            glyphs = {
              folder = {
                arrow_closed = '',
                arrow_open = '',
              },
            },
          },
        },
        actions = {
          change_dir = { enable = true, global = false },
          open_file = {
            quit_on_open = false,
            window_picker = {
              enable = false,
              chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
              exclude = {
                filetype = { 'notify', 'packer', 'qf', 'diff', 'fugitive', 'fugitiveblame' },
                buftype = { 'nofile', 'terminal', 'help' },
              },
            },
          },
        },
      }
    end,
  },
  {
    'nvim-mini/mini.files',
    config = function()
      require('mini.files').setup({
        mappings = {
          close = 'q',
          go_in = 'l',
          go_in_plus = 'L',
          go_out = 'h',
          go_out_plus = 'H',
          reset = '<BS>',
          reveal_cwd = '@',
          show_help = 'g?',
          synchronize = '=',
          trim_left = '<',
          trim_right = '>',
        },
        options = { use_as_default_explorer = false },
        windows = {
          preview = false,
          width_focus = 50,
          width_nofocus = 15,
          width_preview = 25,
        },
      })
      vim.keymap.set('n', '-', '<CMD>lua MiniFiles.open()<CR>', { desc = 'Open cwd' })
      vim.keymap.set('n', '<Leader>-', '<CMD>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>', { desc = 'Open directory of current file' })
    end,
  },
}
