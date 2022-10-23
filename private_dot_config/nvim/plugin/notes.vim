" Plug 'mattn/calendar-vim'
let g:calendar_no_mappings=0
nmap <Leader>wdc <Plug>CalendarV
nmap <Leader>wdC <Plug>CalendarH

" Plug 'alok/notational-fzf-vim'
" let g:nv_search_paths = ['~/Documents/notes']
let g:nv_search_paths = ['~/Library/Mobile Documents/com~apple~CloudDocs/Documents/notes']
let g:nv_create_note_key = 'ctrl-x'

" vimwiki & friends
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vimwiki_conceal_pre = 1
let g:vimwiki_hl_headers = 1 " highlight headers with different colors
let g:vimwiki_hl_cb_checked = 2 " highlight completed tasks and line
let g:vim_markdown_fenced_languages = ['viml=vim', 'bash=sh', 'javascript=js']
" let g:vimwiki_url_maxsave = 0 " display full url path

" fix `gx` command https://github.com/plasticboy/vim-markdown/issues/372#issuecomment-394237720
nnoremap <Plug> <Plug>Markdown_OpenUrlUnderCursor

" trying to make markdown snippets work
" let g:vimwiki_table_mappings=0
" autocmd FileType vimwiki UltiSnipsAddFiletypes vimwiki
let g:vimwiki_global_ext = 1 " don't hijack all .md files
let g:vimwiki_listsyms = ' ○◐●✓'

" NV-fzf floating window
function! FloatingFZF()
  let width = float2nr(&columns * 0.9)
  let height = float2nr(&lines * 0.6)
  let opts = { 'relative': 'editor',
             \ 'row': (&lines - height) / 2,
             \ 'col': (&columns - width) / 2,
             \ 'width': width,
             \ 'height': height,
             \}

  let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
  call nvim_win_set_option(win, 'winhl', 'Normal:MyHighlight')
endfunction
let g:nv_window_command = 'call FloatingFZF()'

" list of all files and sub-directory path'd files sorted by date modified
" function! g:init_funcs#fzf_nv()
function! SortWiki()
  let l:fzf_opts = {}
  let l:fzf_opts.sink = 'e'
  let l:fzf_opts.dir = '~/Library/Mobile Documents/com~apple~CloudDocs/Documents/notes'
  let l:fzf_opts.source = 'ls -td $(fd .)'
  let l:fzf_opts.options = '--delimiter ":" --preview="bat ~/Library/Mobile Documents/com~apple~CloudDocs/Documents/notes/{1}" --preview-window=right:80'
  call fzf#run(fzf#wrap(l:fzf_opts))
endfunction

let g:vimwiki_list = [{
  \ 'path': '~/Library/Mobile Documents/com~apple~CloudDocs/Documents/notes/',
  \ 'syntax': 'markdown',
  \ 'ext': '.md',
  \ 'auto_toc': 1,
  \ }]
" gln to toggle forward
" glp to toggle back
let g:coc_filetype_map = { 'vimwiki': 'markdown' } " register with coc-markdownlint

" default 'alok/notational-fzf-vim' search
nmap <Leader>wv :NV!<CR>
" better line search with ripgrep
nmap <Leader>wl :SearchNotes<CR>
" filename search
nmap <Leader>wf  :Files ~/Library/Mobile Documents/com~apple~CloudDocs/Documents/notes/<CR>
" need to call this way when using vim-plug on-demand
nmap <Leader>wdn :VimwikiMakeDiaryNote<CR>
" nmap <Leader>wdn <Plug>VimwikiMakeDiaryNote
nmap <Leader>wdy <Plug>VimwikiMakeYesterdayDiaryNote
nmap <Leader>wdt <Plug>VimwikiMakeTomorrowDiaryNote
" if wanting to use telescope for this: https://aymenhafeez.github.io/nvim-telescope/

command! -bang -nargs=* SearchNotes
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'dir': '~/Library/Mobile Documents/com~apple~CloudDocs/Documents/notes/'}), <bang>0)

command! -bang -nargs=* EditNote call fzf#vim#files('~/Library/Mobile Documents/com~apple~CloudDocs/Documents/notes', <bang>0)

command! -bang -nargs=0 NewNote
  \ call vimwiki#base#edit_file(":e", strftime('~/Library/Mobile Documents/com~apple~CloudDocs/Documents/notes/%F-%T.md'), "")

command! Diary VimwikiDiaryIndex

function InsertDate()
    :.!echo "= $(date) ="
    normal 2o
    :start
endfunction

augroup vimwikigroup
  autocmd!
  " do not set syntax to 'vimwiki'
  autocmd BufEnter *.md setl syntax=markdown
  " make syntax highlighting work
  autocmd BufEnter *.md :syntax enable
  " automatically update links on read diary
  autocmd BufRead,BufNewFile diary.md VimwikiDiaryGenerateLinks

  autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
  autocmd FileType markdown setlocal shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType markdown nmap <buffer> <silent> gf <Plug>VimwikiFollowLink<CR>

  " way to check if text is in file, if not insert: https://www.reddit.com/r/vim/comments/mpww63/adding_text_when_opening_a_new_buffer/
  " delete new line at end of file: https://vi.stackexchange.com/questions/29091/exclude-trailing-newline-when-reading-in-skeleton-file
  " https://vimtricks.com/p/automated-file-templates/ or read in from file
  " au BufNewFile ~/Documents/notes/diary/*.md
  " or break it out: https://levelup.gitconnected.com/reducing-boilerplate-with-vim-templates-83831f8ced12
  " autocmd BufNewFile ~/Library/Mobile Documents/com~apple~CloudDocs/Documents/notes/diary/*.md
  " autocmd BufNewFile */diary/*.md call InsertDate()
  " autocmd BufNewFile */diary/*.md
  "   \ call append(0,[
  "   \ "# " . split(expand('%:r'),'/')[-1], "",
  "   \ "***POMODORO***",
  "   \ "***OPEN FOCUS BAR***",
  "   \ "***Visible TODOs***", "",
  "   \ "## Daily checklist", "",
  "   \ "- [ ] Geekbot", "",
  "   \ "## Todo",  "",
  "   \ "## Unplanned",  "",
  "   \ "## Push",  "",
  "   \ "## Near Future",  "",
  "   \ "## Notes"])
augroup end

" Plug 'LudoPinelli/comment-box.nvim'
" nnoremap <Leader>bb :CBlbox<CR>
" vnoremap <Leader>bb :CBlbox<CR>
" nnoremap <Leader>bc :CBcbox<CR>
" vnoremap <Leader>bc :CBcbox<CR>
" nnoremap <Leader>bl :CBline<CR>
"

lua << EOF

-- require('headlines').setup {
--   vimwiki = {
--     source_pattern_start = "^```",
--     source_pattern_end = "^```$",
--     dash_pattern = "^---+$",
--     headline_pattern = "^#+",
--     headline_highlights = { "Headline" },
--     codeblock_highlight = "CodeBlock",
--     dash_highlight = "Dash",
--     dash_string = "-",
--     fat_headlines = true,
--   },
-- }

EOF

" Plug 'mtth/scratch.vim'
" persist scratch file for project session
let g:scratch_persistence_file = '.scratch.vim'
" don't hide when leaving window
let g:scratch_autohide = 1
" don't autohide when leaving insert mode
let g:scratch_insert_autohide = 1
let g:scratch_filetype = 'scratch'
let g:scratch_height = 5
let g:scratch_top = 1
let g:scratch_horizontal = 1
let g:scratch_no_mappings = 1
nmap <leader>sp :ScratchPreview<CR>
