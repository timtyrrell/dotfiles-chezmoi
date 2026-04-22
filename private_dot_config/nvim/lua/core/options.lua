-- If installed using Homebrew on Apple Silicon
vim.opt.rtp:append('/opt/homebrew/opt/fzf')

vim.opt.termguicolors = true

vim.opt.title = true      -- displays current file as vim title
vim.opt.visualbell = true -- kills the bell
vim.opt.errorbells = false

vim.opt.wildmode = 'longest:full,full'
vim.opt.wildoptions = 'pum'
vim.opt.pumblend = 20
vim.opt.wildcharm = vim.fn.char2nr('\t')
vim.opt.completeopt = 'menuone,preview'
vim.opt.wildignorecase = true

vim.opt.wildignore:append {
  'tags',
  'package-lock.json',
  '**/*.xml',
  '**/*.po',
  '**/.git/*',
}

-- Give low priority to files matching these patterns
vim.opt.suffixes:append { '.lock', '.scss', '.sass', '.min.js', '.less', '.json' }

-- Controls the behavior when switching between buffers (mostly for quickfix)
vim.opt.switchbuf = 'useopen,usetab'

-- Add < and > to matched pairs
vim.opt.matchpairs:append('<:>')

vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0

vim.opt.showmode = false
vim.opt.ruler = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.hidden = true
vim.opt.smartindent = true
vim.opt.showbreak = '↳'
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.showtabline = 2
vim.opt.breakindent = true
vim.opt.breakindentopt = 'shift:2'
vim.opt.linebreak = true

vim.opt.number = true

-- Force decimal-based arithmetic on increment/decrement
vim.opt.nrformats = ''

-- Backup/undo management
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.autoread = true

-- Search highlighting/behavior
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Juggling with jumps
vim.opt.jumpoptions = 'stack'

vim.opt.ignorecase = true
vim.opt.infercase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'split'

-- Allows block selections to operate across lines regardless of the underlying text
vim.opt.virtualedit = 'block'
vim.opt.selection = 'old'

vim.opt.diffopt:append { 'vertical', 'algorithm:patience', 'indent-heuristic', 'linematch:800' }

vim.opt.complete:remove('t') -- disable searching tags

vim.opt.spelllang = 'en_us'
vim.opt.complete:append('kspell')

-- Keep windows same size when opening/closing splits
vim.opt.equalalways = true

vim.opt.sessionoptions = 'curdir,tabpages,winpos'

-- Disable mouse
vim.opt.mouse = ''

vim.opt.updatetime = 100

-- Give more space for displaying messages
vim.opt.cmdheight = 2

vim.opt.shortmess:append('c')
vim.opt.shortmess:append('S')
vim.opt.shortmess:append('F')

-- Leave space for git, diagnostics and marks
vim.opt.signcolumn = 'auto:5'

-- Max items to show in popup list
vim.opt.pumheight = 20

-- Use ripgrep for grep
vim.opt.grepprg = 'rg --vimgrep --no-heading'
vim.opt.grepformat = '%f:%l:%c:%m'

vim.opt.list = true
vim.opt.listchars = { tab = '→ ', space = '⋅', trail = '•', nbsp = '␣', extends = '▶', precedes = '◀' }

-- Nvim/shada marks
vim.opt.shada = "!,'0,f0,<50,s10,h"

-- Folding
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.opt.fillchars = {
  eob = ' ',
  fold = ' ',
  foldopen = '-',
  foldsep = ' ',
  foldclose = '+',
  diff = '╱',
}

-- Filetype additions
vim.filetype.add({
  extension = {
    ['http'] = 'http',
  },
})

-- Provider configuration (speedup :StartTime)
vim.g.python3_host_prog = '~/.venvs/neovim/bin/python'
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0

-- Disable netrw's gx mapping (use open-browser.vim instead)
vim.g.netrw_nogx = 1

-- Enhanced matchit
vim.g.loaded_matchit = 1
