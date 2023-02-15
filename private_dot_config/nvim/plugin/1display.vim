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
let g:Hexokinase_ftEnabled = ['css', 'html', 'javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'less', 'vim', 'conf', 'tmux', 'gitconfig', 'xml', 'lua', 'stylus', 'sh']

" Plug 'jmckiern/vim-venter'
let g:venter_width = &columns/6
nnoremap <leader>ve :VenterToggle<CR>

" Plug 'folke/zen-mode.nvim'
nnoremap <leader>zm :ZenMode<CR>

" Plug 'folke/trouble.nvim'
" nmap <silent> gL <cmd>call coc#rpc#request('fillDiagnostics', [bufnr('%')])<CR><cmd>Trouble loclist<CR>

" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
let g:mkdp_browser = 'Chrome'
let g:mkdp_auto_start = 0
let g:mkdp_filetypes = ['markdown']
nmap <leader>mp <Plug>MarkdownPreview
nmap <leader>ms <Plug>MarkdownPreviewStop

" Plug 'ellisonleao/glow.nvim', {'for': 'markdown'}
nmap <leader>mv :Glow<CR>
let g:glow_binary_path = '/opt/homebrew/bin/glow'
let g:glow_border = 'rounded'
let g:glow_width = 120
" q to quit, :Glow for current filepath

lua << EOF
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
})

EOF
colorscheme tokyonight

lua << EOF

-- require("colorful-winsep").setup({
--   no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree" },
-- })
-- require('import-cost').setup()

require("tidy").setup()

require('marks').setup {
  default_mappings = false,
  highlight_unlabeled = true,
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

require('zen-mode').setup {
  twilight = { enabled = false },
  window = {
    backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    width = .8, -- width of the Zen window
    height = 1, -- height of the Zen window
  },
}

require("trouble").setup { mode = "loclist" }

require('neoscroll').setup {}

require('numb').setup {
   show_numbers = true,
   show_cursorline = true,
   centered_peeking = true,
}

require('nvim-web-devicons').setup {}
require('which-key').setup {}

-- tamton-aquib/duck.nvim
vim.keymap.set('n', '<leader>ddd', function() require("duck").hatch("🦆", 10) end, {}) -- A pretty fast duck
vim.keymap.set('n', '<leader>ddc', function() require("duck").hatch("🐈", 0.75) end, {}) -- Quite a mellow cat
vim.keymap.set('n', '<leader>ddk', function() require("duck").cook() end, {})

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
  theme = 'tokyonight',
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

local registers = require("registers")
registers.setup({
  show_empty = false,
  window = {
    border = "double",
    transparency = 90,
  },
  bind_keys = {
    registers = registers.apply_register({ delay = 1 }),
  },
})

require('terminal').setup {}

require('package-info').setup({
  hide_up_to_date = true,
  package_manager = 'yarn'
})
-- Show package versions
vim.api.nvim_set_keymap("n", "<leader>ns", ":lua require('package-info').show({ force = true })<CR>", { silent = false, noremap = true })
-- Hide package versions
vim.api.nvim_set_keymap("n", "<leader>nc", ":lua require('package-info').hide()<CR>", { silent = true, noremap = true })
-- Update package on line
vim.api.nvim_set_keymap("n", "<leader>nu", ":lua require('package-info').update()<CR>", { silent = true, noremap = true })
-- Delete package on line
vim.api.nvim_set_keymap("n", "<leader>nd", ":lua require('package-info').delete()<CR>", { silent = true, noremap = true })
-- Install a new package
vim.api.nvim_set_keymap("n", "<leader>ni", ":lua require('package-info').install()<CR>", { silent = true, noremap = true })
-- Reinstall dependencies
vim.api.nvim_set_keymap("n", "<leader>nr", ":lua require('package-info').reinstall()<CR>", { silent = true, noremap = true })
-- Install a different package version
vim.api.nvim_set_keymap("n", "<leader>np", ":lua require('package-info').change_version()<CR>", { silent = true, noremap = true })
-- Toggle dependency versions
vim.keymap.set({ "n" }, "<LEADER>nt", require("package-info").toggle, { silent = true, noremap = true })

local function close_nvim_tree()
  require('nvim-tree.view').close()
end

EOF


" https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f
function! MyHighlights() abort
  if g:colors_name ==# 'tokyonight'
    hi default link CocHighlightText TabLineSel
    hi IncSearch guifg=#292e42 guibg=#bb9af7
    " hi CocUnderline gui=undercurl term=undercurl
    " hi default link CocErrorHighlight LspDiagnosticsUnderlineError
    " hi default link CocWarningHighlight LspDiagnosticsUnderlineWarning
    " hi default link CocInfoHighlight LspDiagnosticsUnderlineInformation
    " hi default link CocHintHighlight LspDiagnosticsUnderlineHint
    " hi default link CocErrorVirtualText LspDiagnosticsVirtualTextError
    " hi default link CocWarningVirtualText LspDiagnosticsVirtualTextWarning
    " hi default link CocInfoVirtualText LspDiagnosticsVirtualTextInformation
    " hi default link CocHintVirtualText LspDiagnosticsVirtualTextHint
    hi default link CocCodeLens LspCodeLens
    hi NormalFloat guifg=#c0caf5 guibg=#292e42

    " Coc autocomplete menu
    hi default link CocPumSearch Statement

    " chentoast/marks.nvim'
    hi MarkVirtTextHL cterm=bold ctermfg=15 ctermbg=9 gui=bold guifg=#ffffff guibg=#f00077
  end
endfunction

augroup MyColors
  autocmd!
  autocmd ColorScheme * call MyHighlights()
" https://github.com/trapd00r/vim-syntax-todo/blob/master/syntax/todo.vim
  autocmd Syntax * call matchadd(
              \ 'Search',
              \ '\v\W\zs<(NOTE|INFO|TODO|FIXME|CHANGED|BUG|HACK|LEARNINGS|TECH|IMPACT)>'
              \ )
augroup END
