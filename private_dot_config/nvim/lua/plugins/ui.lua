return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = { char = '▏' },
      scope = {
        enabled = true,
        show_start = true,
        show_end = false,
      },
      exclude = {
        filetypes = {
          'checkhealth', 'NvimTree', 'vim-plug', 'man', 'help',
          'lspinfo', '', 'GV', 'git', 'packer', 'lazy', 'mason',
        },
        buftypes = { 'terminal', 'nofile', 'quickfix', 'prompt' },
      },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
        return function(str)
          local win_width = vim.fn.winwidth(0)
          if hide_width and win_width < hide_width then return '' end
          if trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
            return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
          end
          return str
        end
      end

      require('lualine').setup {
        options = { theme = 'tokyonight' },
        sections = {
          lualine_a = {},
          lualine_b = {
            { 'FugitiveHead', icon = '', fmt = trunc(100, 30, 90) },
            { 'diff' },
            { 'diagnostics' },
          },
          lualine_c = { { 'filename', path = 1 } },
          lualine_x = { { 'filetype', fmt = trunc(100, 30, 90) } },
          lualine_y = { { 'progress', fmt = trunc(90, 30, 50) } },
          lualine_z = { { 'location', fmt = trunc(90, 30, 50) } },
        },
        inactive_sections = {
          lualine_a = { { 'filename', path = 1 } },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {
          lualine_a = { { 'tabs', mode = 3, max_length = vim.o.columns } },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'windows' },
        },
        extensions = { 'fugitive', 'fzf', 'man', 'mundo', 'nvim-dap-ui', 'nvim-tree', 'quickfix' },
      }
    end,
  },
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  'rcarriga/nvim-notify',
  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
  {
    'folke/zen-mode.nvim',
    config = function()
      require('zen-mode').setup {
        window = {
          backdrop = 0.95,
          width = 0.5,
          height = 1,
          options = {
            signcolumn = 'yes',
            number = true,
            relativenumber = false,
            cursorline = true,
            cursorcolumn = false,
            foldcolumn = '0',
            list = false,
          },
        },
      }
    end,
  },
  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup {
        plugins = { marks = false },
        win = { border = 'double' },
      }
    end,
  },
  {
    'karb94/neoscroll.nvim', -- TODO: consider vim.opt.smoothscroll (nvim 0.10+)
    config = function()
      require('neoscroll').setup {}
    end,
  },
  {
    'nacro90/numb.nvim',
    config = function()
      require('numb').setup {
        show_numbers = true,
        show_cursorline = true,
        centered_peeking = true,
      }
    end,
  },
  {
    'tzachar/highlight-undo.nvim',
    config = function()
      require('highlight-undo').setup()
    end,
  },
  {
    'chentoast/marks.nvim',
    config = function()
      require('marks').setup {
        default_mappings = false,
        highlight_unlabeled = true,
        excluded_buftypes = { 'nofile' },
        mappings = {
          set = 'm',
          set_next = 'm,',
          toggle = 'm;',
          next = 'm]',
          prev = 'm[',
          preview = 'm:',
          delete = "d'",
          delete_line = 'd-',
          delete_buf = 'd<space>',
        },
      }
    end,
  },
  {
    'kevinhwang91/nvim-bqf',
    config = function()
      vim.cmd([[
        hi link BqfPreviewBorder Statement
        hi link BqfPreviewBorderPumSearch Statement
        hi link BqfPreviewRange Search
      ]])

      require('bqf').setup({
        auto_enable = true,
        auto_resize_height = true,
        preview = {
          win_height = 12,
          win_vheight = 12,
          delay_syntax = 80,
          border_chars = { '┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█' },
          should_preview_cb = function(bufnr)
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            local fsize = vim.fn.getfsize(bufname)
            if fsize > 100 * 1024 then return false end
            if bufname:match('^fugitive://') then return false end
            return true
          end,
        },
        func_map = {
          open = '<cr>',
          openc = 'O',
          drop = 'o',
          split = '<C-x>',
          vsplit = '<C-v>',
          tabdrop = '',
          tab = 't',
          tabb = 'T',
          tabc = '',
          ptogglemode = 'zp',
          sclear = 'z<Tab>',
          filter = 'zn',
          filterr = 'zN',
          fzffilter = 'zf',
          prevthis = '<',
          nexthist = '>',
        },
        filter = {
          fzf = {
            action_for = { ['ctrl-x'] = 'split', ['ctrl-t'] = 'tab drop' },
            extra_opts = { '--bind', 'ctrl-s:toggle-all', '--prompt', '> ' },
          },
        },
      })
    end,
  },
  'drmingdrmer/vim-toggle-quickfix',
  'kevinhwang91/promise-async',
  {
    'kevinhwang91/nvim-fundo',
    dependencies = { 'kevinhwang91/promise-async' },
    config = function()
      require('fundo').setup()
    end,
  },
  {
    'OXY2DEV/markview.nvim',
    lazy = false,
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
  },
}
