" Run PlugUpgrade and PlugUpdate every day automatically when entering Vim.
function! OnVimEnter() abort
  if exists('g:plug_home')
    let l:filename = printf('%s/.vim_plug_update', g:plug_home)
    if filereadable(l:filename) == 0
      call writefile([], l:filename)
    endif

    " let l:this_day = strftime('%Y_%V') " weekly
    let l:this_day = strftime('%Y_%m_%d')
    let l:contents = readfile(l:filename)
    if index(l:contents, l:this_day) < 0
      " run update then run Diff when fully completed
      call execute('PlugUpgrade | PlugUpdate --sync | PlugDiff')
      " call execute('source $MYVIMRC')
      call writefile([l:this_day], l:filename, 'a')
    endif
  endif
endfunction

" `gx` to open vim-plug plugin on github.com
function! PlugGx()
  let l:line = getline('.')
  let l:sha  = matchstr(l:line, '^  \X*\zs\x\{7,9}\ze ')

  if (&filetype ==# 'vim-plug')
    " inside vim plug splits such as :PlugStatus
    let l:name = empty(l:sha)
                  \ ? matchstr(l:line, '^[-x+] \zs[^:]\+\ze:')
                  \ : getline(search('^- .*:$', 'bn'))[2:-2]
  else
    " in .vimrc.bundles
    try
      let l:name = matchlist(l:line, '\v/([A-Za-z0-9\-_\.]+)')[1]
    catch
      let l:name = "browsersearch"
    endtry
  endif

  if (l:name ==# 'browsersearch')
    echo "NOPE"
  else
    let l:uri  = get(get(g:plugs, l:name, {}), 'uri', '')
    if l:uri !~ 'github.com'
      return
    endif
    " this works but not as vim regex [^:\/]*\/nvim-treesitter(?!.*nvim-treesitter)
    " try this? https://github.com/junegunn/gv.vim/blob/master/plugin/gv.vim#L158-L171
    let l:repo = matchstr(l:uri, '[^:/]*/'.l:name)
    let l:url  = empty(l:sha)
                \ ? 'https://github.com/'.l:repo
                \ : printf('https://github.com/%s/commit/%s', l:repo, l:sha)
    call netrw#BrowseX(l:url, 0)
  endif
endfunction

" the `gx` above doesn't go to correct repo when org/repo name is the same
function! s:open_plug_gh()
  let line = getline('.')
  let line = trim(line)
  let plug_regex = '\vPlug [''"](.{-})[''"].*'
  let path = substitute(line, plug_regex, '\1', '')
  let url = 'https://github.com/' .. path
  exec "!open '"..url.."'"
endfunction
nnoremap <Leader>gx :call <SID>open_plug_gh()<CR><CR>

" `gx` to open package.json lib on npmjs.com
function! PackageJsonGx() abort
  let l:line = getline('.')
  let l:package = matchlist(l:line, '\v"(.*)": "(.*)"')
  if len(l:package) > 0
    let l:package_name = l:package[1]
    let l:url = 'https://www.npmjs.com/package/' . l:package_name
    call netrw#BrowseX(l:url, 0)
  endif
endfunction

" PlugDiff commit preview browsing
let g:plug_pwindow='vertical botright split'
function! s:scroll_preview(down)
  silent! wincmd P
  if &previewwindow
    execute 'normal!' a:down ? "\<c-d>" : "\<c-u>"
    wincmd p
  endif
endfunction

function! s:setup_extra_keys()
  nnoremap <silent> <buffer> J :call <sid>scroll_preview(1)<cr>
  nnoremap <silent> <buffer> K :call <sid>scroll_preview(0)<cr>
  nnoremap <silent> <buffer> <c-n> :call search('^  \X*\zs\x')<cr>
  nnoremap <silent> <buffer> <c-p> :call search('^  \X*\zs\x', 'b')<cr>
  nmap <silent> <buffer> <c-j> <c-n>o
  nmap <silent> <buffer> <c-k> <c-p>o
endfunction

augroup LibGroup
  autocmd!
  autocmd BufRead,BufNewFile *.vim nnoremap <buffer> <silent> gx :call PlugGx()<cr>
  autocmd BufRead,BufNewFile *.lua nnoremap <buffer> <silent> gx :call PlugGx()<cr>
  autocmd BufRead,BufNewFile package.json nnoremap <buffer> <silent> gx :call PackageJsonGx()<cr>
  autocmd FileType vim-plug nnoremap <buffer> <silent> gx :call PlugGx()<cr>
  autocmd FileType vim-plug call s:setup_extra_keys()
  autocmd VimEnter * call OnVimEnter()
" Automatically install missing plugins on startup
  autocmd VimEnter *
    \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \|   PlugInstall --sync | q
    \| endif
augroup end

" fzf plug help browser
function! s:plug_help_sink(line)
  let dir = g:plugs[a:line].dir
  for pat in ['doc/*.txt', 'README.md']
    let match = get(split(globpath(dir, pat), "\n"), 0, '')
    if len(match)
      execute 'tabedit' match
      return
    endif
  endfor
  tabnew
  execute 'Explore' dir
endfunction

command! PlugHelp call fzf#run(fzf#wrap({ 'source': sort(keys(g:plugs)), 'sink': function('s:plug_help_sink')}))
