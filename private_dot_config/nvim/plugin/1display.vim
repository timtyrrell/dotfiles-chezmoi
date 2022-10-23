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
nmap <silent> gL <cmd>call coc#rpc#request('fillDiagnostics', [bufnr('%')])<CR><cmd>Trouble loclist<CR>

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

" lightline
let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok'],
    \             [ 'paste', 'gitbranch', 'filename', 'modified'] ],
    \   'right': [ [ 'lineinfo' ],
    \            [ 'percent' ],
    \            [ 'filetype' ] ],
    \ },
    \ 'component_function': {
    \   'gitbranch': 'LightlineBranchformat',
    \   'filename': 'LightlineFilenameDisplay',
    \   'fileformat': 'LightlineFileformat',
    \   'filetype': 'LightlineFiletype',
    \   'lineinfo': 'LightlineLineInfo',
    \   'percent': 'LightlinePercent',
    \ },
    \ 'separator': { 'left': "\ue0b4", 'right': "\ue0b6" },
    \ 'subseparator': { 'left': "\ue0b5", 'right': "\ue0b7" },
    \ 'tab_component_function': {
    \   'tabnum': 'LightlineWebDevIcons',
    \   'filename': 'LightlineTabname',
    \ },
    \ }
let g:lightline#coc#indicator_warnings = ''
let g:lightline#coc#indicator_errors = ''
let g:lightline#coc#indicator_info = ''

function! LightlinePercent() abort
    if winwidth(0) < 60
        return ''
    endif
    let l:percent = line('.') * 100 / line('$') . '%'
    return printf('%-4s', l:percent)
endfunction

function! LightlineLineInfo()
  return &ft =~? 'NvimTree' ? '' : printf(' %d/%d:%-2d', line('.'), line('$'), col('.'))
endfunction

function! LightlineFilenameDisplay()
  if &ft == 'NvimTree'
    return ''
  else
    return winwidth(0) > 90 ? WebDevIconsGetFileTypeSymbol(LightlineFilename()) . " ". LightlineFilename() : pathshorten(fnamemodify(expand("%"), ":."))
  endif
endfunction

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

function! LightlineTabname(n) abort
  let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
  let l:fname = expand('#' . l:bufnr . ':t')
  return l:fname == '__Mundo__' ? 'Mundo' :
    \ l:fname == '__Mundo_Preview__' ? 'Mundo Preview' :
    \ l:fname =~ 'FZF' ? '' :
    \ l:fname =~ 'NvimTree' ? 'NvimTree' :
    \ l:fname =~ '\[Plugins\]' ? 'Plugins' :
    \ ('' != l:fname ? l:fname : '')
endfunction

function! LightlineWebDevIcons(n)
  let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
  return WebDevIconsGetFileTypeSymbol(bufname(l:bufnr))
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol(LightlineFilename()) : 'no ft') : ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! LightlineBranchformat()
  try
    if winwidth(0) > 100 && expand('%:t') !~? 'Tagbar\|NERD' && &ft !~? 'NvimTree' && exists('*FugitiveHead')
      let mark = ' '
      let branch = FugitiveHead()
      return branch !=# '' ? mark.branch : ''
    else
      return ''
    endif
  catch
    return ''
  endtry
endfunction

let g:lightline.colorscheme = 'tokyonight'

" register compoments:
call lightline#coc#register()

lua << EOF

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
  window = {
    backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    width = .5, -- width of the Zen window
    height = 1, -- height of the Zen window
  },
}

require("trouble").setup { mode = "loclist" }

require('cinnamon').setup({
  centered = false,
  always_scroll = true,
})

require('numb').setup {
   show_numbers = true,
   show_cursorline = true,
   centered_peeking = true,
}

require('nvim-web-devicons').setup {}
require('which-key').setup {}

-- tamton-aquib/duck.nvim
vim.keymap.set('n', '<leader>ddd', function() require("duck").hatch() end, {})
vim.keymap.set('n', '<leader>ddk', function() require("duck").cook() end, {})

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
