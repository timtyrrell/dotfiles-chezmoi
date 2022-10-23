" customize
let g:fzf_colors = {
      \ 'fg': ['fg', 'Normal'],
      \ 'bg': ['bg', 'Normal'],
      \ 'hl': ['fg', 'Green'],
      \ 'fg+': ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+': ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+': ['fg', 'Green'],
      \ 'info': ['fg', 'Yellow'],
      \ 'prompt': ['fg', 'Red'],
      \ 'pointer': ['fg', 'Blue'],
      \ 'marker': ['fg', 'Blue'],
      \ 'spinner': ['fg', 'Yellow'],
      \ 'header': ['fg', 'Blue']
      \ }

" fzf.vim
" nnoremap <C-w>- :new<cr>
" nnoremap <C-w><bar> :vnew<cr>
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
nnoremap <Leader>aa  :A<CR>
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
nnoremap <silent> <leader>bd :BD<CR>

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

" Rg current word under cursor
" nnoremap <silent> <leader>rw <cmd>lua require('telescope.builtin')
"       \ .grep_string({
"       \   only_sort_text = true,
"       \   word_match = '-w',
"       \ })<cr>
nnoremap <silent> <Leader>rw :RgLines <C-R><C-W><CR>

" Rg with any params (filetypes)
nnoremap <leader>rf :RG **/*.

" Rg with dir autocomplete
nnoremap <leader>rd :RGdir<Space>
" nnoremap <leader>rd <cmd>GrepInDirectory<CR>
" nnoremap <leader>rd <cmd>FileInDirectory<CR>

" Only search NON-test files defined in .ripgreprc
nnoremap <silent> <leader>rt :RG --type-not test<CR>
" nnoremap <silent> <leader>rt :RG --type-not test -g '!{cypress,test,*mocks*,__test__,__tests__}'<CR>

" Only search test files defined in .ripgreprc
nnoremap <silent> <leader>rT :RG --type test<CR>

" Search by file path/names AND file contents
nnoremap <silent> <Leader>ra :Rg<CR>

" Search lines in _all_ buffers with smart-case (this only does the current buffer???)
" command! -bang -nargs=* BLines
"     \ call fzf#vim#grep(
"     \   'rg --with-filename --column --line-number --no-heading --smart-case . '.fnameescape(expand('%:p')), 1,
"     \   fzf#vim#with_preview({'options': '--layout reverse --query '.shellescape(<q-args>).' --with-nth=4.. --delimiter=":"'}))

" do not search filename, just file contents of all file Lines in root dir with smartcase
command! -bang -nargs=* RgLines
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case  -- '.shellescape(<q-args>), 1,
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
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case --with-filename -e ''%s'' ' . a:filepaths . ' || true'
  let initial_command = printf(command_fmt, '')
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
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
  \ 'options': '--no-preview --multi --reverse --bind ctrl-a:select-all+accept'
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

" FZF JUMPS/CHANGES
function GoTo(jumpline)
  let values = split(a:jumpline, ":")
  echo "e ".values[0]
  call cursor(str2nr(values[1]), str2nr(values[2]))
  execute "normal! zvzz"
endfunction

function GetLine(bufnr, lnum)
  let lines = getbufline(a:bufnr, a:lnum)
  if len(lines)>0
    return trim(lines[0])
  else
    return ''
  endif
endfunction

function! Jumps()
  " Get jumps with filename added
  let jumps = map(reverse(copy(getjumplist()[0])),
    \ { key, val -> extend(val, {'name': expand('#'.(val.bufnr)) }) })

  let jumptext = map(copy(jumps), { index, val ->
      \ (val.name).':'.(val.lnum).':'.(val.col+1).': '.GetLine(val.bufnr, val.lnum) })

  call fzf#run(fzf#vim#with_preview(fzf#wrap({
        \ 'source': jumptext,
        \ 'column': 1,
        \ 'options': ['--delimiter', ':', '--bind', 'alt-a:select-all,alt-d:deselect-all', '--preview-window', '+{2}-/2'],
        \ 'sink': function('GoTo')})))
endfunction
command! Jumps call Jumps()

function! Changes()
  let changes  = reverse(copy(getchangelist()[0]))

  let offset = &lines / 2 - 3
  let changetext = map(copy(changes), { index, val ->
      \ expand('%').':'.(val.lnum).':'.(val.col+1).': '.GetLine(bufnr('%'), val.lnum) })

  call fzf#run(fzf#vim#with_preview(fzf#wrap({
        \ 'source': changetext,
        \ 'column': 1,
        \ 'options': ['--delimiter', ':', '--bind', 'alt-a:select-all,alt-d:deselect-all', '--preview-window', '+{2}-/2'],
        \ 'sink': function('GoTo')})))
endfunction
command! Changes call Changes()

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

" searches for the word under my cursor and performs cgn
nmap cg* *Ncgn
" nnoremap g. /\V\C<C-r>"<CR>cgn<C-a><Esc>
" improvement on the above line, support delete (dw, etc), and multiline operations (ie, dd, cip, etc).
" searches for the text that I just replaced, jump to the next match and replace that with the new inserted text
nnoremap c. :call setreg('/',substitute(@", '\%x00', '\\n', 'g'))<cr>:exec printf("norm %sgn%s", v:operator, v:operator != 'd' ? '<c-a>':'')<cr>

" Find and Replace in *all* files
function! FindAndReplace( ... )
  if a:0 != 2
    echo "Need two arguments"
    return
  endif
  execute printf('args `rg --files-with-matches ''%s'' .`', a:1)
  execute printf('argdo %%substitute/%s/%s/g | update', a:1, a:2)
endfunction
command! -nargs=+ FindAndReplaceAll call FindAndReplace(<f-args>)

nnoremap <leader>te <cmd>Telescope<cr>
nnoremap <leader>fn <cmd>Telescope node_modules list<cr>

" Unhighlight search results
map <Leader><space> :nohl<cr>

" do not jump from item on * search
nnoremap * *``<Cmd>lua require('hlslens').start()<CR>
nnoremap * m`:keepjumps normal! *``<cr><Cmd>lua require('hlslens').start()<CR>

noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'nzz')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
            \<Cmd>Beacon<CR>
noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'Nzz')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
            \<Cmd>Beacon<CR>

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

lua << EOF

local actions = require "telescope.actions"
local action_layout = require "telescope.actions.layout"
-- Global remapping
------------------------------
require('telescope').setup {
  defaults = {
    path_display = {"smart"},
    wrap_results = true,
    layout_config = {
      horizontal = {
        prompt_position = "top"
      },
    },
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
    bookmarks = {
      selected_browser = 'chrome',
    },
  }
}
require("telescope").load_extension("ui-select")

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
require('telescope').load_extension('gh')
-- Telescope gh pull_request assignee=timtyrrell state=open
-- |---------|-------------------------------|
-- | `<cr>`  | checkout pull request         |
-- | `<c-t>` | open web                      |
-- | `<c-e>` | toggle to view detail or diff |
-- | `<c-r>` | merge request                 |
-- | `<c-a>` | approve pull request          |
-- Telescope gh run
-- |---------|----------------------------------------------|
-- | `<cr>`  | open workflow summary/run logs in new window |
-- | `<c-t>` | open web                                     |
-- | `<c-r>` | request run rerun                            |
-- Telescope gh gist
-- Telescope gh issues
require('telescope').load_extension('coc')
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
require('telescope').load_extension('bookmarks')
require("telescope").load_extension("emoji")
require('telescope').load_extension('env')
require("telescope").load_extension("notify")

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

require('coverage').setup {}

require('harpoon').setup {}

-- autocmd for opening file in vsplit:
local group = vim.api.nvim_create_augroup("Harpoon Augroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "harpoon",
    group = group,
    callback = function()
        vim.keymap.set("n", "<C-V>", function()
            local curline = vim.api.nvim_get_current_line()
            local working_directory = vim.fn.getcwd() .. "/"
            vim.cmd("vs")
            vim.cmd("e " .. working_directory .. curline)
        end, { noremap = true, silent = true })
    end,
})

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
        split = '<C-s>',
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
            action_for = {['ctrl-s'] = 'split', ['ctrl-t'] = 'tab drop'},
            extra_opts = {'--bind', 'ctrl-o:toggle-all', '--prompt', '> '}
        }
    }
})

require('nvim-tree').setup {
  git = {
    ignore = false,
  },
  disable_netrw       = false,
  hijack_netrw        = false,
  ignore_ft_on_setup  = {"startify"},
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
    mappings = {
      list = {}
    },
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
leap.setup {
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
}
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

require('refactoring').setup({})
require("telescope").load_extension("refactoring")
require("dir-telescope").setup({
  hidden = true,
  respect_gitignore = true,
})

-- remap to open the Telescope refactoring menu in visual mode
vim.api.nvim_set_keymap(
  "v",
  "<space>rr",
  "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
  { noremap = true }
)

EOF

" Plug 'ThePrimeagen/harpoon'
" left index finger
nnoremap <silent>\f :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <silent>\d :lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>

" lift the finger to do sth "dangerous"
nnoremap <silent>\g :lua require("harpoon.mark").add_file()<CR>
nnoremap <silent>\f :lua require("harpoon.mark").add_file()<CR>

" right home row, no finger lifting required
nnoremap <silent>\j :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <silent>\k :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <silent>\l :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <silent>\; :lua require("harpoon.ui").nav_file(4)<CR>

nnoremap <silent>\n :lua require("harpoon.ui").nav_next()<CR>
nnoremap <silent>\p :lua require("harpoon.ui").nav_prev()<CR>

nnoremap <silent>\tj :lua require("harpoon.tmux").gotoTerminal(1)<CR>
nnoremap <silent>\tk :lua require("harpoon.tmux").gotoTerminal(2)<CR>
nnoremap <silent>\cj :lua require("harpoon.tmux").sendCommand(1, 1)<CR>
nnoremap <silent>\ck :lua require("harpoon.tmux").sendCommand(1, 2)<CR>


" Plug 'shivamashtikar/tmuxjump.vim'
nmap <leader>jf :TmuxJumpFile<cr>
" :TmuxJumpFile js & :TmuxJumpFirst js

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

" Plug 'gabrielpoca/replacer.nvim'
" lua require("replacer").run()
" lua require("replacer").run({ rename_files = false })
" https://www.reddit.com/r/vim/comments/lwr56a/search_and_replace_camelcase_to_snake_case/

" Plug 'kevinhwang91/nvim-bqf'
" zf - fzf in quickfix
" zp - toggle full screen preview
" zn or zN - create new quickfix list
" < - previous quickfix list
" > - next quickfix list
" c-x (split)

lua << EOF

local rails_controller_patterns = {
  { target = "/spec/factories/%1.rb", context = "factories", transformer = "singularize" },
  { target = "/app/models/%1.rb", context = "models", transformer = "singularize" },
  { target = "/app/views/%1/**/*.html.*", context = "view" },
}

require("other-nvim").setup({
  rememberBuffers = false,
  mappings = {
    {
      pattern = "/src/(.*)/.*.js$",
      target = "/src/%1/\\(*.css\\|*.scss\\)",
    },
    {
      pattern = "/src/(.*)/.*.ts$",
      target = "/src/%1/\\(*.css\\|*.scss\\)",
    },
    {
      pattern = "/app/models/(.*).rb",
      target = {
        { target = "/spec/factories/%1.rb", context = "factories" },
        { target = "/app/controllers/**/%1_controller.rb", context = "controller", transformer = "pluralize" },
        { target = "/app/views/%1/**/*.html.*", context = "view", transformer = "pluralize" },
      },
    },
    {
      pattern = "/app/controllers/.*/(.*)_controller.rb",
      target = rails_controller_patterns,
    },
    {
      pattern = "/app/controllers/(.*)_controller.rb",
      target = rails_controller_patterns,
    },
    {
      pattern = "/app/views/(.*)/.*.html.*",
      target = {
        { target = "/spec/factories/%1.rb", context = "factories", transformer = "singularize" },
        { target = "/app/models/%1.rb", context = "models", transformer = "singularize" },
        { target = "/app/controllers/**/%1_controller.rb", context = "controller", transformer = "pluralize" },
      },
    },
    {
      pattern = "/app/models/(.*).rb",
      target = "/spec/models/%1_test.rb",
      context = "spec"
    },
    {
      pattern = "/app/controllers/(.*).rb",
      target = "/spec/controllers/%1_test.rb",
      context = "spec"
    },
    {
      pattern = "/app/channels/(.*).rb",
      target = "/test/channels/%1_test.rb",
      context = "spec"
    },
    {
      pattern = "/app/mailers/(.*).rb",
      target = "/spec/mailers/%1_test.rb",
      context = "spec"
    },
    {
      pattern = "/app/serializers/(.*).rb",
      target = "/spec/serializers/%1_test.rb",
      context = "spec"
    },
    {
      pattern = "/app/services/(.*).rb",
      target = "/spec/services/%1_test.rb",
      context = "spec"
    },
    {
      pattern = "/app/workers/(.*).rb",
      target = "/spec/workers/%1_test.rb",
      context = "spec"
    },
    {
      pattern = "/lib/(.*).rb",
      target = "/spec/lib/%1_test.rb",
      context = "spec"
    },
  }
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
