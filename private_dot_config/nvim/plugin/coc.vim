let g:coc_enable_locationlist = 0
          " \ 'coc-import-cost',
          " \ 'coc-solargraph',
          " \ 'coc-lightbulb',
let g:coc_global_extensions = [
          \ 'coc-css',
          \ 'coc-cssmodules',
          \ 'coc-db',
          \ 'coc-docker',
          \ 'coc-emmet',
          \ 'coc-eslint',
          \ 'coc-git',
          \ 'coc-go',
          \ 'coc-html',
          \ 'coc-jest',
          \ 'coc-json',
          \ 'coc-lists',
          \ 'coc-markdownlint',
          \ 'coc-marketplace',
          \ 'coc-pairs',
          \ 'coc-prettier',
          \ 'coc-react-refactor',
          \ 'coc-sh',
          \ 'coc-snippets',
          \ 'coc-styled-components',
          \ 'coc-stylelintplus',
          \ 'coc-sumneko-lua',
          \ 'coc-svg',
          \ 'coc-swagger',
          \ 'coc-tsserver',
          \ 'coc-vimlsp',
          \ 'coc-webpack',
          \ 'coc-yaml',
          \ 'coc-yank'
          \ ]

" DEFAULT COC.NVIM START

set updatetime=100

" Give more space for displaying messages
set cmdheight=2

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
set shortmess+=S
set shortmess+=F
" shortmess=filnxtToOFsIc
" shortmess=aoOcSF

" leave space for git, diagnostics and marks
set signcolumn=auto:5

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" also allow <tab>/<s-tab> to move in completion list.
" <tab> /<s-tab> snippet mappings take precedence
" Insert <tab> when previous text is space, refresh completion if not.
" *** this conflicts with 'abecodes/tabout.nvim'***
" inoremap <silent><expr> <TAB>
"       \ coc#pum#visible() ? coc#pum#next(1) :
"       \ CheckBackspace() ? "\<Tab>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" https://github.com/neoclide/coc.nvim/wiki/F.A.Q#tab-not-working-well-with-copilotvim
" let g:copilot_no_tab_map = v:true
" inoremap <silent><expr> <TAB>
"       \ exists('b:_copilot.suggestions') ? copilot#Accept("\<CR>") :
"       \ CheckBackspace() ? "\<Tab>" :
"       \ coc#refresh()
      " \ "\<Plug>(Tabout)"

" inoremap <silent><expr> <TAB>
"       \ exists('b:_copilot.suggestions') ? copilot#Accept("\<CR>") :
"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"       \ CheckBackSpace() ? "\<TAB>" :
"       \ coc#refresh()
      " \ "\<Plug>(Tabout)"
      "
" inoremap <expr> <C-j>
"       \ coc#pum#visible() ? coc#pum#next(1) :
"       \ "\<Tab>"

" from coc.nvim wiki
" inoremap <silent><expr> <TAB>
      " \ pumvisible() ? coc#_select_confirm() :
      " \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      " \ CheckBackSpace() ? "\<TAB>" :
      " \ coc#refresh()

" use C-j, C-k to move in completion list
inoremap <expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" tell coc how to navigate to next snippet placeholder
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, this will select first item on <cr>
inoremap <silent><expr> <CR>
      \ coc#pum#visible() ?
      \ coc#pum#confirm() :
      \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)
nmap <silent> [D <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]D <Plug>(coc-diagnostic-next-error)

nmap [c <Plug>(coc-git-prevchunk)
nmap ]c <Plug>(coc-git-nextchunk)

nmap [g <Plug>(coc-git-prevconflict)
nmap ]g <Plug>(coc-git-nextconflict)

" add? CocCommand document.toggleInlayHint
nmap <silent> <space>ghs <cmd>CocCommand git.chunkStage<cr>
nmap <silent> <space>ghu <cmd>CocCommand git.chunkUnstage<cr>
nmap <silent> <space>gu  <cmd>CocCommand git.chunkUndo<cr>
vmap <silent> <space>gu  <cmd>CocCommand git.chunkUndo<cr>
nmap <silent> <space>gb  <cmd>CocCommand git.showBlameDoc<cr>
nmap <silent> <space>gi  <Plug>(coc-git-chunkinfo)

omap <silent> ig <Plug>(coc-git-chunk-inner)
xmap <silent> ig <Plug>(coc-git-chunk-inner)

" local declaration
nmap <silent> gd <Plug>(coc-definition)
" global declaration
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gu <Plug>(coc-references-used)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gm <Plug>(coc-implementation)

nmap <space>cn <Plug>(coc-rename)

" refactor buffer
nmap <space>cb <Plug>(coc-refactor)

nmap <silent> <space>re <Plug>(coc-codeaction-refactor)
xmap <silent> <space>rs <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <space>rs <Plug>(coc-codeaction-refactor-selected)

nmap <space>cf <Plug>(coc-fix-current)
nmap <space>ce <Plug>(coc-codelens-action)
nmap <space>cc <Plug>(coc-codeaction-cursor)
nmap <space>cS <Plug>(coc-codeaction-source)
nmap <space>cl <Plug>(coc-codeaction-line)
vmap <space>cs <Plug>(coc-codeaction-selected)
nmap <space>cs <Plug>(coc-codeaction-selected)

" incoming calls
nmap <space>cki <Cmd>CHI<cr>
" outgoing calls
nmap <space>cko <Cmd>CHO<cr>
nmap <space>co  <Cmd>CocOutline<cr>
" nmap <space>cw  <Cmd>CocSearch -w <C-R><C-W><cr>
nmap <space>cr  <Cmd>CocRestart<CR>

" show outline for each tab automatically
" autocmd VimEnter,Tabnew *
"   \ if empty(&buftype) | call CocActionAsync('showOutline', 1) | endif

" nmap <space> <Plug>(coc-format)
" nmap <space> <Cmd>CocCommand eslint.executeAutofix<cr>
" nmap <space> <Cmd>CocCommand tsserver.organizeImports<cr>
" nmap <space> <Cmd>CocCommand tsserver.findAllFileReferences<cr>
command! -nargs=0 TscGTSD  :call CocAction('runCommand', 'tsserver.goToSourceDefinition')
" ? autocmd FileType typescriptreact,javascript,javascriptreact,typescript nnoremap <buffer> <silent> gd :TscGTSD<cr>
command! -nargs=0 Tsc      :call CocAction('runCommand', 'tsserver.watchBuild')
command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 Format   :call CocActionAsync('format')
command! -nargs=? Fold     :call CocAction('fold', <f-args>)
command! -nargs=0 OR       :call CocActionAsync('runCommand', 'editor.action.organizeImport')
command! -nargs=0 CHI      :call CocActionAsync('runCommand', 'document.showIncomingCalls')
command! -nargs=0 CHO      :call CocActionAsync('runCommand', 'document.showOutgoingCalls')

nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" https://github.com/neoclide/coc.nvim/issues/1775
let g:coc_disable_transparent_cursor = 1

" max items to show in popup list
set pumheight=20

" Do default action for next item.
nnoremap <silent><nowait> <space>an <Cmd>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>ap <Cmd>CocPrev<CR>

command -nargs=0 Swagger :CocCommand swagger.render

" switch diagnostic to float for full message displaty
" nmap <leader>cf :call coc#config('diagnostic.messageTarget', 'echo')<CR>
" nmap <leader>cf :call coc#config('diagnostic.virtualText', v:true)<CR>
" " make it toggle
" nmap <leader>ct :call coc#config('diagnostic.messageTarget', 'float')<CR>
" nmap <leader>ct :call coc#config('diagnostic.virtualText', v:false)<CR>

" coc-fzf remappings
let g:coc_fzf_opts= ['--layout=reverse']
let g:coc_fzf_preview='right:50%'
let g:coc_fzf_preview_fullscreen=0
let g:coc_fzf_preview_toggle_key='\'

lua << EOF
require("telescope").setup({
  extensions = {
    coc = {
        theme = 'ivy',
        prefer_locations = true,
    }
  },
})
require('telescope').load_extension('coc')
-- require('coc-code-action-menu')
EOF
" fannheyward/telescope-coc.nvim
" mru
" links
" references
" definitions
" declarations
" implementations
" type_definitions
" code_actions
" line_code_actions
nnoremap <silent><nowait> <space>za :Telescope coc file_code_actions<CR>
nnoremap <silent><nowait> <space>zd :Telescope coc diagnostics<CR>
nnoremap <silent><nowait> <space>zD :Telescope coc workspace_diagnostics<CR>
nnoremap <silent><nowait> <space>zc :Telescope coc commands<CR>
nnoremap <silent><nowait> <space>zl :Telescope coc locations<CR>
nnoremap <silent><nowait> <space>zs :Telescope coc workspace_symbols<CR>
nnoremap <silent><nowait> <space>zS :Telescope coc document_symbols<CR>

nnoremap <silent><nowait> <space>zo <Cmd>CocFzfList outline<CR>
" nnoremap <silent><nowait> <space>zS <Cmd>CocFzfList symbols <C-R><C-W><CR>
nnoremap <silent><nowait> <space>zy <Cmd>CocFzfList yank<CR>
nnoremap <silent><nowait> <leader>zf :call <SID>coc_qf_diagnostic()<CR>

function! s:coc_qf_diagnostic() abort
  if !get(g:, 'coc_service_initialized', 0)
    return
  endif
  let diagnostic_list = CocAction('diagnosticList')
  let items = []
  let loc_ranges = []
  for d in diagnostic_list
    let text = printf('[%s%s] %s', (empty(d.source) ? 'coc.nvim' : d.source),
          \ (d.code ? ' ' . d.code : ''), split(d.message, '\n')[0])
    let item = {'filename': d.file, 'lnum': d.lnum, 'col': d.col, 'text': text, 'type':
          \ d.severity[0]}
    call add(loc_ranges, d.location.range)
    call add(items, item)
  endfor
  call setqflist([], ' ', {'title': 'CocDiagnosticList', 'items': items,
        \ 'context': {'bqf': {'lsp_ranges_hl': loc_ranges}}})
  botright copen
endfunction

function! s:coc_qf_jump2loc(locs) abort
  let loc_ranges = map(deepcopy(a:locs), 'v:val.range')
  call setloclist(0, [], ' ', {'title': 'CocLocationList', 'items': a:locs,
        \ 'context': {'bqf': {'lsp_ranges_hl': loc_ranges}}})
  let winid = getloclist(0, {'winid': 0}).winid
  if winid == 0
    rightbelow lwindow
  else
    call win_gotoid(winid)
  endif
endfunction


augroup CocGroup
  autocmd!
  " Highlight the symbol and its references when holding the cursor
  autocmd CursorHold * call CocActionAsync('highlight')
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocActionAsync('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd User CocQuickfixChange :CocList --normal quickfix
  " automatically open quickfix for coc-references, etc. conflicts with CocFzfList
  " autocmd User CocLocationsChange ++nested call s:coc_qf_jump2loc(g:coc_jump_locations)

  " disable autocomplete for vimwiki, ctrl+space to trigger in insert mode
  " autocmd filetype vimwiki,markdown let b:coc_suggest_disable = 1
  " have snippets complete, only? mess with this: https://github.com/neoclide/coc.nvim/blob/804a007033bd9506edb9c62b4e7d2b36203ba479/doc/coc.txt#L908

  " close preview when completion is done
  autocmd CompleteDone * if pumvisible() == 0 | pclose | endif

  " autocmd BufWritePre *.md CocCommand markdownlint.fixAll
  " autocmd BufWritePost *.md CocCommand markdownlint.fixAll | echo 'hi'
  " autocmd BufWritePost *.jsx,*.js CocCommand eslint.executeAutofix
  autocmd FileType TelescopePrompt let b:coc_pairs_disabled = ["'"]

  " make sure to kill coc pid when closing nvim (not sure if needed)
  " autocmd VimLeavePre * if get(g:, 'coc_process_pid', 0)
  "     \	| call system('kill -9 '.g:coc_process_pid) | endif
  " run this also?
  " :CocCommand workspace.clearWatchman

  " autocmd VimLeave * if get(g:, 'coc_process_pid', 0) | call system('kill -9 -'.g:coc_process_pid) | endif

  " autocmd FileType python let b:coc_root_patterns = ['app.py']
  hi default link CocHighlightText TabLineSel
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

  " Coc autocomplete menu
  hi default link CocPumSearch Statement
augroup end
