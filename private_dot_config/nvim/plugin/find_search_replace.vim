" fzf.vim

" run `echo fzf#wrap()` to see generate zsh colors for colorscheme
" let g:fzf_colors =
" \ { 'fg':         ['fg', 'Normal'],
"   \ 'bg':         ['bg', 'Normal'],
"   \ 'preview-bg': ['bg', 'NormalFloat'],
"   \ 'hl':         ['fg', 'Comment'],
"   \ 'fg+':        ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':        ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':        ['fg', 'Statement'],
"   \ 'info':       ['fg', 'PreProc'],
"   \ 'border':     ['fg', 'Ignore'],
"   \ 'prompt':     ['fg', 'Conditional'],
"   \ 'pointer':    ['fg', 'Exception'],
"   \ 'marker':     ['fg', 'Keyword'],
"   \ 'spinner':    ['fg', 'Label'],
"   \ 'header':     ['fg', 'Comment'] }

" nnoremap <C-w>- :new<cr>
" nnoremap <C-w><bar> :vnew<cr>

let g:fzf_vim = {}
let g:fzf_vim.grep_multi_line = 2

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" open fzf in a floating window
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.7 } }

" https://jdhao.github.io/2020/02/16/ripgrep_cheat_sheet/
" https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#common-options

" 'wild	exact-match (quoted)	Items that include wild
" ^music	prefix-exact-match	Items that start with music
" .mp3$	suffix-exact-match	Items that end with .mp3
" !fire	inverse-exact-match	Items that do not include fire
" !^music	inverse-prefix-exact-match	Items that do not start with music
" !.mp3$	inverse-suffix-exact-match	Items that do not end with .mp3

" nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <silent> <Leader>ff <cmd>Files<CR>

" git_files if git dir, otherwise file search
" vim.keymap.set('n', '<leader>ff', function()
"   local is_git = os.execute('git') == 0
"   if is_git then
"     require("telescope.builtin").git_files()
"   else
"     require("telescope.builtin").find_files()
"   end
" end)

" to set search folder
nnoremap <silent> <Leader>fF :Files<space>

" TODO: move to rails specific filetype folder
" nnoremap <Leader>aa  :A<CR>
nnoremap <silent> <Leader>ea :Files app/assets<CR>
nnoremap <silent> <Leader>ec :Files app/controllers<CR>
nnoremap <silent> <Leader>eh :Files app/helpers<CR>
nnoremap <silent> <Leader>ei :Files config/initializers<CR>
nnoremap <silent> <Leader>ej :Files app/javascript<CR>
nnoremap <silent> <Leader>em :Files app/models<CR>
nnoremap <silent> <Leader>es :Files spec<CR>
nnoremap <silent> <Leader>ev :Files app/views<CR>

nnoremap <silent> <Leader>fT <cmd>Windows<CR>

" nnoremap <silent> <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <silent> <Leader>fb :Buffers<CR>
let g:fzf_buffers_jump = 1

" select buffers to delete/close
nnoremap <silent> <leader>bx :BD<CR>

" Lines in the current buffer
nnoremap <silent><leader>fB <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
" nnoremap <silent> <Leader>fB :BLines<CR>

" live grep exact word match
" nnoremap <silent> <leader>fl <cmd>lua require('telescope.builtin').live_grep()<cr>
" live grep fuzzy match
" nnoremap <silent> <leader>fL <cmd>lua require('telescope.builtin')
"       \ .grep_string({
"       \   only_sort_text = true,
"       \   search = ''
"       \ })<cr>
nnoremap <silent> <Leader>fl <cmd>RgLines<CR>

" Lines in loaded buffers
nnoremap <silent> <leader>fz <cmd>lua require('telescope.builtin')
      \.live_grep({
      \   prompt_title = 'find string in open buffers...',
      \   grep_open_files = true
      \ })<cr>
nnoremap <silent> <Leader>fL :Lines<CR>
nnoremap <silent> <leader>fh <cmd>lua require('telescope.builtin').command_history()<cr>
" nnoremap <silent> <Leader>fh :HistoryCmds<CR>

nnoremap <silent> <leader>fH <cmd>lua require('telescope.builtin').oldfiles()<cr>
" nnoremap <silent> <Leader>fH :History<CR>
nnoremap <silent> <leader>fS <cmd>lua require('telescope.builtin').search_history()<cr>
" nnoremap <silent> <Leader>fS :HistorySearch<CR>
nnoremap <silent> <Leader>fg <cmd>lua require('telescope.builtin').git_status()<cr>
" nnoremap <silent> <Leader>fg :GFiles?<CR>
" nnoremap <silent> <leader>fC <cmd>lua require('telescope.builtin').git_bcommits()<cr>
nnoremap <silent> <Leader>fc :BCommits<CR>
" nnoremap <silent> <leader>fC <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <silent> <Leader>fC :Commits<CR>
nnoremap <silent> <leader>fm <cmd>lua require('telescope.builtin').marks()<cr>
" nnoremap <silent> <Leader>fm :Marks<CR>
nnoremap <silent> <leader>fM <cmd>lua require('telescope.builtin').keymaps()<cr>
" nnoremap <silent> <Leader>fM :Maps<CR>

nnoremap <silent> <leader>fs <cmd>lua require('telescope.builtin').spell_suggest()<cr>

nnoremap <silent> <leader>fr <cmd>lua require('telescope.builtin').resume()<cr>

" start file search in current dir
nnoremap <silent> <leader>fd <cmd>lua require('telescope.builtin')
      \ .find_files({
      \   cwd = require'telescope.utils'.buffer_dir()
      \ })<cr>
" nnoremap <silent> <Leader>fd :Files <C-R>=expand('%:h')<CR><CR>

" nnoremap <silent> <leader>rw <cmd>lua require('telescope.builtin')
"       \ .grep_string({
"       \   only_sort_text = true,
"       \   word_match = '-w',
"       \ })<cr>
" Rg current word under cursor
nnoremap <silent> <Leader>rw :RgLines <C-R><C-W><CR>

" Rg with any params (filetypes)
" nnoremap <leader>rf :RG **/*.

" Rg with dir autocomplete
nnoremap <leader>rd :RGdir<Space>
" nnoremap <leader>rd <cmd>GrepInDirectory<CR>
" nnoremap <leader>rd <cmd>FileInDirectory<CR>

" https://github.com/ranelpadon/configs/blob/6bdc3f975e5433d1d792c38f1167c16c90136579/nvim/plugins-config/fzf.vim
" We just need a dummy command that do nothing.
let s:rg_initial_command = 'true'

let s:rg_colors = ' --colors line:fg:red --colors path:fg:blue --colors match:fg:green '

" let s:rg_colors = ' --color=fg:#c0caf5,bg:#1a1b26,hl:#bb9af7 --color=fg+:#FFFFFF,bg+:#1a1b26,hl+:#7dcfff --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a --color header:italic '

" {q} is the query string passed from fzf to ripgrep.
" If query is empty do nothing instead of fetching all lines.
" `--fixed-strings` to avoid escaping regex chars like parentheses.
" `%s` is a placeholder for `rg_base_command` and resolved by using `printf()`.
let s:rg_full_command = '[[ {q} != "" ]] && '. '%s' . s:rg_colors . ' --line-number --color=always --smart-case --fixed-strings {q} || ' . s:rg_initial_command

command! -bang -nargs=* Rg
\   call fzf#vim#grep(
\       'rg' . s:rg_colors . ' --line-number --color=always --smart-case -- '.shellescape(<q-args>), 1,
\       fzf#vim#with_preview({'options': '--exact --delimiter : --nth 3..'}), <bang>0
\   )

" https://www.reddit.com/r/vim/comments/10mh48r/comment/j64i2b4/?context=3
" On-demand search using Rg if query is non-empty. Fzf is a middleman only.
function! RgReloader(query, fullscreen, rg_base_command)
    " Shift focus to the right/main window, especially when focus is in sidebar.
    :wincmd l

    let rg_reload_command = printf(s:rg_full_command, a:rg_base_command)

    " --disabled: disable the fuzzy search, use fzf just a simple filter/pipe which is mainly search by Rg (makes the fzf's `--exact` option useless)
    " Use `--phony` for version 0.24.0 or lower.
    " https://github.com/junegunn/fzf/blob/master/CHANGELOG.md#0250
    " --bind 'change:reload:rg ... {q}' will make fzf restart ripgrep process whenever the query string
    " With --phony option, fzf will no longer perform search. The query string you type on fzf prompt is only used for restarting ripgrep process.
    " `--delimiter`: parse per line.
    " `--nth`: the scope of the search after parsing with delimiter.
    " Looks like `--disabled` makes the `--delimiter` and `--nth` useless and will just relay the searching to `ripgrep`.
    " let fzf_options = {'options': ['--prompt', 'λ ', '--disabled', '--phony', '--query', a:query, '--bind', 'change:reload:'.rg_reload_command, '--delimiter', ':', '--nth', '3..']}
    let fzf_options = {
        \ 'options':
            \ [
                \ '--prompt', 'λ ',
                \ '--disabled',
                \ '--phony',
                \ '--query', a:query,
                \ '--preview-window', 'right,50%,border-left',
                \ '--bind', 'change:reload:' . rg_reload_command,
                \ '--bind', '\:toggle-preview',
            \ ]
    \ }

    " call fzf#vim#grep(s:rg_initial_command, 1, fzf#vim#with_preview(fzf_options), a:fullscreen)
    call fzf#vim#grep(s:rg_initial_command, 1, fzf#vim#with_preview(fzf_options))
endfunction

" On-load search using Rg and Fzf, regardless if query is non-empty.
function! RgLoader(query, fullscreen, rg_base_command)
    " Shift focus to the right/main window, especially when focus is in sidebar.
    :wincmd l

    " Use empty string ("") as initial query string ({q}) to load all lines.
    " Then, `rg` could search the contents and return the results with file paths.
    " Then, `fzf` could search the file paths as well.
    " Hence, this will load all lines at first, then use `fzf` to query the initial data.
    " No data reloading will be done unlike in `RgReloader()`.
    let _rg_load_command = a:rg_base_command . s:rg_colors . ' --line-number --color=always --smart-case --fixed-strings %s || true'
    " Resolve the `%s` query string.
    let rg_load_command = printf(_rg_load_command, shellescape(a:query))

    let fzf_options = {
        \ 'options':
            \ [
                \ '--prompt', 'λ ',
                \ '--exact',
                \ '--preview-window', 'right,50%,border-left',
                \ '--bind', '\:toggle-preview',
            \ ]
    \ }
    " call fzf#vim#grep(rg_load_command, 1, fzf#vim#with_preview(fzf_options), a:fullscreen)
    call fzf#vim#grep(rg_load_command, 1, fzf#vim#with_preview(fzf_options))
endfunction

" mnemonics
" Rg all (filetype)
" Rg file (filetype)
" Rg test(file) (filetype)

" Search all file content
let rg_all = 'rg'
command! -nargs=* -bang RgAll call RgReloader(<q-args>, <bang>0, rg_all)
noremap <Leader>raa :RgAll<CR>

" Search all file content using the word under the cursor
nnoremap <silent> <Leader>rawa :call RgLoader(expand('<cword>'), 0, rg_all)<CR>

" Search all file content, includes the filename in matches
command! -nargs=* -bang RgAll call RgLoader(<q-args>, <bang>0, rg_all)
noremap <Leader>raf :RgAll<CR>

" Search all JS/JSX/TS/TSX file content
let rg_js_ts_all = 'rg --type webjsts'
command! -nargs=* -bang RgJsTsAll call RgReloader(<q-args>, <bang>0, rg_js_ts_all)
noremap <Leader>raj :RgJsTsAll<CR>

" Search JS/JSX/TS/TSX file content, exclude test files
let rg_js_ts = 'rg --type webjsts --glob "!**/{__tests__,__mocks__,__tests_scaffolding__}/**/*.*" '
command! -nargs=* -bang RgJsTs call RgReloader(<q-args>, <bang>0, rg_js_ts)
noremap <Leader>rfj :RgJsTs<CR>

" Search JS/JSX/TS/TSX file content, only test files
let rg_js_ts_test = 'rg --type webjsts --glob "**/{__tests__,__mocks__,__tests_scaffolding__}/**/*.*"'
command! -nargs=* -bang RgJsTsTest call RgReloader(<q-args>, <bang>0, rg_js_ts_test)
noremap <Leader>rtj :RgJsTsTest<CR>

" Search all JS/JSX/TS/TSX file content using the word under the cursor
nnoremap <silent> <Leader>rawj :call RgLoader(expand('<cword>'), 0, rg_js_ts_all)<CR>
" Search JS/JSX/TS/TSX file content using the word under the cursor, exclude test files
nnoremap <silent> <Leader>rfwj :call RgLoader(expand('<cword>'), 0, rg_js_ts)<CR>
" Search JS/JSX/TS/TSX test file content using the word under the cursor, only test files
nnoremap <silent> <Leader>rtwj :call RgLoader(expand('<cword>'), 0, rg_js_ts_test)<CR>

" Search all RB/ERB/SLIM/HTML file content
let rg_rb_all = 'rg --type webrb'
command! -nargs=* -bang RgRbAll call RgReloader(<q-args>, <bang>0, rg_rb_all)
noremap <Leader>rar :RgRbAll<CR>

" Search RB/ERB/SLIM/HTML file content, exclude test files
let rg_rb = 'rg --type webrb --glob "!spec/**/*.*"'
command! -nargs=* -bang RgRb call RgReloader(<q-args>, <bang>0, rg_rb)
noremap <Leader>rfr :RgRb<CR>

" Search RB/ERB/SLIM/HTML file content, only test files
let rg_rb_test = 'rg --type webrb --glob "spec/**/*.*"'
command! -nargs=* -bang RgRbTest call RgReloader(<q-args>, <bang>0, rg_rb_test)
noremap <Leader>rtr :RgRbTest<CR>

" Search all RB/ERB/SLIM/HTML file content using the word under the cursor
nnoremap <silent> <Leader>rawr :call RgLoader(expand('<cword>'), 0, rg_rb_all)<CR>
" Search RB/ERB/SLIM/HTML file content using the word under the cursor, exclude test files
nnoremap <silent> <Leader>rfwr :call RgLoader(expand('<cword>'), 0, rg_rb)<CR>
" Search RB/ERB/SLIM/HTML test file content using the word under the cursor, only test files
nnoremap <silent> <Leader>rtwr :call RgLoader(expand('<cword>'), 0, rg_rb_test)<CR>

" " Search by file path/names AND file contents
" nnoremap <silent> <Leader>raa :Rg<CR>

" Search lines in _all_ buffers with smart-case (this only does the current buffer???)
" command! -bang -nargs=* BLines
"     \ call fzf#vim#grep(
"     \   'rg --with-filename --column --line-number --no-heading --smart-case . '.fnameescape(expand('%:p')), 1,
"     \   fzf#vim#with_preview({'options': '--layout reverse --query '.shellescape(<q-args>).' --with-nth=4.. --delimiter=":"'}))

" do not search filename, just file contents of all file Lines in root dir with smartcase
command! -bang -nargs=* RgLines
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --case-sensitive  -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({ 'options': ['--delimiter', ':', '--nth', '4..'] }), <bang>0)
  " \   'rg --column --line-number --no-heading --color=always --colors 'path:fg:190,220,255' --colors 'line:fg:128,128,128' --smart-case  -- '.shellescape(<q-args>), 1,
  " \   fzf#vim#with_preview({ 'options': ['--delimiter', ':', '--nth', '4..', '--color', 'hl:123,hl+:222'] }), <bang>0)

" override default preview settings in zshrc to hide previews
" examples in the source: https://github.com/junegunn/fzf.vim/blob/master/plugin/fzf.vim#L48
command! -bang -nargs=* HistoryCmds call fzf#vim#command_history(fzf#vim#with_preview({'options': ['--preview-window', 'hidden']}))
command! -bang -nargs=* HistorySearch call fzf#vim#search_history(fzf#vim#with_preview({'options': ['--preview-window', 'hidden']}))
" command! -bang -nargs=* FilesPreview call fzf#vim#files(fzf#vim#with_preview({'options': ['--preview-window', 'hidden']}))

" Ag PATTERN DIR
command! -bang -nargs=+ -complete=dir AgDir call fzf#vim#ag_raw(<q-args>, <bang>0)

" :Rag foo ~/my-project, or :Rag "foo bar" ~/my-project
command! -bang -nargs=+ -complete=dir Rag call fzf#vim#ag_raw(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

" whole word search
command! -bang -nargs=* AgWord call fzf#vim#ag(<q-args>, '--word-regexp', <bang>0)

" filter search by a passed in query (exact match)
" TODO doesn't work passing in a <, for example
function! RipgrepFzfExact(filepaths, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --case-sensitive --with-filename -e ''%s'' ' . a:filepaths . ' || true'
  let initial_command = printf(command_fmt, '')
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--disabled', '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
  " let spec = {'options': ['--disabled', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  " let spec = fzf#vim#with_preview(spec, 'right', 'ctrl-/')
  " call fzf#vim#grep(initial_command, 1, spec, a:fullscreen)
endfunction

" redefine :Rg to all arg passing
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \ "rg --column --line-number --no-heading --color=always --smart-case " .
"   \ <q-args>, 1, fzf#vim#with_preview(), <bang>0)

" filter by anything
" :RG **/*.ts
" :RG -tweb (INCLUDE 'web' type from .ripgreprc)
" :RG -Ttest (EXCLUDE 'test' type from .ripgreprc)
" command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
" autocomplete dirs
command! -nargs=* -bang -complete=dir RGdir call RipgrepFzfExact(<q-args>, <bang>0)

" Change to git project directory
nnoremap <silent> <Leader>fI :FZFCd ~/code<CR>
nnoremap <silent> <Leader>fi :FZFCd!<CR>
command! -bang -bar -nargs=? -complete=dir FZFCd
	\ call fzf#run(fzf#wrap(
	\ {'source': 'find '..( empty("<args>") ? ( <bang>0 ? "~" : "." ) : "<args>" ) ..
	\ ' -type d -maxdepth 1', 'sink': 'cd'}))

" FZF Buffer Delete
function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--no-preview --multi --reverse --bind ctrl-s:select-all+accept'
  \ }))
command! -bang Args call fzf#run(fzf#wrap('args',
    \ {'source': map([argidx()]+(argidx()==0?[]:range(argc())[0:argidx()-1])+range(argc())[argidx()+1:], 'argv(v:val)')}, <bang>0))

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and 'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" " Switch from any fzf mode to :Files on the fly and transfer the search query.
" " Inspiration: https://github.com/junegunn/fzf.vim/issues/289#issuecomment-447369414
" function! s:FzfFallback()
"   " If possible, extract the search query from the previous fzf mode.
"   " :Files queries are ignored here because they use a different, harder to
"   " match prompt format.
"   let line = getline('.')
"   let query = substitute(line, '\v^(Hist|Buf|GitFiles|Locate)\> ?', '', '')
"   echo query
"   let query = query != line ? query : ''
"   " let query = getline('.')[stridx(getline('.'), ' ') : col('.') - 1]
"   close
"   sleep 100m
"   call fzf#vim#files(GetProjectRoot(''), {'options': ['-q', query]})
" endfunction
" function! s:FzfFileType()
"   tnoremap <buffer> <silent> <c-f> <c-\><c-n>:call <sid>FzfFallback()<cr>
" endfunction
" autocmd FileType fzf call s:FzfFileType()
" Switch from any fzf mode to :Files on the fly and transfer the search query.
function! s:FzfFallback()
  if &filetype != 'FZF'
    return
  endif
  " Extract from first space to cursor position of previous fzf buffer prompt
  let query = getline('.')[stridx(getline('.'), ' ') : col('.') - 1]
  echo query
  close
  sleep 1m
  call fzf#vim#files('.', {'options': ['-q', query]})
endfunction
tnoremap <c-space> <c-\><c-n>c:call <sid>FzfFallback()<cr>

nnoremap <silent> <leader>fj :Jumps<CR>
nnoremap <silent> <leader>fJ :Changes<CR>
" FZF JUMPS/CHANGES

" Fzf display mappings
nmap <tab><tab> <plug>(fzf-maps-n)
xmap <tab><tab> <plug>(fzf-maps-x)
omap <tab><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-p> <plug>(fzf-complete-path)
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-l> <plug>(fzf-complete-line)
" switch finder so ignore settings are used
" inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
" scope path to current dir
" inoremap <expr> <c-x><c-f> fzf#vim#complete#path(
"     \ "find . -path '*/\.*' -prune -o -print \| sed '1d;s:^..::'",
"     \ fzf#wrap({'dir': expand('%:p:h')}))
function! s:remove_file_extension(path)
  return substitute(join(a:path), '\.[tj]sx\=$', "", "")
endfunction
function! AbsolutePathNoExtension()
  return fzf#vim#complete#path(
        \ "fd -t f",
        \ fzf#wrap({ 'reducer': function('s:remove_file_extension')})
        \ )
endfunction
inoremap <expr> <c-x><c-f> AbsolutePathNoExtension()

" or this: https://gosukiwi.github.io/vim/2022/10/26/vim-relative-file-autocomplete.html
function! s:generate_relative_js(path)
  let target = getcwd() . '/' . (join(a:path))
  let base = expand('%:p:h')
  let prefix = ""
  while stridx(target, base) != 0
    let base = substitute(system('dirname ' . base), '\n\+$', '', '')
    let prefix = '../' . prefix
  endwhile
  if prefix == ''
    let prefix = './'
  endif
  let relative = prefix . substitute(target, base . '/', '', '')
  let withJsTrunc = substitute(relative, '\.[tj]sx\=$', "", "")
  return withJsTrunc
endfunction

function! JsFzfImport()
  return fzf#vim#complete#path(
        \ "fd",
        \ fzf#wrap({ 'reducer': function('s:generate_relative_js')})
        \ )
endfunction
" inoremap <expr> <c-x><c-j> JsFzfImport()

" :e a new file and include a directory that doesn't exist, create it
augroup Mkdir
  autocmd!
  autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
augroup END

" Search and replace in file/line (selection or word)
" or use: Visual select > dgn > n(skip) or .(repeat)
vnoremap <leader>rs "9y:%s/<c-r>9//g<left><left>
" nnoremap <leader>rs viw"9y:%s/<c-r>9//g<left><left>
nnoremap <leader>rs :%s/\<<C-r>=expand("<cword>")<CR>\>/
vnoremap <leader>rl "9y:s/<c-r>9//g<left><left>
nnoremap <leader>rl viw"9y:s/<c-r>9//g<left><left>

" Search for the word under
" stay at current match
" Replace current word (and . for next one)
" . to repeat on next match
nnoremap cn *``cgn
nnoremap cN *``cgN

"*``cgn", "Replace current word (and . for next one)

" searches for the word under my cursor and performs cgn
" nmap cg* *Ncgn
" nnoremap g. /\V\C<C-r>"<CR>cgn<C-a><Esc>
" improvement on the above line, support delete (dw, etc), and multiline operations (ie, dd, cip, etc).
" searches for the text that I just replaced, jump to the next match and replace that with the new inserted text
nnoremap c. :call setreg('/',substitute(@", '\%x00', '\\n', 'g'))<cr>:exec printf("norm %sgn%s", v:operator, v:operator != 'd' ? '<c-a>':'')<cr>

" operate on "last motion"
" ik ak = last change pseudo text object
xnoremap ik `]o`[
onoremap ik <Cmd>normal vik<cr>
onoremap ak <Cmd>normal vikV<cr>
" to comment out lines from last motion, `gcak`
" make the b motion inclusive by default using
onoremap b vb

" Find and Replace in *all* files
" or use the terminal: git ls-files | xargs sed -i 's/oldword/neword/g'
function! FindAndReplace( ... )
  if a:0 != 2
    echo "Need two arguments"
    return
  endif
  execute printf('args `rg --files-with-matches ''%s'' .`', a:1)
  execute printf('noautocmd argdo %%substitute/%s/%s/g | update', a:1, a:2)
endfunction
command! -nargs=+ FindAndReplaceAll call FindAndReplace(<f-args>)

nnoremap <leader>te <cmd>Telescope<cr>
nnoremap <leader>tu <cmd>Telescope undo<cr>
nnoremap <leader>fn <cmd>Telescope node_modules list<cr>
nnoremap <leader>ti <cmd>Telescope import<cr>

" Unhighlight search results
map <Leader><space> :nohl<cr>

" do not jump from item on * search
nnoremap * *``<Cmd>lua require('hlslens').start()<CR>
nnoremap * m`:keepjumps normal! *``<cr><Cmd>lua require('hlslens').start()<CR>

noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'nzz')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
            " \<Cmd>Beacon<CR>
noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'Nzz')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
            " \<Cmd>Beacon<CR>

augroup lazy_load_wilder
  autocmd!
  autocmd CmdlineEnter * ++once call s:wilder_init() | call wilder#main#start()
augroup END

function! s:wilder_init() abort
  call wilder#setup({'modes': [':', '/', '?']})

  cmap <expr> <Tab>   wilder#in_context() ? wilder#next()     : "\<Tab>"
  cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"
  cmap <expr> <c-j>   wilder#in_context() ? wilder#next()     : "\<c-j>"
  cmap <expr> <c-k>   wilder#in_context() ? wilder#previous() : "\<c-k>"

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

  let s:experimental_popupmenu_renderer = wilder#popupmenu_renderer(wilder#popupmenu_palette_theme({
        \ 'border': 'rounded',
        \ 'max_height': '75%',
        \ 'min_height': 0,
        \ 'prompt_position': 'top',
        \ 'reverse': v:false,
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

  let s:popupmenu_renderer = wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
        \ 'border': 'rounded',
        \ 'empty_message': wilder#popupmenu_empty_message_with_spinner(),
        \ 'highlights': { 'accent': 'Statement'},
        \ 'highlighter': s:highlighters,
        \ 'reverse': v:false,
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

  let s:wildmenu_renderer = wilder#wildmenu_renderer({
        \ 'highlighter': s:highlighters,
        \ 'highlights': { 'accent': 'Statement'},
        \ 'separator': ' · ',
        \ 'left': [' ', wilder#wildmenu_spinner(), ' '],
        \ 'right': [' ', wilder#wildmenu_index()],
        \ })

        " \ ':': s:experimental_popupmenu_renderer,
  call wilder#set_option('renderer', wilder#renderer_mux({
        \ ':': s:popupmenu_renderer,
        \ '/': s:popupmenu_renderer,
        \ 'substitute': s:popupmenu_renderer,
        \ }))

endfunction

call wilder#set_option('renderer', wilder#wildmenu_renderer({
      \ 'highlighter': wilder#basic_highlighter(),
      \ 'separator': ' · ',
      \ 'left': [' ', wilder#wildmenu_spinner(), ' '],
      \ 'right': [' ', wilder#wildmenu_index()],
      \ }))

" wilder workaround based on https://github.com/neovim/neovim/issues/14304
" function! SetShortmessF(on) abort
"   if a:on
"     set shortmess+=F
"   else
"     set shortmess-=F
"   endif
"   return ''
" endfunction

" nnoremap <expr> : SetShortmessF(1) . ':'

" augroup WilderShortmessFix
"   autocmd!
"   autocmd CmdlineLeave * call SetShortmessF(0)
" augroup END
" wilder workaround based on https://github.com/neovim/neovim/issues/14304


nnoremap <leader>S <cmd>lua require('spectre').open()<CR>
"search current word
nnoremap <leader>sw <cmd>lua require('spectre').open_visual({select_word=true})<CR>
vnoremap <leader>s <esc>:lua require('spectre').open_visual()<CR>
"  search in current file
nnoremap <leader>sp viw:lua require('spectre').open_file_search()<cr>
" run command :Spectre

lua << EOF

-- local function grep_string()
--   vim.g.grep_string_mode = true
--   vim.ui.input({ prompt = 'Grep string', default = fn.expand("<cword>") },
--     function(value)
--       if value ~= nil then
--         require('telescope.builtin').grep_string({ search = value })
--       end
--       vim.g.grep_string_mode = false
--     end)
-- end
-- vim.keymap.set(
--   {"n","x"},
--   "<leader>/",
--   "grep_string",
--   { noremap = true }
-- )
-- vim.api.nvim_set_keymap(
--   "n",
--   "<leader>/",
--   "grep_string",
--   { noremap = true }
-- )

require('spectre').setup()

local actions = require "telescope.actions"
local action_layout = require "telescope.actions.layout"

-- focus telescope preview window
-- https://github.com/nvim-telescope/telescope.nvim/issues/2778#issuecomment-2202572413
local focus_preview = function(prompt_bufnr)
    local action_state = require("telescope.actions.state")
    local picker = action_state.get_current_picker(prompt_bufnr)
    local prompt_win = picker.prompt_win
    local previewer = picker.previewer
    local winid = previewer.state.winid
    local bufnr = previewer.state.bufnr
    vim.keymap.set("n", "<Tab>", function()
        vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", prompt_win))
    end, { buffer = bufnr })
    vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", winid))
    -- api.nvim_set_current_win(winid)
end

-- Global remapping
------------------------------
require('telescope').setup {
  defaults = {
    cache_picker = {num_pickers = 10},
    dynamic_preview_title = true,
    layout_strategy = "vertical",
    layout_config = {
      vertical = {
        width = 0.9, height = 0.9, preview_height = 0.6, preview_cutoff = 0, prompt_position = "top", mirror = true
      }
    },
    path_display = {"smart", shorten = {len = 3}},
    wrap_results = true,
    -- path_display = {"smart"},
    -- wrap_results = true,
    -- layout_config = {
    --   horizontal = {
    --     prompt_position = "top"
    --   },
    -- },
    sorting_strategy = "ascending",
    mappings = {
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<esc>"] = actions.close,
        ["<M-p>"] = action_layout.toggle_preview,
        ["<C-n"]  = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ['<c-d>'] = actions.delete_buffer,
      },
      i = {
        -- ["<cr>"] = function(bufnr)
        --   require("telescope.actions.set").edit(bufnr, "tab drop")
        -- end,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<M-p>"] = action_layout.toggle_preview,
        ["<C-n"]  = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ['<c-d>'] = actions.delete_buffer,
      },
    },
  },
  pickers = {
    current_buffer_fuzzy_find = {
      skip_empty_lines = true,
    },
    grep_string = {
      sort_only_text = true,
      -- additional_args = function(opts)
      --   if opts.search_all == true then
      --       return {}
      --   end
      --   local args_for_ext = {
      --     ["ts"]  = "-tts",
      --     ["js"]  = "-tjs",
      --   }
      --   return { args_for_ext[vim.bo.filetype] }
      -- end,
    },
    live_grep = {
      mappings = {
        i = { ["<c-f>"] = require('telescope.actions').to_fuzzy_refine },
      },
      only_sort_text = true,
      -- https://www.reddit.com/r/neovim/comments/udx0fi/telescopebuiltinlive_grep_and_operator/
      on_input_filter_cb = function(prompt)
        -- AND operator for live_grep like how fzf handles spaces with wildcards in rg
        return { prompt = prompt:gsub("%s", ".*") }
      end,
      -- additional_args = function(opts)
      --   if opts.search_all == true then
      --       return {}
      --   end
      --   local args_for_ext = {
      --     ["ts"]  = "-tts",
      --     ["js"]  = "-tjs",
      --   }
      --   return { args_for_ext[vim.bo.filetype] }
      -- end,
    },
    buffers = {
      ignore_current_buffer = true,
      sort_lastused = true,
    },
    colorscheme = {
      enable_preview = true,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
    dash = {
      fileTypeKeywords = {
        TelescopePrompt = true,
        terminal = false,
        javascript = { 'javascript', 'nodejs' },
        typescript = { 'typescript', 'javascript', 'nodejs' },
        typescriptreact = { 'typescript', 'javascript', 'react' },
        javascriptreact = { 'javascript', 'react' },
      },
    },
    -- file_browser = {layout_strategy = "horizontal", sorting_strategy = "ascending"},
    heading = {treesitter = true},
    ["ui-select"] = {require("telescope.themes").get_dropdown({})},
    undo = {
      side_by_side = true,
      layout_strategy = "vertical",
      layout_config = {
        preview_height = 0.8,
      },
       mappings = {
        i = {
          ["<cr>"] = require("telescope-undo.actions").yank_additions,
          ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
          ["<C-cr>"] = require("telescope-undo.actions").restore,
        },
      },
    },
  }
}
-- local M = {}

-- function M.project_files()
--   local opts = {} -- define here if you want to define something
--   local ok = pcall(require'telescope.builtin'.git_files, opts)
--   if not ok then require'telescope.builtin'.find_files(opts) end
-- end

-- function M.project_search()
--   require('telescope.builtin').find_files {
--     previewer = false,
--     shorten_path = true,
--     layout_strategy = "horizontal",
--     cwd = require('lspconfig.util').root_pattern(".git")(vim.fn.expand(":p")),
--   }
-- end

-- local M = {}

-- M.project_files = function()
--   local opts = {} -- define here if you want to define something
--   local ok = pcall(require'telescope.builtin'.git_files, opts)
--   if not ok then require'telescope.builtin'.find_files(opts) end
-- end

-- return M

require('telescope').load_extension('node_modules')
-- :Telescope node_modules list
-- | key               | action               |
-- |-------------------|----------------------|
-- | `<CR>` (edit)     | `builtin.find_files` |
-- | `<C-x>` (split)   | `:chdir` to the dir  |
-- | `<C-v>` (vsplit)  | `:lchdir` to the dir |
-- | `<C-t>` (tabedit) | `:tchdir` to the dir |
-- require('telescope').load_extension('coc')
require("telescope").load_extension("git_worktree")

local worktree = require("git-worktree")
require("git-worktree").setup({
  clear_jumps_on_change = false, -- this is handled by auto-session
  update_on_change = false,
})
-- Sync worktrees with vim session files
-- https://github.com/ThePrimeagen/git-worktree.nvim/issues/13#issuecomment-1222855331
worktree.on_tree_change(function(op, metadata)
  if op == worktree.Operations.Switch then
    vim.api.nvim_command("RestoreSession")
  end
end)

require('telescope').load_extension('fzf')
require('telescope').load_extension('env')
require("telescope").load_extension("notify")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("undo")

require("telescope").setup({
  extensions = {
    import = {
      -- Add imports to the top of the file keeping the cursor in place
      insert_at_top = true,
    },
  },
})


-- require('telescope').load_extension('neoclip')
-- require('neoclip').setup({
--   history = 1000,
--   enable_persistant_history = true,
--   preview = true,
--   keys = {
--     i = {
--       select = '<cr>',
--       paste = '<c-p>',
--       paste_behind = '<c-P>',
--     },
--     n = {
--       select = '<cr>',
--       paste = 'p',
--       paste_behind = 'P',
--     },
--   },
-- })

-- nvim-telescope/telescope-dap.nvim
require('telescope').load_extension('dap')

vim.cmd([[
    hi link BqfPreviewBorder Statement
    hi link BqfPreviewBorderPumSearch Statement
    hi link BqfPreviewRange Search
]])

local fn = vim.fn

function _G.qftf(info)
    local items
    local ret = {}
    -- The name of item in list is based on the directory of quickfix window.
    -- Change the directory for quickfix window make the name of item shorter.
    -- It's a good opportunity to change current directory in quickfixtextfunc :)
    --
    -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
    -- local root = getRootByAlterBufnr(alterBufnr)
    -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
    --
    if info.quickfix == 1 then
        items = fn.getqflist({id = info.id, items = 0}).items
    else
        items = fn.getloclist(info.winid, {id = info.id, items = 0}).items
    end
    local limit = 61
    local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
    local validFmt = '%s │%5d:%-3d│%s %s'
    for i = info.start_idx, info.end_idx do
        local e = items[i]
        local fname = ''
        local str
        if e.valid == 1 then
            if e.bufnr > 0 then
                fname = fn.bufname(e.bufnr)
                if fname == '' then
                    fname = '[No Name]'
                else
                    fname = fname:gsub('^' .. vim.env.HOME, '~')
                end
                -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
                if #fname <= limit then
                    fname = fnameFmt1:format(fname)
                else
                    fname = fnameFmt2:format(fname:sub(1 - limit))
                end
            end
            local lnum = e.lnum > 99999 and -1 or e.lnum
            local col = e.col > 999 and -1 or e.col
            local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
            str = validFmt:format(fname, lnum, col, qtype, e.text)
        else
            str = e.text
        end
        table.insert(ret, str)
    end
    return ret
end

vim.o.qftf = '{info -> v:lua._G.qftf(info)}'

require('bqf').setup({
    auto_enable = true,
    auto_resize_height = true,
    preview = {
        win_height = 12,
        win_vheight = 12,
        delay_syntax = 80,
        border_chars = {'┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█'},
        should_preview_cb = function(bufnr)
            local ret = true
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            local fsize = vim.fn.getfsize(bufname)
            if fsize > 100 * 1024 then
                -- skip file size greater than 100k
                ret = false
            elseif bufname:match('^fugitive://') then
                -- skip fugitive buffer
                ret = false
            end
            return ret
        end
    },
    -- make `drop` and `tab drop` preferred
    func_map = {
        open = '<cr>',
        openc = 'O', -- open item, close quickfix
        drop = 'o', -- open item, close quickfix
        split = '<C-x>',
        vsplit = '<C-v>',
        tabdrop = '',
        tab = 't',
        tabb = 'T', -- open item in new tab, keep current focus
        tabc = '',
        ptogglemode = 'zp', -- toggle preview window between normal and max size
        sclear = 'z<Tab>', -- clear signs
        filter = 'zn', -- create new list for signed items
        filterr = 'zN', -- create new list for non-signed items
        fzffilter = 'zf', -- fzf mode
        prevthis = '<', -- go to previous quickfix list in quickfix window
        nexthist = '>', -- go to next quickfix list in quickfix window
    },
    filter = {
        fzf = {
            action_for = {['ctrl-x'] = 'split', ['ctrl-t'] = 'tab drop'},
            extra_opts = {'--bind', 'ctrl-s:toggle-all', '--prompt', '> '}
        }
    }
})

require('mini.files').setup({
  mappings = {
    close       = 'q',
    go_in       = 'l',
    go_in_plus  = 'L',
    go_out      = 'h',
    go_out_plus = 'H',
    reset       = '<BS>',
    reveal_cwd  = '@',
    show_help   = 'g?',
    synchronize = '=',
    trim_left   = '<',
    trim_right  = '>',
  },

  options = {
    use_as_default_explorer = false,
  },

  windows = {
    preview = false,
    width_focus = 50,
    width_nofocus = 15,
    width_preview = 25,
  },
})

vim.keymap.set("n", "-", "<CMD>lua MiniFiles.open()<CR>", { desc = "Open cwd" })
vim.keymap.set("n", "<Leader>-", "<CMD>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>", { desc = "Open directory of current file" })


require('nvim-tree').setup {
  git = {
    ignore = false,
  },
  disable_netrw       = false,
  hijack_netrw        = false,
  hijack_cursor       = true,
  reload_on_bufenter  = true,
  diagnostics = {
    enable = true,
  },
  hijack_directories   = {
    enable = true,
    auto_open = false,
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  filters = {
    custom = {} -- list of string that will not be shown
  },
  view = {
    side = 'left',
    width = 45,
    float = {
      enable = false,
      open_win_config = {
        relative = "editor",
        border = "rounded",
        width = 30,
        height = 30,
        row = 1,
        col = 1,
      },
    },
  },
  renderer = {
    highlight_git = true,
    highlight_opened_files = "icon",
    icons = {
      web_devicons = {
        file = {
          enable = true,
          color = true,
        },
        folder = {
          enable = false,
          color = true,
        },
      },
      git_placement = "before",
      modified_placement = "after",
      diagnostics_placement = "signcolumn",
      bookmarks_placement = "signcolumn",
      padding = " ",
      symlink_arrow = " ➛ ",
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
        -- https://www.nerdfonts.com/cheat-sheet
        folder = {
          -- arrow_closed = ">",
          arrow_closed = "",
          -- arrow_closed = "",
          arrow_open = "",
        },
      },
    },
  },
  actions = {
    change_dir = {
      enable = true,
      global = false,
    },
    open_file = {
      quit_on_open = false,
      window_picker = {
        enable = false,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame", },
          buftype  = { "nofile", "terminal", "help", },
        }
      }
    }
  }
}

local leap = require "leap"
-- leap.setup {
  -- case_sensitive = true,
  -- {
  --   repeat_search = '<enter>',
  --   next_phase_one_target = '<enter>',
  --   next_target = {'<enter>', ';'},
  --   prev_target = {'<tab>', ','},
  --   next_group = '<space>',
  --   prev_group = '<tab>',
  --   multi_accept = '<enter>',
  --   multi_revert = '<backspace>',
  -- }
-- }
leap.add_default_mappings()

vim.keymap.del({'x', 'o'}, 'x')
vim.keymap.del({'x', 'o'}, 'X')

-- The following example showcases a custom action, using `multiselect`
function paranormal(targets)
  local input = vim.fn.input("normal! ")
  if #input < 1 then return end

  local ns = vim.api.nvim_create_namespace("")

  for _, target in ipairs(targets) do
    local line, col = unpack(target.pos)
    id = vim.api.nvim_buf_set_extmark(0, ns, line - 1, col - 1, {})
    target.extmark_id = id
  end

  for _, target in ipairs(targets) do
    local id = target.extmark_id
    local pos = vim.api.nvim_buf_get_extmark_by_id(0, ns, id, {})
    vim.fn.cursor(pos[1] + 1, pos[2] + 1)
    vim.cmd("normal! " .. input)
  end

  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
end

-- bi-directional
vim.api.nvim_set_keymap('n','s','', {
  callback = function() leap.leap {
    target_windows = {
      vim.fn.win_getid()
    },
  }
  end,
  noremap = true, silent = true
})

-- bi-directional and multiselect. hit Enter when all picked
vim.api.nvim_set_keymap('n','S','', {
  callback = function() leap.leap {
    target_windows = {
      vim.fn.win_getid()
    },
    action = paranormal,
    multiselect = true
  }
  end,
  noremap = true, silent = true
})

require('flit').setup {
  multiline = false,
}

-- nvim bug workaround, hide the original cursor position after a leap
vim.api.nvim_create_autocmd(
  "User",
  { callback = function()
      vim.cmd.hi("Cursor", "blend=100")
      vim.opt.guicursor:append { "a:Cursor/lCursor" }
    end,
    pattern = "LeapEnter"
  }
)
vim.api.nvim_create_autocmd(
  "User",
  { callback = function()
      vim.cmd.hi("Cursor", "blend=0")
      vim.opt.guicursor:remove { "a:Cursor/lCursor" }
    end,
    pattern = "LeapLeave"
  }
)

require('refactoring').setup({})
require("telescope").load_extension("refactoring")

-- remap to open the Telescope refactoring menu in visual mode
vim.api.nvim_set_keymap(
  "v",
  "<space>rr",
  "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
  { noremap = true }
)

EOF

" Plug 'mileszs/ack.vim'
let g:ackprg = 'rg --vimgrep'
" Don't jump to first match
cnoreabbrev Ack Ack!

" use ripgrep for grep
set grepprg=rg\ --vimgrep\ --no-heading
set grepformat=%f:%l:%c:%m

" grep word under cursor in entire project into quickfix
nnoremap <leader><bs> :Ack! <C-R><C-W><CR>
" grep word under cursor all buffers in current window into quickfix
nnoremap <space><bs> :AckWindow! <C-R><C-W><CR>

" Plug 'tpope/vim-abolish'
" MixedCase (crm)
" camelCase (crc)
" snake_case (crs)
" UPPER_CASE (cru)
" dash-case (cr-)
" Title Case (crt)

" Plug 'andymass/vim-matchup'
let g:matchup_matchparen_offscreen = {'method': 'popup'}
let g:matchup_text_obj_enabled = 0

" Plug 'drmingdrmer/vim-toggle-quickfix'
nmap <Leader>qq <Plug>window:quickfix:loop


" Plug 'kevinhwang91/nvim-bqf'
" zf - fzf in quickfix
" zp - toggle full screen preview
" zn or zN - create new quickfix list
" < - previous quickfix list
" > - next quickfix list
" c-x (split)

lua << EOF

-- Plug 'gabrielpoca/replacer.nvim'
-- lua require("replacer").run()
-- lua require("replacer").run({ rename_files = false })
-- https://www.reddit.com/r/vim/comments/lwr56a/search_and_replace_camelcase_to_snake_case/
vim.keymap.set('n','<Leader>sr' , ':%s/<C-r><C-w>//gc<Left><Left><Left>',{silent = false,desc="search and replace cword"})
vim.keymap.set('v','<Leader>sr' , 'y:%s/<C-R>"//gc<Left><Left><Left>',{silent = false,desc="search and replace selection"})


local rails_controller_patterns = {
  { target = "/spec/factories/%1.rb", context = "factories", transformer = "singularize" },
  { target = "/app/models/%1.rb", context = "models", transformer = "singularize" },
  { target = "/app/views/%1/**/*.html.*", context = "view" },
}

require("other-nvim").setup({
  -- showMissingFiles = true,
  mappings = {
    "rails",
  },
  --   {
  --     pattern = "/src/(.*)/.*.js$",
  --     target = "/src/%1/\\(*.css\\|*.scss\\)",
  --   },
  --   {
  --     pattern = "/src/(.*)/.*.ts$",
  --     target = "/src/%1/\\(*.css\\|*.scss\\)",
  --   },
  --   {
  --     pattern = "/app/models/(.*).rb",
  --     target = {
  --       { target = "/spec/factories/%1.rb", context = "factories" },
  --       { target = "/app/controllers/**/%1_controller.rb", context = "controller", transformer = "pluralize" },
  --       { target = "/app/views/%1/**/*.html.*", context = "view", transformer = "pluralize" },
  --     },
  --   },
  --   {
  --     pattern = "/app/controllers/.*/(.*)_controller.rb",
  --     target = rails_controller_patterns,
  --   },
  --   {
  --     pattern = "/app/controllers/(.*)_controller.rb",
  --     target = rails_controller_patterns,
  --   },
  --   {
  --     pattern = "/app/views/(.*)/.*.html.*",
  --     target = {
  --       { target = "/spec/factories/%1.rb", context = "factories", transformer = "singularize" },
  --       { target = "/app/models/%1.rb", context = "models", transformer = "singularize" },
  --       { target = "/app/controllers/**/%1_controller.rb", context = "controller", transformer = "pluralize" },
  --     },
  --   },
  --   {
  --     pattern = "/app/models/(.*).rb",
  --     target = "/spec/models/%1_test.rb",
  --     context = "spec"
  --   },
  --   {
  --     pattern = "/app/controllers/(.*).rb",
  --     target = "/spec/controllers/%1_test.rb",
  --     context = "spec"
  --   },
  --   {
  --     pattern = "/app/channels/(.*).rb",
  --     target = "/test/channels/%1_test.rb",
  --     context = "spec"
  --   },
  --   {
  --     pattern = "/app/mailers/(.*).rb",
  --     target = "/spec/mailers/%1_test.rb",
  --     context = "spec"
  --   },
  --   {
  --     pattern = "/app/serializers/(.*).rb",
  --     target = "/spec/serializers/%1_test.rb",
  --     context = "spec"
  --   },
  --   {
  --     pattern = "/app/services/(.*).rb",
  --     target = "/spec/services/%1_test.rb",
  --     context = "spec"
  --   },
  --   {
  --     pattern = "/app/workers/(.*).rb",
  --     target = "/spec/workers/%1_test.rb",
  --     context = "spec"
  --   },
  --   {
  --     pattern = "/lib/(.*).rb",
  --     target = "/spec/lib/%1_test.rb",
  --     context = "spec"
  --   },
  -- }
})

EOF

" https://github.com/junegunn/fzf.vim/issues/392
let g:projectionist_ignore_term = 1

let g:rails_projections = {
  \    'app/views/*.html.slim': {
  \      'type': 'view',
  \      'alternate': 'app/controllers/{dirname}_controller.rb',
  \    },
  \ }

let g:projectionist_heuristics = {}
let g:projectionist_heuristics['package.json'] = {
  \   '*.js': {
  \     'alternate': [
  \       '{dirname}/{basename}.test.js',
  \       '{dirname}/../{basename}.js',
  \       '{dirname}/__tests__/{basename}.js',
  \       '{dirname}/__tests__/{basename}.test.js',
  \     ],
  \     'related': [
  \       '{dirname}/{basename}.module.scss',
  \       '{dirname}/styles/{basename}.module.scss',
  \     ],
  \     'type': 'jssource',
  \   },
  \   '*.test.js': {
  \     'alternate': [
  \       '{dirname}/{basename}.js',
  \       '{dirname}/../{basename}.js',
  \     ],
  \     'type': 'jstest',
  \   },
  \   '*.ts': {
  \     'alternate': [
  \       '{dirname}/{basename}.test.ts',
  \       '{dirname}/../{basename}.ts',
  \       '{dirname}/__tests__/{basename}.ts',
  \       '{dirname}/__tests__/{basename}.test.ts',
  \       '{dirname}/../../__tests__/{basename}.test.ts',
  \       '{dirname}/../../__tests__/api/{basename}.test.ts',
  \     ],
  \     'related': [
  \       '{dirname}/{basename}.module.scss',
  \       '{dirname}/styles/{basename}.module.scss',
  \     ],
  \     'type': 'tssource',
  \   },
  \   '*.test.ts': {
  \     'alternate': [
  \       '{dirname}/{basename}.ts',
  \       '{dirname}/../{basename}.ts',
  \       '{dirname}/../../pages/{basename}.ts',
  \       '{dirname}/../../pages/api/{basename}.ts',
  \     ],
  \     'type': 'tstest',
  \   },
  \   '*.jsx': {
  \     'alternate': [
  \       '{dirname}/{basename}.test.jsx',
  \       '{dirname}/__tests__/{basename}.jsx',
  \       '{dirname}/__tests__/{basename}.test.jsx',
  \       '{dirname}/../{basename}.jsx',
  \     ],
  \     'related': [
  \       '{dirname}/{basename}.module.scss',
  \       '{dirname}/styles/{basename}.module.scss',
  \     ],
  \     'type': 'jsxsource',
  \   },
  \   '*.test.jsx': {
  \     'alternate': [
  \       '{dirname}/{basename}.jsx',
  \       '{dirname}/../{basename}.jsx',
  \     ],
  \     'type': 'jsxtest',
  \   },
  \   '*.tsx': {
  \     'alternate': [
  \       '{dirname}/{basename}.test.tsx',
  \       '{dirname}/../{basename}.tsx',
  \       '{dirname}/__tests__/{basename}.tsx',
  \       '{dirname}/__tests__/{basename}.test.tsx',
  \       '{dirname}/../../__tests__/{basename}.test.tsx',
  \       '{dirname}/../../__tests__/api/{basename}.test.tsx',
  \     ],
  \     'related': [
  \       '{dirname}/{basename}.module.scss',
  \       '{dirname}/styles/{basename}.module.scss',
  \     ],
  \     'type': 'tsxsource',
  \   },
  \   '*.test.tsx': {
  \     'alternate': [
  \       '{dirname}/{basename}.tsx',
  \       '{dirname}/../{basename}.tsx',
  \       '{dirname}/../../pages/{basename}.tsx',
  \       '{dirname}/../../pages/api/{basename}.tsx',
  \     ],
  \     'type': 'tsxtest',
  \   },
  \   '*.scss': {
  \     'alternate': [
  \       '{dirname}/{basename}.js',
  \       '{dirname}/{basename}.jsx',
  \       '{dirname}/{basename}.ts',
  \       '{dirname}/{basename}.tsx',
  \       '{dirname}/../{basename}.js',
  \       '{dirname}/../{basename}.jsx',
  \       '{dirname}/../{basename}.ts',
  \       '{dirname}/../{basename}.tsx',
  \     ],
  \     'type': 'scss',
  \   },
  \   'package.json' : {
  \     'alternate': [
  \       'package-lock.json',
  \       'yarn.lock',
  \      ],
  \    },
  \   'package-lock.json' : { 'alternate': 'package.json' },
  \   'yarn.lock' : { 'alternate': 'package.json' },
  \}
" let g:projectionist_heuristics = {
"     \'src/*.js': {
"     \    'type': 'component',
"     \    'alternate': [
"     \        'src/{}.scss',
"     \        'src/{dirname}/{basename}.test.js'
"     \    ]
"     \},
"     \'src/*.module.scss': {
"     \    'type': 'styles'
"     \}
" \ }
" nnoremap <Leader>ec :Ecomponent<Space>
" nnoremap <Leader>es :Estylesheet<Space>
" nnoremap <leader>et :Etest<Space>
" nnoremap <Leader>a  :A<CR>
" autocmd BufNewFile,BufRead * call <SID>DetectFrontEndFramework()

" autocmd BufNewFile,BufRead * call <SID>DetectFrontEndFramework()
" function! s:DetectFrontEndFramework()
" let package_json = findfile('package.json', '.;')
" if len(package_json)
"     let dependencies = readfile(package_json)
"                 \ ->join()
"                 \ ->json_decode()
"                 \ ->get('dependencies', {})
"                 \ ->keys()
"     if dependencies->count('next')
"         set path=.,,components/**,lib/**,pages/**,public/**,ssl/**,styles/**
"     endif
"     if dependencies->count('nuxt')
"         set path=.,,assets/**,components/**,layouts/**,middleware/**,pages/**,plugins/**,static/**,store/**,test/**,content/**
"     endif
" endif
" endfunction
