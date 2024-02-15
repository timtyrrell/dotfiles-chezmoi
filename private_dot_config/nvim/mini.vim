set nocompatible
filetype plugin indent on
syntax on
set hidden

call plug#begin('~/.config/nvim/plugged')

Plug 'shortcuts/no-neck-pain.nvim'

call plug#end()

lua << EOF

require("no-neck-pain").setup({
    width = 100,
    buffers = {
        -- right = {
        --     enabled = false,
        -- },
        colors = {
            background = "tokyonight-moon",
        }
    },
    mappings = {
        enabled = true,
        toggle = "<Leader>nn",
        toggleLeftSide = "<Leader>nql",
        toggleRightSide = "<Leader>nqr",
        widthUp = { mapping = "<Leader>n=", value = 20 },
        widthDown = { mapping = "<Leader>n-", value = 20 },
        scratchPad = "<Leader>ns",
    },
})

EOF
