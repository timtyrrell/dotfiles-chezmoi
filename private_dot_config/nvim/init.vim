lua << EOF
  -- disable netrw at the very start of your init.vim (strongly advised)
  vim.g.loaded = 1
  vim.g.loaded_netrwPlugin = 1
EOF

let base16colorspace=256
set termguicolors

" maybe faster load??
" set shell=/opt/homebrew/bin/bash

set title "displays current file as vim title
set visualbell "kills the bell
set t_vb= "kills the bell

cnoremap <expr> <c-n> wildmenumode() ? "\<c-n>" : "\<down>"
cnoremap <expr> <c-p> wildmenumode() ? "\<c-p>" : "\<up>"

set wildmode=longest:full,full
set wildoptions=pum
" set wildoptions+=pum
" Enables pseudo-transparency for the popup-menu, 0-100
set pumblend=20
set wildcharm=<Tab>
" set completeopt+=noselect,noinsert,menuone,preview
" set completeopt=menuone,noinsert,noselect,preview
set completeopt=menuone,preview

" ignore case, example: :e TEST.js
set wildignorecase

" don't have vim autocomplete these ever
set wildignore+=tags
set wildignore+=package-lock.json
set wildignore+=**/*.xml
" off for telescope-node_modules usage
" set wildignore+=**/node_modules/*
set wildignore+=**/.git/*

" give low priority to files matching the defined patterns.
set suffixes+=.lock,.scss,.sass,.min.js,.less,.json

" controls the behavior when switching between buffers. Mostly for |quickfix| commands
set switchbuf=useopen,usetab

let mapleader = ','

" add < and > to matched pairs
set matchpairs+=<:>

" Clear cmd line message after X seconds
function! s:empty_message(timer)
  if mode() ==# 'n'
    echon ''
  endif
endfunction

augroup cmd_msg_cls
  autocmd!
  autocmd CmdlineLeave : call timer_start(10000, funcref('s:empty_message'))
augroup END

" remove delay hitting ESC to cancel, etc
set timeoutlen=1000 ttimeoutlen=0

" hide line showing switch in insert/normal mode
set noshowmode
set noruler
set splitright
set splitbelow
set hidden " allows you to abandon a buffer without saving
set smartindent " Keep indentation from previous line
set showbreak=↳
set expandtab " Use softtabstop spaces instead of tab characters
set softtabstop=2 " Indent by 2 spaces when pressing <TAB>
set shiftwidth=2 " Indent by 2 spaces when using >>, <<, == etc.
set showtabline=2 " always display vim tab bar
set breakindent
set breakindentopt=shift:2

set number

" display line movements unless preceded by a count
" also recording jump points for movements larger than five lines
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" force decimal-based arithmetic on increment/decrement
set nrformats=
" increment and decrement
" nnoremap + <C-a>
" nnoremap - <C-x>
"  visual mode, also
" xnoremap + g<C-a>
" xnoremap - g<C-x>

" dot repetition over visual line selections.
xnoremap . :norm.<CR>

" run macro over visual lines (using qq to record)
xnoremap Q :'<,'>:normal @q<CR>

" https://www.reddit.com/r/neovim/comments/tsol2n/why_macros_are_so_slow_compared_to_emacs/
" overload @ key to execute the macro avoiding any auto command that may be triggred during insert mode or text change
" :noautocmd normal 10000@q
xnoremap @ <Cmd>execute "noautocmd '<,'>norm! " . v:count1 . "@" . getcharstr()<cr>

" backup/undo management
set nobackup
set nowritebackup
set noswapfile " Disable swapfile
" setup persistent undo
set undofile

" search highlighting/behavior
set hlsearch
set incsearch

" Make <C-p>/<C-n> act like <Up>/<Down> in cmdline mode, so they can be used to navigate history with partially completed commands
cnoremap <c-p> <up>
cnoremap <c-n> <down>
cnoremap <up> <c-p>
cnoremap <down> <c-n>

" use c-k/j to navigate cmdline menu
cnoremap <c-k> <Left>
cnoremap <c-j> <Right>

" juggling with jumps
nnoremap ' `
set jumpoptions=stack

set ignorecase
set infercase " enhances ignorecase
set smartcase
set inccommand=nosplit "highlight :s in realtime

" allows block selections to operate across lines regardless of the underlying text
set virtualedit=block
set selection=old

set diffopt+=vertical,algorithm:patience
" Use a (usually) better diff algorithm
set diffopt+=indent-heuristic
" nvim 9.x only
set diffopt+=linematch:800
" disable showing '------' for empty line in difftool
set fillchars+=diff:╱

set complete-=t " disable searching tags

" Toggle spell checking on/off
nmap <silent> <leader>ss :set spell!<CR>
set spelllang=en_us
set complete+=kspell
" z=, to get a suggestion
" ]s means go to next misspelling,
" [s is back. When you land on the word
" zw to add it to your Private dictionary
" zuw if you make a mistake to remove it from you dictionary
function! FzfSpellSink(word)
  exe 'normal! "_ciw'.a:word
endfunction

function! FzfSpell()
  let suggestions = spellsuggest(expand('<cword>'))
  return fzf#run({'source': suggestions, 'sink': function('FzfSpellSink'), 'options': '--preview-window hidden', 'down': 20})
endfunction
nnoremap z= :call FzfSpell()<CR>
nmap <silent> <leader>sz :call FzfSpell()<CR>

" keep windows same size when opening/closing splits
set equalalways

augroup STUFFS
  autocmd!
  " resize panes the host window is resized
  autocmd VimResume,VimResized, NvimTreeOpen, NvimTreeClose * wincmd =
  autocmd VimResized,VimResume * execute "normal! \<C-w>="

" only highlight cursorline in current active buffer, when not in insert mode
  autocmd InsertLeave,WinEnter * set cursorline
  autocmd InsertEnter,WinLeave * set nocursorline

  " autocmd BufWritePost * if &diff | diffupdate | endif " update diff after save

  " go back to previous tab when closing tab
  autocmd TabClosed * tabprevious
augroup END

"sessions
set sessionoptions-=buffers
set sessionoptions-=help
set sessionoptions-=folds
set sessionoptions-=blank
" results with those ^: sessionoptions=blank,curdir,tabpages,winsize,terminal

" split windows
nnoremap <C-w>- <cmd>new<cr>
nnoremap <C-w><bar> <cmd>vnew<cr>

function! InsertFilePath()
  execute 'normal i'.expand('%:p:h').'/'
endfunction
noremap <leader>ef :call InsertFilePath()<CR>

" open :e based on current file path
noremap <Leader>ep :e <C-R>=expand('%:p:h') . '/' <CR>
" Opens a new tab with the current buffer's path
noremap <leader>eb :tabedit <C-r>=expand("%:p:h")<CR>/
" Prompt to open file with same name, different extension
noremap <leader>er :e <C-R>=expand("%:r")."."<CR>

" Switch CWD to the directory of the open buffer
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" change directory to folder of current file
nnoremap <leader>cf :cd %:p:h<cr>

" open file under cursor anywhere on line
" https://www.reddit.com/r/vim/comments/mcxha4/remapping_gf_to_open_a_file_from_anywhere_on_the/
nnoremap gf ^f/gf

" https://www.reddit.com/r/vim/comments/ydjpkg/using_gf_command_on_file_in_bash_script/
set isfname-==

" open file under cursor in vertical split
map <C-w>f <C-w>vgf

" hide the command history buffer. Use fzf :History instead
nnoremap q: <nop>

" disable mouse
set mouse=

" keep foreground commands in sync
" map fg <c-z>
" or the reverse, add this to shell profile
" stty susp undef
" bind '"\C-z":"fg\n"'

" format json
nnoremap <silent> <Leader>jj :set ft=json<CR>:%!jq .<CR>

" format html
" nnoremap <silent> <Leader>ti :%!tidy -config ~/.config/tidy_config.txt %<CR>

" remove smart quotes
" %!iconv -f utf-8 -t ascii//translit

" save with Enter *except* in quickfix buffers
" https://vi.stackexchange.com/questions/3127/how-to-map-enter-to-custom-command-except-in-quick-fix
nnoremap <expr> <silent> <CR> &buftype ==# "quickfix" ? "\<CR>" : ":write<CR>"
" nnoremap <expr> <silent> <CR> &buftype ==# "quickfix" ? "\<CR>" : ":write!<CR>"
nnoremap <Enter> :w<Enter>
" Keep default CR behaviour for quickfix list
augroup quickfix
  autocmd!
  autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
augroup END

" can check type, not just name like:
" another option
" autocmd FileType qf nnoremap <buffer> <cr> <cr>

" train myself to use better commands
" ZZ - Write current file, if modified, and close current window (:x)
" ZQ - Quit without checking for changes (same as ':q!')
map QQ :qa!<CR>
map QA :qa<CR>
cabbrev q! use ZQ
" cabbrev wq use :x or ZZ
" cabbrev wq! use :x

" speedup :StartTime - :h g:python3_host_prog
let g:python3_host_prog = '/opt/homebrew/bin/python3'
" let g:python3_host_prog = '/opt/homebrew/opt/python@3.10/libexec/bin/python'
" let g:python3_host_prog = '~/.pyenv/shims/python3'
" let g:loaded_python_provider = 1
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
" let g:loaded_ruby_provider = 1 " use language server instead
" let g:loaded_node_provider = 1

let g:plug_threads = 5
call plug#begin('~/.config/nvim/plugged')
" if branch changes from master to main `git remote set-head origin -a` in `~/config/nvim/plugged/[plugin]`

" core code analysis and manipulation
           " \ Plug 'wellle/tmux-complete.vim' " coc completion from open tmux panes
" Plug 'neoclide/coc.nvim', { 'commit': '0a2c8b84474593a55090b1c4b565ff395cbe3bfe', 'do': 'yarn install --frozen-lockfile' } |
Plug 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'npm ci' } |
           \ Plug 'antoinemadec/coc-fzf'
Plug 'tjdevries/coc-zsh'
" Plug 'xiyaowong/coc-code-action-menu.nvim' | Plug 'weilbith/nvim-code-action-menu'
" Plug 'wix/import-cost', { 'do': 'npm install', 'rtp': 'packages/coc-import-cost' }

" Plug 'dmmulroy/tsc.nvim'

" https://github.com/github/copilot.vim/blob/release/doc/copilot.txt#L93
Plug 'github/copilot.vim'
nnoremap <silent> <Leader>cp <cmd>Copilot<CR>
nnoremap <silent> <Leader>ce <cmd>Copilot enable<CR>
nnoremap <silent> <Leader>cx <cmd>Copilot disable<CR>

inoremap                    <Up>   <Plug>(copilot-previous)
inoremap                    <Down> <Plug>(copilot-next)
inoremap                    <Left> <Plug>(copilot-dismiss)
imap <silent><script><expr> <Right> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

let g:copilot_filetypes = {
            \ 'vimwiki': v:false,
            \ }

" highlight CopilotSuggestion guifg=#555555 ctermfg=8

" wilder.nvim & CopilotChat.nvim
function! UpdateRemotePlugins(...)
  " Needed to refresh runtime files
  let &rtp=&rtp
  UpdateRemotePlugins
endfunction

" good config example: https://github.com/jellydn/lazy-nvim-ide/blob/main/lua/plugins/extras/copilot-chat.lua
Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'do': function('UpdateRemotePlugins') }
" { "<leader>ccc", ":CopilotChat ",                desc = "CopilotChat - Prompt" },
" { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
" { "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
" { "<leader>ccv", :CopilotChatVisual", mode = "x", desc = "CopilotChat - Open in vertical split", },
" { "<leader>ccx", :CopilotChatInPlace<cr>", mode = "x", desc = "CopilotChat - Run in-place code", },
" { "<leader>ccr", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
" { "<leader>ccR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },


"""""""""""""""""""""""""""""""""""" neovim-lsp

" Plug 'williamboman/mason.nvim'
" Plug 'williamboman/mason-lspconfig.nvim'
" Plug 'WhoIsSethDaniel/mason-tool-installer.nvim'
" Plug 'jayp0521/mason-nvim-dap.nvim'
" Plug 'neovim/nvim-lspconfig'

" Plug 'hrsh7th/nvim-cmp'
" Plug 'hrsh7th/cmp-nvim-lua'
" Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'hrsh7th/cmp-buffer'
" Plug 'hrsh7th/cmp-path'
" Plug 'hrsh7th/cmp-cmdline'
" Plug 'lukas-reineke/cmp-rg'
" Plug 'David-Kunz/cmp-npm'
" Plug 'SirVer/ultisnips'
" Plug 'quangnguyen30192/cmp-nvim-ultisnips'
" Plug 'zbirenbaum/neodim'
" Plug 'RRethy/vim-illuminate'
" https://git.sr.ht/~whynothugo/lsp_lines.nvim
" https://github.com/VidocqH/lsp-lens.nvim

" Plug 'jose-elias-alvarez/typescript.nvim'
" Plug 'b0o/schemastore.nvim'
"
" Plug 'marilari88/twoslash-queries.nvim'

" " Plug 'mfussenegger/nvim-lint'
" Plug 'jose-elias-alvarez/null-ls.nvim'
" Plug 'LostNeophyte/null-ls-embedded'
" " Plug 'lukas-reineke/lsp-format.nvim'

" Plug 'windwp/nvim-autopairs'

" Plug 'onsails/lspkind-nvim'
" Plug 'rmagatti/goto-preview'
" " Plug 'hrsh7th/cmp-nvim-lsp-signature-help' ?
" Plug 'ray-x/lsp_signature.nvim'
" Plug 'ray-x/navigator.lua' " Plug 'glepnir/lspsaga.nvim'
" Plug 'simrat39/symbols-outline.nvim'
" Plug 'filipdutescu/renamer.nvim', { 'branch': 'master' }
" weilbith/nvim-code-action-menu

" Plug 'lewis6991/gitsigns.nvim'
"
" Plug 'neovim/nvim-lspconfig'
" Plug 'SmiteshP/nvim-navic'
" Plug 'MunifTanjim/nui.nvim'
" Plug 'SmiteshP/nvim-navbuddy'
"
" https://github.com/DNLHC/glance.nvim

"""""""""""""""""""""""""""""""""""" neovim-lsp

" homebrew fzf path
Plug '/opt/homebrew/opt/fzf' |
           \ Plug 'junegunn/fzf.vim'

" buffer management
Plug 'AndrewRadev/undoquit.vim'

Plug 'tzachar/highlight-undo.nvim'

Plug 'kazhala/close-buffers.nvim'

Plug 'lambdalisue/suda.vim'
" Re-open a current file with sudo :SudaRead
" Forcedly save a current file with sudo :SudaWrite

" undo tree visualizer
Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }

Plug 'vhyrro/luarocks.nvim', {'do': ':source ./build.lua'}
Plug 'rest-nvim/rest.nvim'
map <leader>rr <Plug>RestNvim
map <leader>rp <Plug>RestNvimPreview
map <leader>rL <Plug>RestNvimLast

Plug 'rmagatti/auto-session'

" https://github.com/andrewferrier/debugprint.nvim/tree/main#alternative-feature-comparison
Plug 'meain/vim-printer'
let g:vim_printer_print_below_keybinding = '<leader>cl'
let g:vim_printer_print_above_keybinding = '<leader>cL'

let g:vim_printer_items = {
      \ 'javascript': "console.log('{$}:', {$});",
      \ 'typescriptreact': "console.log('{$}:', {$});",
      \ 'typescript': "console.log('{$}:', {$});",
      \ 'javascriptreact': "console.log('{$}:', {$});",
      \ 'ruby': 'puts "{$}", {$}',
      \ 'eruby': '<%= puts "{$}", {$} %>',
      \ 'slim': 'puts "{$}", {$}',
      \ }

" alternative: https://github.com/akinsho/toggleterm.nvim, :ToggleTermSendCurrentLine, etc
" or https://github.com/numToStr/FTerm.nvim, or https://github.com/voldikss/vim-floaterm
Plug 'preservim/vimux'
" Combine VimuxZoomRunner and VimuxInspectRunner in one function.
function! VimuxZoomInspectRunner()
  if exists("g:VimuxRunnerIndex")
    call VimuxTmux("select-pane -t ".g:VimuxRunnerIndex)
    call VimuxTmux("resize-pane -Z -t ".g:VimuxRunnerIndex)
    call VimuxTmux("copy-mode")
  endif
endfunction
map <Leader>vv     :call VimuxZoomInspectRunner()<CR>
map <Leader>vp     :VimuxPromptCommand<CR>
map <Leader>vl     :VimuxRunLastCommand<CR>
map <Leader>vi     :VimuxInspectRunner<CR>
map <leader>vz     :VimuxZoomRunner<CR>
map <Leader>vq     :VimuxCloseRunner<CR>
map <Leader>v<C-l> :VimuxClearTerminalScreen<CR>
map <Leader>vc     :VimuxClearRunnerHistory<CR>
map <Leader>vx     :VimuxInterruptRunner<CR>

" REPL usage
function! VimuxSlime()
  call VimuxClearTerminalScreen()
  call VimuxRunCommand(@v, 0)
  call VimuxSendKeys("Enter")
endfunction

" If text is selected, save it in the v buffer and send that buffer to tmux
vmap <leader>vs "vy :call VimuxSlime()<CR>
" Select current paragraph and send it to tmux
nmap <leader>vs vip<leader>vs<CR>
" send contents of entire buffer to tmux
nmap <leader>vb ggVG<leader>vs<CR>
" run file
nmap <Leader>vf :call VimuxRunCommand("clear; node " . bufname("%"))<CR>

Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
" pbogut/vim-dadbod-ssh
let g:db_ui_show_database_icon = 1
let g:db_ui_use_nerd_fonts = 1
let g:db_ui_force_echo_notifications = 1

" testing
Plug 'vim-test/vim-test'
Plug 'tpope/vim-dispatch'

" debugging
Plug 'mfussenegger/nvim-dap'
Plug 'theHamsta/nvim-dap-virtual-text'
" Plug 'folke/neodev.nvim'
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'
Plug 'David-Kunz/jester'
" Plug 'mxsdev/nvim-dap-vscode-js'

" syntax
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

" Plug 'mrjones2014/nvim-ts-rainbow'
" https://gitlab.com/HiPhish/nvim-ts-rainbow2

Plug 'windwp/nvim-ts-autotag'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

Plug 'RRethy/nvim-treesitter-endwise'

Plug 'mfussenegger/nvim-treehopper'
omap     <silent> m <Cmd>lua require('tsht').nodes()<CR>
xnoremap <silent> m :lua require('tsht').nodes()<CR>

Plug 'ThePrimeagen/refactoring.nvim'

Plug 'lukas-reineke/indent-blankline.nvim', { 'tag': 'v2.20.8' }

augroup tmuxgroups
  autocmd!
  autocmd FileType tmux nnoremap <silent><buffer> K :call tmux#man()<CR>
  " automatically source tmux config when saved
  autocmd BufWritePost .tmux.conf execute ':!tmux source-file %'
augroup END

Plug 'tmux-plugins/vim-tmux'
" https://github.com/nvim-treesitter/nvim-treesitter/issues/1019#issuecomment-812976740
let g:polyglot_disabled = [
        \ 'bash', 'comment', 'css', 'graphql',
        \ 'html', 'javascript', 'javascriptreact', 'jsdoc', 'json',
        \ 'jsonc', 'jsx', 'lua', 'python', 'regex', 'rspec', 'ruby',
        \ 'sh', 'svg', 'tmux', 'tsx', 'typescript', 'typescriptreact', 'yaml']
Plug 'sheerun/vim-polyglot'
" let g:polyglot_disabled = ['sensible']
" let g:polyglot_disabled = ['ftdetect']
let g:polyglot_disabled = ['autoindent']
let g:markdown_fenced_languages = ['ruby', 'sh', 'javascript', 'typescript', 'json']

Plug 'AndrewRadev/splitjoin.vim'
" gS to split a one-liner into multiple lines
" gJ (with the cursor on the first line of a block) to join a block into a single-line statement.

"removes trailing whitespace on save
Plug 'mcauley-penney/tidy.nvim'

Plug 'tyru/open-browser.vim'
let g:netrw_nogx = 1 " disable netrw's gx mapping.
let g:openbrowser_default_search = 'duckduckgo'
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" vim .dsl syntax https://github.com/vim/vim/pull/8764
" Plug 'shuntaka9576/preview-swagger.nvim', { 'build': 'yarn install' }
" Draw ASCII diagrams in Neovim.
" Plug 'jbyuki/venn.nvim'

Plug 'tpope/vim-abolish'

Plug 'mileszs/ack.vim'

" enhanced matchit
let g:loaded_matchit = 1
Plug 'andymass/vim-matchup'

" tab to exit enclosing character
Plug 'abecodes/tabout.nvim'

" Plug 'chaoren/vim-wordmotion'

Plug 'ggandor/leap.nvim'
Plug 'ggandor/flit.nvim'

Plug 'drmingdrmer/vim-toggle-quickfix'

Plug 'gabrielpoca/replacer.nvim'

Plug 'kevinhwang91/nvim-bqf'

Plug 'luukvbaal/statuscol.nvim'
Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo'
Plug 'kevinhwang91/nvim-fundo'

Plug 'christoomey/vim-tmux-navigator'
" keeping all navigation within Vim until the tmux pane is explicitly unzoomed
let g:tmux_navigator_disable_when_zoomed = 1

Plug 'christoomey/vim-system-copy'

Plug 'tpope/vim-commentary'

"Vim sugar for the UNIX shell commands
Plug 'tpope/vim-eunuch'

" try https://github.com/kana/vim-altr/blob/master/doc/altr.txt ?
Plug 'tpope/vim-projectionist'
Plug 'rgroli/other.nvim'
noremap <leader>of <cmd>Other<CR>
noremap <leader>oc <cmd>OtherClear<CR>
noremap <leader>ot <cmd>OtherTabNew<CR>
noremap <leader>ox <cmd>OtherSplitCR>
noremap <leader>ov <cmd>OtherVSplit<CR>

"gf support
Plug 'tpope/vim-apathy'

Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
"quoting/parenthesizing made simple
" {{{
    " mappings to quickly modify surrounding chars like ",],),},',<tag>
    " NORMAL MODE:
    "   ds<SURROUND> to delete surround
    "   cs<SURROUND><SURROUND> to change surround from/to
    "   ys<TEXT-OBJECT><SURROUND> to surround text object
    "   yS<TEXT-OBJECT><SURROUND> to surround text object on new line
    " VISUAL MODE:
    "   S<SURROUND>
    " INSERT MODE:
    "   <C-g>s<SURROUND>
  " }}}
" vitSt - add inner tag
" vatSt - add surrounding tag
" vS"    : visually surround selected text with "
" yswt : prompt & surround with a html tag
" yswf : prompt & surround with a function call
" ds" : delete surrounding "
" dst : delete surrounding tag (HTML)
" in case I need to unmap them: https://github.com/mgarort/dotvim/blob/e67260d70377c28a0d0a08d8f3733adb05d5d4bd/vimrc#L987-L1000

Plug 'tpope/vim-unimpaired'
" prev conflict/patch: [n , next conflict/patch: ]n , paste toggle: yop
" [<Space> and ]<Space> add newlines before and after the cursor line
" [e and ]e exchange the current line with the one above or below it.

" try https://github.com/wellle/targets.vim ?
" https://github.com/kana/vim-textobj-user/wiki
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'michaeljsmith/vim-indent-object'
Plug 'rhysd/vim-textobj-anyblock'

" https://github.com/mlaursen/vim-react-snippets#cheatsheet
Plug 'mlaursen/vim-react-snippets', { 'branch': 'main' }

" review linenumber before jump
Plug 'nacro90/numb.nvim'

Plug 'barrett-ruth/import-cost.nvim', { 'do': 'sh install.sh yarn' }

" git
let g:fugitive_gitlab_domains = ['https://git.lab.smartsheet.com']
Plug 'tpope/vim-fugitive' |
           \ Plug 'tpope/vim-rhubarb' |
           \ Plug 'junegunn/gv.vim'   |
           \ Plug 'shumphrey/fugitive-gitlab.vim'

Plug 'whiteinge/diffconflicts'

Plug 'sindrets/diffview.nvim'

Plug 'rhysd/git-messenger.vim'

" more pleasant editing of commit message
Plug 'rhysd/committia.vim'

" display diff while in interactive rebase
Plug 'hotwatermorning/auto-git-diff'

Plug 'kevinhwang91/nvim-hlslens'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'nvim-telescope/telescope-node-modules.nvim'
Plug 'LinArcX/telescope-env.nvim'
Plug 'debugloop/telescope-undo.nvim'
Plug 'piersolenski/telescope-import.nvim'

Plug 'pwntester/octo.nvim'
" Plug 'ldelossa/litee.nvim'
" Plug 'ldelossa/gh.nvim'

" Plug 'kkharji/sqlite.lua'
" Plug 'AckslD/nvim-neoclip.lua'

" Plug 'tami5/sql.nvim'

Plug 'fannheyward/telescope-coc.nvim'

Plug 'windwp/nvim-spectre'

Plug 'norcalli/nvim-terminal.lua'
" https://github.com/akinsho/toggleterm.nvim

Plug 'nvim-tree/nvim-web-devicons'

Plug 'echasnovski/mini.files'

Plug 'kyazdani42/nvim-tree.lua'
nnoremap <silent> <leader>ee :NvimTreeFindFile<CR>
nnoremap <silent> <leader>et :NvimTreeToggle<CR>
nnoremap <silent> <leader>er :NvimTreeRefresh<CR>

Plug 'ThePrimeagen/git-worktree.nvim'

Plug 'MunifTanjim/nui.nvim'
Plug 'vuki656/package-info.nvim'

Plug 'tpope/vim-scriptease'
" https://codeinthehole.com/tips/debugging-vim-by-example/#why-isn-t-syntax-highlighting-working-as-i-want
" zS to indentify the systen region name
" :verbose hi jsTemplateString
" :Messages load messages into quickfix

" smooth scroll
" Plug 'declancm/cinnamon.nvim'
Plug 'karb94/neoscroll.nvim'

Plug 'danilamihailov/beacon.nvim'

Plug 'chentoast/marks.nvim'

" displays colors for words/hex
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" wilder.nvim
function! UpdateRemotePlugins(...)
  " Needed to refresh runtime files
  let &rtp=&rtp
  UpdateRemotePlugins
endfunction

Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
Plug 'romgrk/fzy-lua-native', { 'do': 'make' }
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }

Plug 'nvim-lualine/lualine.nvim'

Plug 'nvim-zh/colorful-winsep.nvim'

Plug 'folke/tokyonight.nvim'
" Plug 'EdenEast/nightfox.nvim'
" Plug 'andersevenrud/nordic.nvim'
" Plug 'catppuccin/nvim'
" Plug 'bluz71/vim-nightfly-guicolors'

Plug 'shortcuts/no-neck-pain.nvim'

Plug 'voldikss/vim-browser-search'
nmap <silent> <Leader>bs <Plug>SearchNormal
vmap <silent> <Leader>bs <Plug>SearchVisual
let g:browser_search_default_engine = 'duckduckgo'

Plug 'airblade/vim-rooter'
" only run manually
" :Rooter
let g:rooter_manual_only = 1
" add git worktree to excludes
let g:rooter_patterns = ['!.bare', 'Gemfile', '.git', 'Makefile']
" trigger by symlinks, also
let g:rooter_resolve_links = 1
" to stop echo on change **KEEP ON**, echoes filename to cmdline
let g:rooter_silent_chdir = 1
" let g:rooter_buftypes = ['', 'nofile', 'nowrite', 'acwrite']

" vim --startuptime /dev/stdout +qall && echo && time vim +q
Plug 'dstein64/vim-startuptime'
" gf to go deeper
" K for more info
" Plug 'tweekmonster/startuptime.vim'

Plug 'vimwiki/vimwiki', { 'branch': 'dev', 'for': 'markdown', 'on': 'VimwikiMakeDiaryNote' }
Plug 'mattn/calendar-vim'
Plug 'alok/notational-fzf-vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

" markdown preview in nvim popup
Plug 'ellisonleao/glow.nvim', {'for': 'markdown'}
" Plug 'ellisonleao/glow.nvim'

" imbed images with drag and drop
" Plug 'HakonHarnes/img-clip.nvim'
" rendering in kitty/tmux
" Plug '3rd/image.nvim'

" Plug 'adelarsq/image_preview.nvim'
" Plug 'ekickx/clipboard-image.nvim'
" Plug 'edluffy/hologram.nvim'
" Plug 'img-paste-devs/img-paste.vim'
" Plug 'LudoPinelli/comment-box.nvim'

Plug 'folke/which-key.nvim'

" Plug 'ja-ford/delaytrain.nvim'
" Plug 'takac/vim-hardtime'
" Plug 'm4xshen/hardtime.nvim'

" typescript fork of 'ianding1/leetcode.vim'
" Plug 'briemens/leetcode.vim'

call plug#end()

" nvim/shada is dumb with marks, don't save for new session
" https://www.reddit.com/r/neovim/comments/q7bgwo/comment/hghwogp/?context=3
set shada=!,'0,f0,<50,s10,h

lua << EOF

require("luarocks-nvim").setup {
  rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" }
}

require('auto-session').setup {
  -- cwd_change_handling = {
  --   restore_upcoming_session = true,
  -- },
  session_lens = {
    load_on_setup = false,
  },
  log_level = 'error',
  auto_session_enabled = true,
  auto_save_enabled = true,
  auto_restore_enabled = true,
  auto_session_use_git_branch = true,
  auto_session_suppress_dirs = {'~/', '~/code', '~/code/timtyrrell', '~/code/brandfolder'},
  -- auto_session_allow_dirs = {'~/code/*', '~/.local/share/chezmoi'},
  pre_save_cmds = {close_nvim_tree, "BDelete! nameless", "BDelete! hidden", "BDelete glob=yode*", "cclose"}
}

require('rest-nvim').setup()

EOF

nnoremap <Leader>ca :split \| terminal chezmoi -v apply<CR>:startinsert<CR>

augroup randomstuff
  autocmd!
  "Check if any buffers were changed outside of Vim
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if !bufexists("[Command Line]") | checktime | endif
  " Make it so that if files are changed externally (ex: changing git branches) update the vim buffers automatically
  autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

  " if highlighting on big files is bad, can do similiar:
  " autocmd FileType typescript syntax sync ccomment minlines=1500

  " set graphql filetype based on dir
  " autocmd BufRead,BufNewFile */schema/*.js set syntax=graphql
  " autocmd BufRead,BufNewFile */graphql/queries/*.js set syntax=graphql

  " might want to sync with `.bat/config`
  autocmd BufNewFile,BufRead .eslintrc,.prettierrc,.lintstagedrc set filetype=jsonc
  autocmd BufNewFile,BufRead *.build,.env*,config.env set filetype=sh
  autocmd BufNewFile,BufRead *.template set filetype=nginx

  "chezmoi filetype fixes
  autocmd BufNewFile,BufRead *gitconfig* set filetype=gitconfig
  autocmd BufNewFile,BufRead dot_zshrc set filetype=zsh
  autocmd BufNewFile,BufRead dot_tmux.conf set filetype=tmux

  " if expand('%:p') =~ 'chezmoi'
    " autocmd BufWritePost * execute ':!chezmoi -v apply'
    " autocmd BufWritePost * !chezmoi -v apply
  " endif

  " per reddit, Vim doesn't have an autocommand for graphql files, not sure if needed?
  autocmd BufRead,BufNewFile *.graphql,*.graphqls,*.gql setfiletype graphql

  " reopen files at your last edit position
  " autocmd BufReadPost * if @% !~# "\.git[\/\\]COMMIT_EDITMSG$" && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  " autocmd BufReadPost *
  "       \ if line("'\"") > 0 && line("'\"") <= line("$") |
  "       \   exe "normal! g`\"" |
  "       \ endif
augroup END

" how to automatically rename things based on filetype
" autocmd BufWritePre *.js exec '%s/class=/className=/eg'
" styles.something-blah -> styles[something-blah]
" :%s/styles[\S\+\]/
" /styles[\[a-zA-Z0-9].\+?(?=dir)/
" autocmd BufWritePre *.js exec '%s/class=/className=/eg'

" https://www.reddit.com/r/vim/comments/kmup3z/is_it_possibAle_to_make_hitting_one_tab_goes_to/ghhbaw9/?context=3
" inoremap <expr> <tab> getline('.') =~ '^\s*$' ? '<esc>cc' : '<tab>'

" I haven't tested this
" https://www.reddit.com/r/vim/comments/y9ax3s/delete_all_no_name_buffers_function_vimscript/
" Delete all "[No Name]" buffers
function CloseNoNameBuffers()
    let s:nonamebuffers = filter(filter(range(1, bufnr('$')), 'bufexists(v:val)'), 'bufname(v:val)==""')
    for i in s:nonamebuffers
        exe 'bdelete ' . i
    endfor
endfunction


nnoremap <silent><leader>vr <cmd>call execute('source $MYVIMRC')<cr><cmd>lua require('notify')('vim config reloaded!')<cr>

let g:vim_jsx_pretty_colorful_config = 1

" https://github.com/yarnpkg/berry/pull/2598 or use zip file
" yarn 2 pnp goto definition support
function! OpenZippedFile(f)
  " get number of new (empty) buffer
  let l:b = bufnr('%')
  " construct full path
  let l:f = substitute(a:f, '.zip/', '.zip::', '')
  let l:f = substitute(l:f, '/zip:', 'zipfile:', '')

  " swap back to original buffer
  b #
  " delete new one
  exe 'bd! ' . l:b
  " open buffer with correct path
  sil exe 'e ' . l:f
  " read in zip data
  call zip#Read(l:f, 1)
endfunction

augroup yarngroup
  autocmd!
  autocmd BufReadCmd /zip:*.yarn/cache/*.zip/* call OpenZippedFile(expand('<afile>'))
augroup END

function! TabMessage(cmd)
  redir => message
  silent execute a:cmd
  redir END
  if empty(message)
    echoerr "no output"
  else
    tabnew
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
    silent put=message
  endif
endfunction

" `:TabMessage message` to output :messages to new tab to copy
" `:TabMessage ls` to output buffer list to new tab to copy
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)
