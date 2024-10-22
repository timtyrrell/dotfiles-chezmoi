-- for _, name in ipairs({ "config", "data", "state", "cache" }) do
--   vim.env[("XDG_%s_HOME"):format(name:upper())] = root .. "/" .. name
-- end

-- Install package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system { 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- Add plugins
require('lazy').setup({
    checker = {
      -- automatically check for plugin updates
      enabled = false,
      concurrency = nil, ---@type number? set to 1 to check for updates very slowly
      notify = true, -- get a notification when new updates are found
      frequency =  86400, -- check for updates every day
      check_pinned = false, -- check for pinned packages that can't be updated
    },
    {
        'folke/tokyonight.nvim',
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        commit = '30d7be361a7fbf187a881f17e574e9213d5108ea',
        config = function()
          -- load the colorscheme here
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
          vim.cmd([[colorscheme tokyonight]])
        end,
    },
    {
     'neoclide/coc.nvim',
        branch = 'master',
        build = 'npm ci'
    },
    'antoinemadec/coc-fzf',
    'tjdevries/coc-zsh',
    'github/copilot.vim',
    {
        'junegunn/fzf.vim',
        dependencies = {
          {
              'junegunn/fzf',
              build = ':call fzf#install()'
          }
        }
    },
    'AndrewRadev/undoquit.vim',
    {

      'tzachar/highlight-undo.nvim',
      config = function()
          require('highlight-undo').setup()
      end
    },
    'kazhala/close-buffers.nvim',
    {
            'vhyrro/luarocks.nvim',
            build = ':source ./build.lua',
            config = function()
                require("luarocks-nvim").setup {
                  rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" }
                }
            end,
        },
    {
      'rmagatti/auto-session',
        lazy = false,
        config = function()
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
      end
    },
  -- https://github.com/rest-nvim/rest.nvim
    'meain/vim-printer',
    'preservim/vimux',
    'tpope/vim-dadbod',
    'kristijanhusak/vim-dadbod-ui',
    'vim-test/vim-test',
    'tpope/vim-dispatch',
    'mfussenegger/nvim-dap',
    'theHamsta/nvim-dap-virtual-text',
    'nvim-neotest/nvim-nio',
    'rcarriga/nvim-dap-ui',
    'David-Kunz/jester',
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
        {
            'abecodes/tabout.nvim',
            config = function()
                -- loaded after nvim-treesitter and any completion that already uses your tabkey.
                require('tabout').setup {
                  act_as_tab = true, -- shift content if tab out is not possible
                  act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
                  default_tab = '<C-t>', -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
                  default_shift_tab = '<C-d>', -- reverse shift default action,
                  enable_backwards = true, -- well ...
                  completion = false, -- if the tabkey is used in a completion pum
                }
            end
            },
                'JoosepAlviste/nvim-ts-context-commentstring',
                'nvim-treesitter/nvim-treesitter-textobjects',
                'mfussenegger/nvim-treehopper',
                'RRethy/nvim-treesitter-endwise',
                'windwp/nvim-ts-autotag',
            }
        },
    {
        'lukas-reineke/indent-blankline.nvim',
        tag =  'v2.20.8'
    },
    'tmux-plugins/vim-tmux',
    {
    'sheerun/vim-polyglot',
         init = function()
           vim.cmd(
             [[
                " https://github.com/nvim-treesitter/nvim-treesitter/issues/1019#issuecomment-812976740
                let g:polyglot_disabled = [
                        \ 'bash', 'comment', 'css', 'graphql',
                        \ 'html', 'javascript', 'javascriptreact', 'jsdoc', 'json',
                        \ 'jsonc', 'jsx', 'lua', 'python', 'regex', 'rspec', 'ruby',
                        \ 'sh', 'svg', 'tmux', 'tsx', 'typescript', 'typescriptreact', 'yaml']

                " let g:polyglot_disabled = ['sensible']
                " let g:polyglot_disabled = ['ftdetect']
                let g:polyglot_disabled = ['autoindent']
                let g:markdown_fenced_languages = ['ruby', 'sh', 'javascript', 'typescript', 'json']
            ]]
          )
        end,
    },
    -- 'tpope/vim-sleuth',
    { 'echasnovski/mini.splitjoin', version = '*' },
    'mcauley-penney/tidy.nvim',
    'tyru/open-browser.vim',
    'tpope/vim-abolish',
    'mileszs/ack.vim',
    'andymass/vim-matchup',
    'ggandor/leap.nvim',
    {
        'ggandor/flit.nvim',
        config = function()
          require('flit').setup {
            multiline = false,
          }
        end,
    },
    'drmingdrmer/vim-toggle-quickfix',
    'gabrielpoca/replacer.nvim',
    'kevinhwang91/nvim-bqf',
    -- 'luukvbaal/statuscol.nvim',
    'kevinhwang91/promise-async',
    -- 'kevinhwang91/nvim-ufo',
    {
        'kevinhwang91/nvim-fundo',
        config = function()
            require('fundo').setup()
        end,
    },
    'christoomey/vim-tmux-navigator',
    'christoomey/vim-system-copy',
    'tpope/vim-commentary',
    'tpope/vim-eunuch',
    'tpope/vim-projectionist',
    'tpope/vim-apathy',
    'tpope/vim-rails',
    'tpope/vim-rake',
    'tpope/vim-bundler',
    'tpope/vim-repeat',
    'tpope/vim-surround',
    'tpope/vim-unimpaired',
    {
        'kana/vim-textobj-user',
            dependencies = {
                'kana/vim-textobj-line',
                'michaeljsmith/vim-indent-object',
                'rhysd/vim-textobj-anyblock',
            },
    },
    -- 'mlaursen/vim-react-snippets'
    'nacro90/numb.nvim',
    {
     'barrett-ruth/import-cost.nvim',
        build = 'sh install.sh yarn'
    },
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    'junegunn/gv.vim',
    'shumphrey/fugitive-gitlab.vim',
    -- https://github.com/aaronhallaert/advanced-git-search.nvim
    'whiteinge/diffconflicts',
    'sindrets/diffview.nvim',
    'rhysd/committia.vim',
    'hotwatermorning/auto-git-diff',
    {
    'kevinhwang91/nvim-hlslens',
        config = function()
            require('hlslens').setup({
              nearest_only = true
            })
        end,
    },
    'nvim-lua/popup.nvim',
    'nvim-lua/plenary.nvim',
    'rcarriga/nvim-notify',
    {
        'romgrk/fzy-lua-native',
        build =  'make'
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-telescope/telescope-ui-select.nvim',
            'nvim-telescope/telescope-dap.nvim',
            'nvim-telescope/telescope-node-modules.nvim',
            'LinArcX/telescope-env.nvim',
            'debugloop/telescope-undo.nvim',
            'piersolenski/telescope-import.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make'
            }
        }
    },
     -- 'pwntester/octo.nvim',
     -- 'fannheyward/telescope-coc.nvim',
    'windwp/nvim-spectre',
    'norcalli/nvim-terminal.lua',
    {
        'nvim-tree/nvim-web-devicons',
        lazy = true
    },
    'echasnovski/mini.files',
    'kyazdani42/nvim-tree.lua',
    'ThePrimeagen/git-worktree.nvim',
    'MunifTanjim/nui.nvim',
    'vuki656/package-info.nvim',
    'tpope/vim-scriptease',
    'karb94/neoscroll.nvim',
    -- 'danilamihailov/beacon.nvim',
    'chentoast/marks.nvim',
    {
        'NvChad/nvim-colorizer.lua',
        config = function()
            require 'colorizer'.setup()
        end
    },
    -- 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
    -- {
    --     'liuchengxu/vim-clap',
    --       build = ':Clap install-binary'
    --     }
    'nvim-lualine/lualine.nvim',
    -- 'nvim-zh/colorful-winsep.nvim',
    -- 'shortcuts/no-neck-pain.nvim'
    'voldikss/vim-browser-search',
    -- 'airblade/vim-rooter'
    -- 'dstein64/vim-startuptime'
    {
        'vimwiki/vimwiki',
        branch = 'dev',
        -- ft = 'markdown',
        -- cmd = 'VimwikiMakeDiaryNote',
        dependencies = { 'mattn/calendar-vim' },
        init = function()
            vim.cmd(
              [[
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

                let g:vimwiki_create_link = 0

                " trying to make markdown snippets work
                " let g:vimwiki_table_mappings=0
                " autocmd filetype vimwiki ultisnipsaddfiletypes vimwiki
                let g:vimwiki_global_ext = 0 " don't hijack all .md files
                let g:vimwiki_listsyms = ' ○◐●✓'

                let g:vimwiki_list = [{
                  \ 'path': '~/Library/Mobile Documents/com~apple~CloudDocs/Documents/notes/',
                  \ 'syntax': 'markdown',
                  \ 'ext': '.md',
                  \ 'auto_toc': 1,
                  \ }]
              ]]
           )
        end,
        config = function()
          vim.cmd(
            [[
                " fix `gx` command https://github.com/plasticboy/vim-markdown/issues/372#issuecomment-394237720
                nnoremap <plug> <plug>markdown_openurlundercursor

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

            ]]
          )
        end,
    },
    {
        'alok/notational-fzf-vim',
        -- ft = 'markdown',
        init = function()
            vim.cmd(
              [[
                let g:nv_search_paths = ['~/Library/Mobile Documents/com~apple~CloudDocs/Documents/notes']
                let g:nv_create_note_key = 'ctrl-x'

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
              ]]
           )
        end,
        config = function()
          vim.cmd(
            [[
              " default 'alok/notational-fzf-vim' search
              nmap <Leader>wv :NV!<CR>
            ]]
          )
        end,
    },
    {
        'iamcco/markdown-preview.nvim',
        build = 'cd app && npx --yes yarn install'
    },
    {
        'ellisonleao/glow.nvim',
        ft =  'markdown'
    },
    {
        "folke/zen-mode.nvim",
          -- keys = {
          --     { "<leader>zm", "cmd>ZenMode<cr>" },
          -- },
          config = function()
            require("zen-mode").setup {
              window = {
                backdrop = 0.95,
                width = .5,
                height = 1,
                options = {
                  signcolumn = "yes",
                  number = true,
                  relativenumber = false,
                  cursorline = true,
                  cursorcolumn = false,
                  foldcolumn = "0",
                  list = false,
                },
              },
            }
          end,
    },
    'folke/which-key.nvim'
}, {
    checker = { enabled = true },
})

-- add anything else here
-- vim.opt.termguicolors = true
-- -- do not remove the colorscheme!
vim.cmd [[
" If installed using Homebrew on Apple Silicon
" set rtp+=/opt/homebrew/opt/fzf

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
set wildignore+=**/*.po
" off for telescope-node_modules usage
" set wildignore+=**/node_modules/*
set wildignore+=**/.git/*

" give low priority to files matching the defined patterns.
set suffixes+=.lock,.scss,.sass,.min.js,.less,.json
" helpful?
" set suffixesadd=.ts,.tsx,.js,.jsx,.rb,.erb

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
" set inccommand=nosplit "highlight :s in realtime
set inccommand=split "highlight :s in realtime and show offscreen

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
" set sessionoptions-=buffers
" set sessionoptions-=help
" set sessionoptions-=folds
" set sessionoptions-=blank
" set sessionoptions+=localoptions
" results with those ^: sessionoptions=curdir,tabpages,winsize,terminal
" set sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
set sessionoptions=curdir,tabpages,winpos,localoptions

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

" backspace to ciw
nnoremap <bs> ciw

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
" let g:python3_host_prog = '/opt/homebrew/bin/python3'
let g:loaded_python3_provider = 0
" let g:python3_host_prog = '/opt/homebrew/opt/python@3.10/libexec/bin/python'
" let g:python3_host_prog = '~/.pyenv/shims/python3'
" let g:loaded_python_provider = 1
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
" let g:loaded_ruby_provider = 1 " use language server instead
" let g:loaded_node_provider = 1

" nvim/shada is dumb with marks, don't save for new session
" https://www.reddit.com/r/neovim/comments/q7bgwo/comment/hghwogp/?context=3
set shada=!,'0,f0,<50,s10,h

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

function! UpdateRemotePlugins(...)
  " Needed to refresh runtime files
  let &rtp=&rtp
  UpdateRemotePlugins
endfunction

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

" pbogut/vim-dadbod-ssh
let g:db_ui_show_database_icon = 1
let g:db_ui_use_nerd_fonts = 1
let g:db_ui_force_echo_notifications = 1

omap     <silent> m <Cmd>lua require('tsht').nodes()<CR>
xnoremap <silent> m :lua require('tsht').nodes()<CR>

augroup tmuxgroups
  autocmd!
  autocmd FileType tmux nnoremap <silent><buffer> K :call tmux#man()<CR>
  " automatically source tmux config when saved
  autocmd BufWritePost .tmux.conf execute ':!tmux source-file %'
augroup END

let g:netrw_nogx = 1 " disable netrw's gx mapping.
let g:openbrowser_default_search = 'duckduckgo'
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" enhanced matchit
let g:loaded_matchit = 1

" keeping all navigation within Vim until the tmux pane is explicitly unzoomed
let g:tmux_navigator_disable_when_zoomed = 1

let g:fugitive_gitlab_domains = ['https://git.lab.smartsheet.com']

nnoremap <silent> <leader>ee :NvimTreeFindFile<CR>
nnoremap <silent> <leader>et :NvimTreeToggle<CR>
nnoremap <silent> <leader>er :NvimTreeRefresh<CR>

function! UpdateRemotePlugins(...)
  " Needed to refresh runtime files
  let &rtp=&rtp
  UpdateRemotePlugins
endfunction

nmap <silent> <Leader>bs <Plug>SearchNormal
vmap <silent> <Leader>bs <Plug>SearchVisual
let g:browser_search_default_engine = 'duckduckgo'

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

" Plug 'iamcco/markdown-preview.nvim'
let g:mkdp_filetypes = ['markdown', 'mermaid']
nmap <leader>mp <Plug>MarkdownPreview
nmap <leader>ms <Plug>MarkdownPreviewStop

" Plug 'ellisonleao/glow.nvim', {'for': 'markdown'}
nmap <leader>mg :Glow<CR>

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

let g:coc_enable_locationlist = 0
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

" coc-fzf remappings
let g:coc_fzf_opts= ['--layout=reverse']
let g:coc_fzf_preview='right:50%'
let g:coc_fzf_preview_fullscreen=0
let g:coc_fzf_preview_toggle_key='\'

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

  " close preview when completion is done
  autocmd CompleteDone * if pumvisible() == 0 | pclose | endif

  autocmd FileType TelescopePrompt let b:coc_pairs_disabled = ["'"]

  hi default link CocHighlightText TabLineSel
  hi default link CocCodeLens LspCodeLens

  " Coc autocomplete menu
  hi default link CocPumSearch Statement
augroup end

" END COC CONFIG

" Indent/dedent what you just pasted
nnoremap <leader>< V`]<
nnoremap <leader>> V`]>

" Reverse the <C-r>/<C-r><C-o> meanings - make <C-r>" default to a repeatable behavior for text changes and keep indention
inoremap <C-r> <C-r><C-o>
inoremap <C-r><C-o> <C-r>

" `gp` reselect pasted text. `gv` reselects the last visual selection
nnoremap gp `[v`]

" Plug 'kana/vim-textobj-line', { 'on': ['<Plug>(textobj-line-i', '<Plug>(textobj-line-a']}
xmap al <Plug>(textobj-line-a)
omap al <Plug>(textobj-line-a)
xmap il <Plug>(textobj-line-i)
omap il <Plug>(textobj-line-i)

" add motions for words_like_this, etc
" i_ i. i: i, i; i| i/ i\ i* i+ i- i#
" a_ a. a: a, a; a| a/ a\ a* a+ a- a#
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '-', '#' ]
  execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
  execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
  execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
  execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

" Don't include leading whitespace
onoremap a' 2i'
onoremap a" 2i"
xnoremap a' 2i'
xnoremap a" 2i"

" yank file name
nnoremap <leader>yf :let @"=expand("%:t")<CR>
" yank file name and path
nnoremap <leader>yp :let @"=expand("%:p")<CR>
" yank file name and line number
nnoremap <leader>yn :let @"=expand("%:p").":".getpos('.')[1]<CR>

let g:fzf_vim = {}
let g:fzf_vim.grep_multi_line = 2

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" open fzf in a floating window
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.7 } }

nnoremap <silent> <Leader>ff <cmd>Files<CR>

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

nnoremap <silent> <Leader>fl <cmd>RgLines<CR>

" Lines in loaded buffers
nnoremap <silent> <leader>fz <cmd>lua require('telescope.builtin')
      \.live_grep({
      \   prompt_title = 'find string in open buffers...',
      \   grep_open_files = true
      \ })<cr>

" start file search in current dir
nnoremap <silent> <leader>fd <cmd>lua require('telescope.builtin')
      \ .find_files({
      \   cwd = require'telescope.utils'.buffer_dir()
      \ })<cr>

nnoremap <silent> <Leader>fL :Lines<CR>
nnoremap <silent> <leader>fh <cmd>lua require('telescope.builtin').command_history()<cr>
nnoremap <silent> <leader>fH <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <silent> <leader>fS <cmd>lua require('telescope.builtin').search_history()<cr>
nnoremap <silent> <Leader>fg <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <silent> <Leader>fc :BCommits<CR>
nnoremap <silent> <Leader>fC :Commits<CR>
nnoremap <silent> <leader>fm <cmd>lua require('telescope.builtin').marks()<cr>
nnoremap <silent> <leader>fM <cmd>lua require('telescope.builtin').keymaps()<cr>
nnoremap <silent> <leader>fs <cmd>lua require('telescope.builtin').spell_suggest()<cr>
nnoremap <silent> <leader>fr <cmd>lua require('telescope.builtin').resume()<cr>

" start file search in current dir
nnoremap <silent> <leader>fd <cmd>lua require('telescope.builtin')
      \ .find_files({
      \   cwd = require'telescope.utils'.buffer_dir()
      \ })<cr>

" Rg current word under cursor
nnoremap <silent> <Leader>rw :RgLines <C-R><C-W><CR>

" Rg with dir autocomplete
nnoremap <leader>rd :RGdir<Space>

let s:rg_initial_command = 'true'

let s:rg_colors = ' --colors line:fg:red --colors path:fg:blue --colors match:fg:green '

" REMOVED, BAD LUA
" let s:rg_full_command

command! -bang -nargs=* Rg
\   call fzf#vim#grep(
\       'rg' . s:rg_colors . ' --line-number --color=always --smart-case -- '.shellescape(<q-args>), 1,
\       fzf#vim#with_preview({'options': '--exact --delimiter : --nth 3..'}), <bang>0
\   )


" On-demand search using Rg if query is non-empty. Fzf is a middleman only.
function! RgReloader(query, fullscreen, rg_base_command)
    " Shift focus to the right/main window, especially when focus is in sidebar.
    :wincmd l

    let rg_reload_command = printf(s:rg_full_command, a:rg_base_command)

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


command! -bang -nargs=* RgLines
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --case-sensitive  -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({ 'options': ['--delimiter', ':', '--nth', '4..'] }), <bang>0)

" override default preview settings in zshrc to hide previews
" examples in the source: https://github.com/junegunn/fzf.vim/blob/master/plugin/fzf.vim#L48
command! -bang -nargs=* HistoryCmds call fzf#vim#command_history(fzf#vim#with_preview({'options': ['--preview-window', 'hidden']}))
command! -bang -nargs=* HistorySearch call fzf#vim#search_history(fzf#vim#with_preview({'options': ['--preview-window', 'hidden']}))

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

let g:fzf_history_dir = '~/.local/share/fzf-history'

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

nnoremap <leader>S <cmd>lua require('spectre').open()<CR>
"search current word
nnoremap <leader>sw <cmd>lua require('spectre').open_visual({select_word=true})<CR>
vnoremap <leader>s <esc>:lua require('spectre').open_visual()<CR>
"  search in current file
nnoremap <leader>sp viw:lua require('spectre').open_file_search()<cr>

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

" Plug 'andymass/vim-matchup'
let g:matchup_matchparen_offscreen = {'method': 'popup'}
let g:matchup_text_obj_enabled = 0

" Plug 'drmingdrmer/vim-toggle-quickfix'
nmap <Leader>qq <Plug>window:quickfix:loop

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

" toggle folds
nnoremap <space><space> za
vnoremap <space><space> za


" logs for entire repo
" nnoremap <leader>gv :GV<cr>
" logs for entire repo, cleaned up
nnoremap <leader>gV :GV --first-parent -100<cr>
" nnoremap <leader>gV :GV --no-merges --first-parent -100<cr>
" logs for current file
nnoremap <leader>gv :GV! -100<cr>
" gq or q exit
" O opens a new tab instead
" gb for :GBrowse
" \]\] and \[\[ to move between commits
" <C-n>/<C-p> jump and open commit

" https://github.com/tpope/vim-fugitive/issues/1446
" fix older husky versions
" let g:fugitive_pty = 0

nnoremap <leader>gb :Git blame<cr>
nnoremap <leader>gB :%Git blame<cr>
" gq    close blame, then |:Gedit| to return to work tree version
" <CR>  close blame, and jump to patch that added line (or directly to blob for boundary commit)
" o     jump to patch or blob in horizontal split
" O     jump to patch or blob in new tab
" -     reblame at commit

nnoremap <leader>gd :Gdiff<cr>

" tab Gdiffsplit main:% or tab Gdiffsplit main:path

" list names of changes files in quickfix
nnoremap <silent><leader>gt <cmd>Git difftool --name-only<CR>
" list all locations of changed files in quickfix
nnoremap <silent><leader>gT <cmd>Git difftool<CR>

" git log/diffs of current file
nnoremap <leader>gl :Gclog -- % -100<cr>
" git log/diffs of repo
nnoremap <leader>gL :Gclog -100<cr>
vnoremap <leader>gL :Gclog -100<cr>
" coo to checkout and switch to that commit

" :Gedit is 'git checkout %' => reverts work tree file to index, be careful!
nnoremap <Leader>ge :Gedit<Space>
nnoremap <silent><Leader>ge :Gedit <bar> only<CR>
" :Gedit main:file.js to open file version in another branch
" :Gedit " go back to normal file from read-only view in Gstatus window

nnoremap <leader>gr :Gread<cr>:noautocmd update<cr>
" :Gread main:file.js to replace file from one in another branch
" add? git checkout origin/master -- %

" git grep 'foo bar' [branch/SHA]
" git log --grep='foobar' to search commit messages
" git log -Sfoobar (when 'foobar' was added/removed)
nnoremap <leader>gg :Glgrep! -q<space>
nnoremap <Leader>g/ :Glrep! -Hnri --quiet<Space>
nnoremap <Leader>g? :Git! log --grep=
nnoremap <Leader>gS :Git! log -S<Space>
nnoremap <Leader>g* :Glgrep! -Hnri --quiet <C-r>=expand("<cword>")<CR><CR>

nnoremap <silent><leader>gc <cmd>Git commit<CR>
nnoremap <silent><Leader>gP <cmd>Git -p push<CR>
nnoremap <silent><Leader>gp <cmd>Git -p pull<CR>
nnoremap <silent><Leader>gf <cmd>Git -p fetch<CR>

" Open visual selection in browser
vnoremap <Leader>Gb :GBrowse<CR>
" Open current line in the browser
nnoremap <Leader>Gb :.GBrowse<CR>

" Copy visual selection url to clipboard
vnoremap <Leader>GB :GBrowse!<CR>
" Copy current line url to clipboard
nnoremap <Leader>GB :.GBrowse!<CR>

" open project
nnoremap <Leader>go <cmd>GBrowse HEAD<cr>

" Add <cfile> to index and save
nnoremap <silent><Leader>gw <cmd>Gwrite<CR>
" gW useful in 3 way merge diffs: choose a buffer and use gW to use all that versions' changes, i.e., --ours/theirs
nnoremap <silent><Leader>gW <cmd>Gwrite!<CR>

augroup fugitive_ext
  autocmd!
  " Browse to the commit under my cursor
  autocmd FileType fugitiveblame nnoremap <buffer> <leader>Gb :execute ":GBrowse " . expand("<cword>")<cr>
augroup END

" open Git Status in new tab
nnoremap <silent> <leader>gs :tab Git<cr>:G<cr>/^M\s<cr>:let @/=""<cr>

" put changed file names from previous commit into the quickfix list
command -nargs=? -bar Gshow call setqflist(map(systemlist("git show --pretty='' --name-only <args>"), '{"filename": v:val, "lnum": 1}'))

" *** if HEAD fails, run `git remote set-head -a origin` in the repo ***
" diff current branch(PR) against base branch
" (OURS, left), area to resolve (middle), the version from the branch which is being merged (THEIRS, right)
nnoremap <leader>dvm <Cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<cr>
" From the file panel you can press `L` to open the commit log for all the changes. This lets you check the full commit messages for all the commits involved

" Comparing Changes From the Individual PR Commits against base branch
nnoremap <leader>dvp <Cmd>DiffviewFileHistory --range=origin/HEAD...HEAD --right-only --no-merges<cr>

" diff current changes (also, merge/rebase flow)
nnoremap <leader>dvo <cmd>DiffviewOpen<cr>
" The default mapping `g<C-x>` allows you to cycle through the available layouts.

" diff on current file
nnoremap <leader>dvf <Cmd>DiffviewFileHistory %<cr>
" diff on all project commits
nnoremap <leader>dvF <Cmd>DiffviewFileHistory<cr>
" diff on latest commit?
nnoremap <leader>dvl <Cmd>DiffviewOpen HEAD~1<cr>
" ?
nnoremap <leader>dvh <Cmd>DiffviewFileHistory --range=origin/HEAD..HEAD<cr>
" diff history on visual selection
vnoremap <leader>dvh <Cmd>'<,'>DiffviewFileHistory<CR>

" Plug 'rhysd/committia.vim'
let g:committia_open_only_vim_starting = 1
let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
    " Additional settings
    setlocal spell
    " If no commit message, start with insert mode
    if a:info.vcs ==# 'git' && getline(1) ==# ''
        startinsert
    endif
    " Scroll the diff window from insert mode
    " Map <C-n> and <C-p>
    imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
endfunction

" Plug 'whiteinge/diffconflicts'
" Convert a file containing Git conflict markers into a two-way diff.
nmap <silent> <leader>dcc :DiffConflicts<cr>
" Open a new tab containing the merge base and the local and remote version
nmap <silent> <leader>dch :DiffConflictsShowHistory<cr>
" Call both DiffConflicts and DiffConflictsShowHistory
nmap <silent> <leader>dcb :DiffConflictsWithHistory<cr>
" Refresh the diff
nmap <silent> <leader>dcu :diffupdate<cr>
" skip the file
nmap <silent> <leader>dcs :cq<cr>

" Plug 'mattn/calendar-vim'
let g:calendar_no_mappings=0
nmap <Leader>wdc <Plug>CalendarV
nmap <Leader>wdC <Plug>CalendarH

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
augroup end

" Plug 'alok/notational-fzf-vim'
" let g:nv_search_paths = ['~/Documents/notes']
" let g:nv_search_paths = ['~/Library/Mobile Documents/com~apple~CloudDocs/Documents/notes']
" let g:nv_create_note_key = 'ctrl-x'

" " vimwiki & friends
" let g:vim_markdown_new_list_item_indent = 0
" let g:vim_markdown_auto_insert_bullets = 1
" let g:vim_markdown_conceal = 0
" let g:vim_markdown_conceal_code_blocks = 0
" let g:vimwiki_conceal_pre = 1
" let g:vimwiki_hl_headers = 1 " highlight headers with different colors
" let g:vimwiki_hl_cb_checked = 2 " highlight completed tasks and line
" let g:vim_markdown_fenced_languages = ['viml=vim', 'bash=sh', 'javascript=js']
" " let g:vimwiki_url_maxsave = 0 " display full url path

" " fix `gx` command https://github.com/plasticboy/vim-markdown/issues/372#issuecomment-394237720
" nnoremap <plug> <plug>markdown_openurlundercursor

" " trying to make markdown snippets work
" " let g:vimwiki_table_mappings=0
" " autocmd filetype vimwiki ultisnipsaddfiletypes vimwiki
" let g:vimwiki_global_ext = 1 " don't hijack all .md files
" let g:vimwiki_listsyms = ' ○◐●✓'

" NV-fzf floating window
" function! FloatingFZF()
"   let width = float2nr(&columns * 0.9)
"   let height = float2nr(&lines * 0.6)
"   let opts = { 'relative': 'editor',
"              \ 'row': (&lines - height) / 2,
"              \ 'col': (&columns - width) / 2,
"              \ 'width': width,
"              \ 'height': height,
"              \}

"   let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
"   call nvim_win_set_option(win, 'winhl', 'Normal:MyHighlight')
" endfunction
" let g:nv_window_command = 'call FloatingFZF()'

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

" if you want to turn off support for other extension(for example, disabling accidently creating new wiki and link for normal markdown files)
" set the following option in your `.vimrc` before packadd vimwiki:
" let g:vimwiki_ext2syntax = {}

" let g:vimwiki_list = [{
"   \ 'path': '~/Library/Mobile Documents/com~apple~CloudDocs/Documents/notes/',
"   \ 'syntax': 'markdown',
"   \ 'ext': 'md',
"   \ 'auto_toc': 1,
"   \ }]
" gln to toggle forward
" glp to toggle back
let g:coc_filetype_map = { 'vimwiki': 'markdown' } " register with coc-markdownlint

" tabs_buffers.vim
nnoremap <silent> <c-n> :bnext<CR>
nnoremap <silent> <c-p> :bprev<CR>

nnoremap <leader>tc  :tabclose<cr>
nnoremap <leader>tn  :tabnew<cr>
" open buffer in new tab preserving cursor, preserving old buffer
nnoremap <leader>ts  :tab sp<cr>
nnoremap <leader>to  :tabonly<cr>
nnoremap <leader>tmh :-tabmove<CR>
nnoremap <leader>tml :+tabmove<CR>
nnoremap <leader>tmm :tabedit %<CR>
nnoremap <leader>1   1gt
nnoremap <leader>2   2gt
nnoremap <leader>3   3gt
nnoremap <leader>4   4gt
nnoremap <leader>5   5gt
nnoremap <leader>6   6gt
nnoremap <leader>7   7gt
nnoremap <leader>8   8gt
nnoremap <leader>9   9gt
nnoremap <leader>0   :tablast<CR>

" Plug 'kazhala/close-buffers.nvim'
map <leader>bdo :BDelete other<CR>
map <leader>bdh :BDelete hidden<CR>
map <leader>bda :BDelete all<CR>
map <leader>bdt :BDelete this<CR>
map <leader>bdn :BDelete nameless<CR>


  " vim-test
  let test#ruby#rspec#executable = 'bundle exec rspec'
  let test#strategy = 'vimux'
  " let test#strategy = 'toggleterm'
  " let test#strategy = 'neovim'
  " let test#strategy = 'spawn'

  " let test#strategy = 'neovim_sticky'
  " let g:test#neovim_sticky#kill_previous = 1  " Try to abort previous run
  " let g:test#preserve_screen = 0  " Clear screen from previous run

  nmap <silent> <leader>tt :TestNearest<CR>
  nmap <silent> <leader>tf :TestFile<CR>
  nmap <silent> <leader>tl :TestLast<CR>
  nmap <silent> <leader>tv :TestVisit<CR>
  nmap <silent> <leader>ts :TestSuite<CR>

  let test#typescriptreact#jest#options = {
    \ 'nearest': '--backtrace',
    \ 'file':    '--format documentation',
    \ 'suite':   '--tag ~slow',
  \}

  nnoremap <leader>zm :ZenMode<CR>
]]

vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99 -- open files without any folding
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:,diff:╱]]

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

require('glow').setup({
  glow_path = "/opt/homebrew/bin/glow",
  border = "rounded",
  width = 220,
  height = 400,
  width_ratio = 0.8,
  height_ratio = 0.8,
})

-- require("colorful-winsep").setup({
--   highlight = {
--     -- bg = "#16161E",
--     -- fg = "#1F3442",
--   },
--   no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest" },
--   events = { "VimResume", "WinEnter", "BufEnter", "WinResized", "WinClosed", "VimResized", "SessionLoadPost", "WinLeave" },
--   -- events = { "WinEnter", "WinResized", "SessionLoadPost" },
--   -- event = { "WinNew" },
--   -- event = { "WinLeave" },
--   symbols = { "─", "│", "┌", "┐", "└", "┘" },
-- })

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

require('neoscroll').setup {}

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

local function close_nvim_tree()
  require('nvim-tree.view').close()
end

  -- use black hole register when deleting empty line
  local function smart_dd()
    if vim.api.nvim_get_current_line():match("^%s*$") then
      return "\"_dd"
    else
      return "dd"
    end
  end
  vim.keymap.set( "n", "dd", smart_dd, { noremap = true, expr = true } )

  -- deleting empty lines in visual mode
  local function smart_d()
    local l, c = unpack(vim.api.nvim_win_get_cursor(0))
    for _, line in ipairs(vim.api.nvim_buf_get_lines(0, l - 1, l, true)) do
      if line:match("^%s*$") then
        return "\"_d"
      end
    end
    return "d"
  end
  vim.keymap.set("v", "d", smart_d, { noremap = true, expr = true } )

require('spectre').setup()

local actions = require "telescope.actions"
local action_layout = require "telescope.actions.layout"

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

vim.keymap.set('n','<Leader>sr' , ':%s/<C-r><C-w>//gc<Left><Left><Left>',{silent = false,desc="search and replace cword"})
vim.keymap.set('v','<Leader>sr' , 'y:%s/<C-R>"//gc<Left><Left><Left>',{silent = false,desc="search and replace selection"})

require('nvim-treesitter.configs').setup {
  auto_install = true,
  ensure_installed = { "bash", "css", "embedded_template", "graphql", "html", "http", "javascript", "jsdoc", "json", "jsonc", "lua", "regex", "ruby", "tsx", "typescript", "vimdoc" },
  ignore_install = { "phpdoc", "comment" },
  -- disable slow treesitter highlight for large files
  -- disable = function(lang, buf)
  --   local max_filesize = 100 * 1024 -- 100 KB
  --   local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
  --   if ok and stats and stats.size > max_filesize then
  --     return true
  --   end
  -- end,
  endwise = {
    enable = true,
  },
  highlight = {
    enable = true,
    disable = { },
  },
  indent = {
    enable = true
  },
  -- rainbow = {
  --   enable = true,
  --   -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
  --   extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
  --   max_file_lines = nil, -- Do not enable for files with more than n lines, int
  --   -- colors = {}, -- table of hex strings
  --   -- termcolors = {} -- table of colour name strings
  -- },
  -- https://github.com/andymass/vim-matchup
  matchup = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        -- ["ab"] = "@block.outer",
        -- ["ib"] = "@block.inner",
        ["aS"] = "@statement.outer",
        ["iS"] = "@statement.inner",
        ["aC"] = "@conditional.outer",
        ["iC"] = "@conditional.inner",
        ["aL"] = "@loop.outer",
        ["iL"] = "@loop.inner",
        ["am"] = "@call.outer",
        ["im"] = "@call.inner",
        ["iP"] = "@parameter.inner",
        ["aP"] = "@parameter.outer",
      },
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
  query_linter = {
    enable = false,
    use_virtual_text = true,
    lint_events = {"BufWrite", "CursorHold"},
  },
  autotag = {
    enable = true,
  },
}

require('nvim-treesitter.configs').setup {}
