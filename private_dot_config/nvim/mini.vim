set nocompatible
filetype plugin indent on
syntax on
set hidden

" wilder workaround based on https://github.com/neovim/neovim/issues/14304
function! SetShortmessF(on) abort
  if a:on
    set shortmess+=F
  else
    set shortmess-=F
  endif
  return ''
endfunction

nnoremap <expr> : SetShortmessF(1) . ':'

augroup WilderShortmessFix
  autocmd!
  autocmd CmdlineLeave * call SetShortmessF(0)
augroup END
" wilder workaround based on https://github.com/neovim/neovim/issues/14304

call plug#begin('~/.config/nvim/plugged')

" massive cmdline improvement
function! UpdateRemotePlugins(...)
  " Needed to refresh runtime files
  let &rtp=&rtp
  UpdateRemotePlugins
endfunction

Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
Plug 'romgrk/fzy-lua-native', { 'do': 'make' }
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }

call plug#end()

" Ag PATTERN DIR
" command! -bang -nargs=+ -complete=dir AgDir call fzf#vim#ag_raw(<q-args>, <bang>0)

" call wilder#enable_cmdline_enter()
" set wildcharm=<Tab>
" cmap <expr> <Tab> wilder#in_context() ? wilder#next() : '\<Tab>'
" cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : '\<S-Tab>'

" call wilder#set_option('modes', ['/', '?', ':'])
"
augroup lazy_load_wilder
  autocmd!
  autocmd CmdlineEnter * ++once call s:wilder_init() | call wilder#main#start()
augroup END

function! s:wilder_init() abort
  call wilder#setup({'modes': [':', '/', '?']})

  cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
  cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"
  cmap <expr> <c-k> wilder#in_context() ? wilder#next() : "\<c-j>"
  cmap <expr> <c-j> wilder#in_context() ? wilder#previous() : "\<c-k>"

  " '-I' to ignore respect .gitignore, '-H' show hidden files
  call wilder#set_option('pipeline', [
        \   wilder#branch(
        \     wilder#python_file_finder_pipeline({
        \       'file_command': {_, arg -> stridx(arg, '.') != -1 ?
        \         ['fd', '-tf', '-H', '-I', '-E', '.git', '-E', '.venv'] :
        \         ['fd', '-tf']},
        \       'dir_command': ['fd', '-td'],
        \       'filters': ['clap_filter'],
        \     }),
        \     wilder#substitute_pipeline({
        \       'pipeline': wilder#python_search_pipeline({
        \         'skip_cmdtype_check': 1,
        \         'pattern': wilder#python_fuzzy_pattern({
        \           'start_at_boundary': 0,
        \         }),
        \       }),
        \     }),
        \     wilder#cmdline_pipeline({
        \       'fuzzy': 2,
        \       'fuzzy_filter': wilder#lua_fzy_filter(),
        \     }),
        \     [
        \       wilder#check({_, x -> empty(x)}),
        \       wilder#history(),
        \     ],
        \     wilder#python_search_pipeline({
        \       'pattern': wilder#python_fuzzy_pattern({
        \         'start_at_boundary': 0,
        \       }),
        \     }),
        \   ),
        \ ])

  let s:highlighters = [ wilder#lua_fzy_highlighter() ]

  let s:popupmenu_renderer = wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
        \ 'reverse': 1,
        \ 'border': 'rounded',
        \ 'empty_message': wilder#popupmenu_empty_message_with_spinner(),
        \ 'highlights': { 'accent': 'Statement'},
        \ 'highlighter': s:highlighters,
        \ 'left': [
        \   ' ',
        \   wilder#popupmenu_devicons(),
        \   wilder#popupmenu_buffer_flags({
        \     'flags': ' a + ',
        \     'icons': {'+': '', 'a': '', 'h': ''},
        \   }),
        \ ],
        \ 'right': [
        \   ' ',
        \   wilder#popupmenu_scrollbar(),
        \ ],
        \ }))

  let s:wildmenu_renderer = wilder#wildmenu_renderer(
        \ wilder#wildmenu_lightline_theme({
        \   'highlighter': s:highlighters,
        \   'highlights': { 'accent': 'Statement'},
        \   'separator': ' · ',
        \ }))

  call wilder#set_option('renderer', wilder#renderer_mux({
        \ ':': s:popupmenu_renderer,
        \ '/': s:popupmenu_renderer,
        \ 'substitute': s:wildmenu_renderer,
        \ }))
endfunction
