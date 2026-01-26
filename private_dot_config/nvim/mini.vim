set nocompatible
filetype plugin indent on
syntax on
set hidden

call plug#begin('~/.config/nvim/plugged')

" Plug 'nvim-zh/colorful-winsep.nvim'
" Plug 'kyazdani42/nvim-tree.lua'

call plug#end()

lua << EOF
vim.cmd('autocmd VimResume * checktime')

-- require("colorful-winsep").setup({
--   highlight = {
--     -- bg = "#16161E",
--     -- fg = "#1F3442",
--   },
--   no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest" },
--   events = { "VimResume", "WinEnter", "BufEnter", "WinResized", "WinClosed", "VimResized", "SessionLoadPost" },
--   -- events = { "WinEnter", "WinResized", "SessionLoadPost" },
--   -- event = { "WinNew" },
--   symbols = { "─", "│", "┌", "┐", "└", "┘" },
-- })

-- require('nvim-tree').setup {
--   git = {
--     ignore = false,
--   },
--   disable_netrw       = false,
--   hijack_netrw        = false,
--   hijack_cursor       = true,
--   reload_on_bufenter  = true,
--   diagnostics = {
--     enable = true,
--   },
--   hijack_directories   = {
--     enable = true,
--     auto_open = false,
--   },
--   update_focused_file = {
--     enable      = false,
--     update_cwd  = false,
--     ignore_list = {}
--   },
--   filters = {
--     custom = {} -- list of string that will not be shown
--   },
--   view = {
--     side = 'left',
--     width = 45,
--     float = {
--       enable = false,
--       open_win_config = {
--         relative = "editor",
--         border = "rounded",
--         width = 30,
--         height = 30,
--         row = 1,
--         col = 1,
--       },
--     },
--   },
--   renderer = {
--     highlight_git = true,
--     highlight_opened_files = "icon",
--     icons = {
--       web_devicons = {
--         file = {
--           enable = true,
--           color = true,
--         },
--         folder = {
--           enable = false,
--           color = true,
--         },
--       },
--       git_placement = "before",
--       modified_placement = "after",
--       diagnostics_placement = "signcolumn",
--       bookmarks_placement = "signcolumn",
--       padding = " ",
--       symlink_arrow = " ➛ ",
--       show = {
--         file = true,
--         folder = true,
--         folder_arrow = true,
--         git = true,
--         modified = true,
--         diagnostics = true,
--         bookmarks = true,
--       },
--       glyphs = {
--         -- https://www.nerdfonts.com/cheat-sheet
--         folder = {
--           -- arrow_closed = ">",
--           arrow_closed = "",
--           -- arrow_closed = "",
--           arrow_open = "",
--         },
--       },
--     },
--   },
--   actions = {
--     change_dir = {
--       enable = true,
--       global = false,
--     },
--     open_file = {
--       quit_on_open = false,
--       window_picker = {
--         enable = false,
--         chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
--         exclude = {
--           filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame", },
--           buftype  = { "nofile", "terminal", "help", },
--         }
--       }
--     }
--   }
-- }

EOF
