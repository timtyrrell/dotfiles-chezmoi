" Plug 'lukas-reineke/indent-blankline.nvim'
" fix blank line color issue
set colorcolumn=99999
if &diff
    let g:indent_blankline_enabled = v:false
endif
let g:indent_blankline_use_treesitter = v:true
" default listchars=tab:>,trail:-,nbsp:+
set list listchars=tab:→\ ,space:⋅,trail:•,nbsp:␣,extends:▶,precedes:◀
" extends:⟩,precedes:⟨,tab:│\ ,eol:, tab:<->
let g:indent_blankline_char = '▏'
" let g:indent_blankline_char_blankline = '┆'
" let g:indent_blankline_char_list = ['|', '¦', '┆', '┊']
let g:indent_blankline_filetype_exclude = ['checkhealth', 'NvimTree', 'vim-plug', 'man', 'help', 'lspinfo', '', 'GV', 'git', 'packer']
let g:indent_blankline_buftype_exclude = ['terminal', 'nofile', 'quickfix', 'prompt']
let g:indent_blankline_bufname_exclude = ['README.md', '.*\.py']
let g:indent_blankline_show_first_indent_level = v:true
let g:indent_blankline_show_trailing_blankline_indent = v:false
let g:indent_blankline_show_current_context = v:true
let g:indent_blankline_show_current_context_start = v:true
let g:indent_blankline_context_patterns = ['declaration', 'expression', 'pattern', 'primary_expression', 'statement', 'switch_body' ,'def', 'class', 'return', '^func', 'method', '^if', 'while', 'jsx_element', 'for', 'object', 'table', 'block', 'arguments', 'else_clause', '^jsx', 'try', 'catch_clause', 'import_statement', 'operation_type', 'with', 'except', 'arguments', 'argument_list', 'dictionary', 'element', 'tuple']

lua << EOF

-- require("ibl").setup({
--   indent = { char = "|" },
--   exclude = { filetypes = { "checkhealth", "NvimTree", "vim-plug", "man", "help", "lspinfo", "GV", "git", "packer" } },
--   buftypes = { "terminal", "nofile", "quickfix", "prompt" },
--   hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
--   -- scope = { exclude = { "" } },
-- })

-- local hooks = require "ibl.hooks"
-- hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)

-- require('beacon').setup({
--   enabled = true, --- (boolean | fun():boolean) check if enabled
--   speed = 2, --- integer speed at wich animation goes
--   width = 40, --- integer width of the beacon window
--   winblend = 70, --- integer starting transparency of beacon window :h winblend
--   fps = 60, --- integer how smooth the animation going to be
--   min_jump = 10, --- integer what is considered a jump. Number of lines
--   cursor_events = { 'CursorMoved' }, -- table<string> what events trigger check for cursor moves
--   window_events = { 'WinEnter', 'FocusGained' }, -- table<string> what events trigger cursor highlight
--   highlight = { bg = 'white', ctermbg = 15 }, -- vim.api.keyset.highlight table passed to vim.api.nvim_set_hl
-- })

EOF

" Plug 'danilamihailov/beacon.nvim'
let g:beacon_ignore_filetypes = ['git', 'startify', 'pr']
let g:beacon_show_jumps = 0
let g:beacon_ignore_buffers = ["Mundo"]
let g:beacon_focus_gained = 1

if !&diff
  let g:beacon_show_jumps = 0
  let g:beacon_ignore_buffers = [
      \ 'Mundo',
      \ '\w*git*\w',
      \ '\w*fugitive*\w',
      \ '\w*defx*\w',
      \ 'fzf',
      \]
endif

" Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
let g:Hexokinase_highlighters = ['backgroundfull']
" let g:Hexokinase_highlighters = ['virtual']
let g:Hexokinase_ftEnabled = ['css', 'html', 'javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'less', 'vim', 'conf', 'tmux', 'gitconfig', 'xml', 'lua', 'stylus', 'sh', 'zsh', 'scss']

" Plug 'iamcco/markdown-preview.nvim'
let g:mkdp_filetypes = ['markdown', 'mermaid']
nmap <leader>mp <Plug>MarkdownPreview
nmap <leader>ms <Plug>MarkdownPreviewStop

" Plug 'ellisonleao/glow.nvim', {'for': 'markdown'}
nmap <leader>mg :Glow<CR>
lua << EOF
require('glow').setup({
  glow_path = "/opt/homebrew/bin/glow",
  border = "rounded",
  width = 220,
  height = 400,
  width_ratio = 0.8,
  height_ratio = 0.8,
})

-- https://github.com/vimwiki/vimwiki/issues/1367#issuecomment-1762420036
-- Put this command in your ftplugin/vimwiki.lua (or autocommand):
-- vim.treesitter.language.register('markdown', 'vimwiki')
-- require("headlines").setup({
--      vimwiki = {
--         query = vim.treesitter.parse_query(
--           "markdown",
--             [[
--                 (atx_heading [
--                     (atx_h1_marker)
--                     (atx_h2_marker)
--                     (atx_h3_marker)
--                     (atx_h4_marker)
--                     (atx_h5_marker)
--                     (atx_h6_marker)
--                 ] @headline)

--                 (thematic_break) @dash

--                 (fenced_code_block) @codeblock

--                 (block_quote_marker) @quote
--                 (block_quote (paragraph (inline (block_continuation) @quote)))
--                 (block_quote (paragraph (block_continuation) @quote))
--                 (block_quote (block_continuation) @quote)
--             ]]
--         ),
--         headline_highlights = { "Headline" },
--         bullet_highlights = {
--             "@text.title.1.marker.markdown",
--             "@text.title.2.marker.markdown",
--             "@text.title.3.marker.markdown",
--             "@text.title.4.marker.markdown",
--             "@text.title.5.marker.markdown",
--             "@text.title.6.marker.markdown",
--         },
--         bullets = { "◉", "○", "✸", "✿" },
--         codeblock_highlight = "CodeBlock",
--         dash_highlight = "Dash",
--         dash_string = "-",
--         quote_highlight = "Quote",
--         quote_string = "┃",
--         fat_headlines = true,
--         fat_headline_upper_string = "▃",
--         fat_headline_lower_string = "🬂",
--     },
-- })

require("tokyonight").setup({
  hide_inactive_statusline = false,
  lualine_bold = true,
  style = "night",
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
  },
  sidebars = { "qf", "help", "NvimTree", "terminal", "dapui_scopes", "dapui_breakpoints", "dapui_stacks", "dapui_watches", "dap-repl", "DiffviewFiles", "dbui" },
  dim_inactive = true,
  on_highlights = function(hl, c)
    -- hl.LeapMatch = { bg = c.magenta2, fg = c.fg, style = "bold" }
    -- hl.LeapLabelPrimary = { fg = c.magenta2, style = "bold" }
    -- hl.LeapLabelSecondary = { fg = c.green1, style = "bold" }
    -- hl.LeapBackdrop = { fg = c.dark3 }
    hl.LeapBackdrop = {
      fg = "#545c7e"
    }
    hl.LeapLabel = {
      bold = true,
      -- fg = "#ff007c"
      fg = "#73daca"
    }
    hl.LeapMatch = {
      bg = "#ff007c",
      bold = true,
      fg = "#c0caf5"
    }
  end
})

EOF
colorscheme tokyonight

lua << EOF

require("colorful-winsep").setup({
  highlight = {
    -- bg = "#16161E",
    -- fg = "#1F3442",
  },
  no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest" },
  events = { "VimResume", "WinEnter", "BufEnter", "WinResized", "WinClosed", "VimResized", "SessionLoadPost", "WinLeave" },
  -- events = { "WinEnter", "WinResized", "SessionLoadPost" },
  -- event = { "WinNew" },
  -- event = { "WinLeave" },
  symbols = { "─", "│", "┌", "┐", "└", "┘" },
})
require("import-cost").setup({})

require("tidy").setup()

require('marks').setup {
  default_mappings = false,
  highlight_unlabeled = true,
  excluded_buftypes = {'nofile'},
  mappings = {
    set = "m",
    set_next = "m,",
    toggle = "m;",
    next = "m]",
    prev = "m[",
    preview = "m:",
    delete = "d'",
    delete_line = "d-",
    delete_buf = "d<space>",
  }
}
-- :MarksToggleSigns - Toggle signs in the buffer
-- :MarksListBuf - Fill the location list with all marks in the current buffer
-- :MarksQFListBuf
-- :MarksListGlobal - Fill the location list with all global marks in open buffers
-- :MarksQFListGlobal
-- :MarksListAll - Fill the location list with all marks in all open buffers
-- :MarksQFListAll

require('neoscroll').setup {}

require("no-neck-pain").setup({
    width = 100,
    buffers = {
        -- right = {
        --     enabled = false,
        -- },
        colors = {
            background = "tokyonight-moon",
        }
    },
    mappings = {
        enabled = true,
        toggle = "<Leader>nn",
        toggleLeftSide = "<Leader>nql",
        toggleRightSide = "<Leader>nqr",
        widthUp = { mapping = "<Leader>n=", value = 20 },
        widthDown = { mapping = "<Leader>n-", value = 20 },
        scratchPad = "<Leader>ns",
    },
})

-- local function purge_sessions()
--   local auto_session = require 'auto-session'
--   local to_purge = {} for _, session in ipairs(auto_session.get_session_files()) do assert(session.display_name, "Session has no 'display_name' field") -- in case of API change if session.display_name:find('^/.*') and vim.fn.isdirectory(session.display_name) == 0 then table.insert(to_purge, session.display_name) end end for _, name in ipairs(to_purge) do vim.notify("Purging session " .. name, vim.log.info) auto_session.DeleteSessionByName(name) end if #to_purge == 0 then vim.notify("Nothing to purge", vim.log.info) end end
-- end
-- vim.api.nvim_create_user_command('PurgeSessions', purge_sessions, { desc = "Purge orphaned sessions" })

require('numb').setup {
   show_numbers = true,
   show_cursorline = true,
   centered_peeking = true,
}

require('nvim-web-devicons').setup {}

require('which-key').setup {
  plugins = {
      marks = false,
  },
  win = {
      border = "double",
  },
}

--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then return ''
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
       return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
    end
    return str
  end
end

require('lualine').setup {
  options = {
    theme = 'tokyonight',
  },
  sections = {
    lualine_a = {},
    lualine_b = {
      {'FugitiveHead', icon = '', fmt=trunc(100, 30, 90)},
      {'diff'},
      {'diagnostics'}
    },
    lualine_c = {{'filename', path = 1}},
    lualine_x = {{'filetype', fmt=trunc(100, 30, 90)}},
    lualine_y = {{'progress', fmt=trunc(90, 30, 50)}},
    lualine_z = {{'location', fmt=trunc(90, 30, 50)}}
  },
  inactive_sections = {
    lualine_a = {{'filename', path = 1}},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {{'tabs', mode = 3, max_length = vim.o.columns}},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'windows'}
  },
  extensions = {'fugitive', 'fzf', 'man', 'mundo', 'nvim-dap-ui', 'nvim-tree', 'quickfix'}
}

require('terminal').setup {}

require('package-info').setup({
  hide_up_to_date = true,
  package_manager = 'yarn'
})
-- Show package versions
-- vim.api.nvim_set_keymap("n", "<leader>ns", ":lua require('package-info').show({ force = true })<CR>", { silent = false, noremap = true })
-- -- Hide package versions
-- vim.api.nvim_set_keymap("n", "<leader>nc", ":lua require('package-info').hide()<CR>", { silent = true, noremap = true })
-- -- Update package on line
-- vim.api.nvim_set_keymap("n", "<leader>nu", ":lua require('package-info').update()<CR>", { silent = true, noremap = true })
-- -- Delete package on line
-- vim.api.nvim_set_keymap("n", "<leader>nd", ":lua require('package-info').delete()<CR>", { silent = true, noremap = true })
-- -- Install a new package
-- vim.api.nvim_set_keymap("n", "<leader>ni", ":lua require('package-info').install()<CR>", { silent = true, noremap = true })
-- -- Reinstall dependencies
-- vim.api.nvim_set_keymap("n", "<leader>nr", ":lua require('package-info').reinstall()<CR>", { silent = true, noremap = true })
-- -- Install a different package version
-- vim.api.nvim_set_keymap("n", "<leader>np", ":lua require('package-info').change_version()<CR>", { silent = true, noremap = true })
-- -- Toggle dependency versions
-- vim.keymap.set({ "n" }, "<LEADER>nt", require("package-info").toggle, { silent = true, noremap = true })

local function close_nvim_tree()
  require('nvim-tree.view').close()
end

EOF


augroup MyColors
  autocmd!
  if g:colors_name ==# 'tokyonight'
    hi IncSearch guifg=#292e42 guibg=#bb9af7
    hi NormalFloat guifg=#c0caf5 guibg=#292e42

    " chentoast/marks.nvim'
    hi MarkVirtTextHL cterm=bold ctermfg=15 ctermbg=9 gui=bold guifg=#ffffff guibg=#f00077
  end

" https://github.com/trapd00r/vim-syntax-todo/blob/master/syntax/todo.vim
  autocmd Syntax * call matchadd(
              \ 'Search',
              \ '\v\W\zs<(NOTE|INFO|TODO|FIXME|CHANGED|BUG|HACK|LEARNINGS|TECH|IMPACT)>'
              \ )
augroup END
