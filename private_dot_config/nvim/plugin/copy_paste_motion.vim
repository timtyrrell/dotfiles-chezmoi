"""" motions
" 0			  To the first character of the line.  |exclusive|
" ^			  To the first non-blank character of the line.
" $       To the end of the line.  When a count is given also go
" w			  [count] words forward.  |exclusive| motion.
" W			  [count] WORDS forward.  |exclusive| motion.
" e			  Forward to the end of word [count] |inclusive|.
" E			  Forward to the end of WORD [count] |inclusive|.
" b			  [count] words backward.  |exclusive| motion.
" B			  [count] WORDS backward.  |exclusive| motion.
" ge			Backward to the end of word [count] |inclusive|.
" gE			Backward to the end of WORD [count] |inclusive|.
" %			  Find the next item in this line after or under the cursor and jump to its match.
" ]m      go to next start of a method
" ]M      go to next end of a method
" [m      go to previous start of a method
" [M      go to previous end of a method
" [{      jump to beginning of code block (while, switch, if, etc)
" [(      jump to the beginning of a parenthesis
" ]}      jump to end of code block (while, switch, if, etc)
" ])      jump to the end of a parenthesis
" ]]			[count] |section|s forward or to the next '{' in the first column.
" ][			[count] |section|s forward or to the next '}' in the first column.
" [[			[count] |section|s backward or to the previous '{' in the first column
" []			[count] |section|s backward or to the previous '}' in the first column
" CTRL-O  go to [count] Older cursor position in jump list
" CTRL-I  go to [count] newer cursor position in jump list
" '.      go to position where last change was made (in current buffer)
" (			[count] sentences backward
" )			[count] sentences forward
" {			[count] paragraphs backward
" }			[count] paragraphs forward
" '<			To the first line or character of the last selected Visual area
" '>			To the last line or character of the last selected Visual area
" g;			Go to [count] older position in change list.
" g,			Go to [count] newer cursor position in change list.
" c       delete character and enter insert mode
" d       delete character and enter insert mode
" p       paste behind cursor
" P       paste in-front/on top cursor

"""" actions
" C 	    delete from the cursor to the end of the line and enter insert mode
" cc    	delete the whole line and enter insert mode (===S）
" x 	    delete the character under the cursor
" X 	    delete the character in front of the cursor
" D       clears all characters in the current line (the line is not deleted)
" dw      delete word
" de      delete until end of word
" dd      delete one line
" dl	    delete character (alias: "x")
" diw     delete inner word
" daw     delete a word
" diW     delete inner WORD
" daW     delete a WORD
" dis     delete inner sentence
" das     delete a sentence
" dib     delete inner '(' ')' block
" dab     delete a '(' ')' block
" dip     delete inner paragraph
" dap     delete a paragraph
" diB     delete inner '{' '}' block
" daB     delete a '{' '}' block
" d5j     delete 5 lines in 'j' direction
" xp      transpose 2 characters
" rc      replace the character under the cursor with c

"""" read-only registers
" "% 	    current file name
" "# 	    rotation file name
" ". 	    last inserted text
" ": 	    last executed command
" "/ 	    last found pattern
" "Ay       any upper case letter APPENDS to register

"""" special register
" "0      'y' copied text is stored in the nameless register `""`, also `"0`. `c`、`d`、`s`、`x` does not override this register.

"""" INSERT MODE KEYS
" <C-h>   delete the character before the cursor during insert mode
" <C-w>   delete word before the cursor during insert mode
" <C-j>   begin new line during insert mode
" <C-t>   indent (move right) line one shiftwidth during insert mode
" <C-d>   de-indent (move left) line one shiftwidth during insert mode
" <C-R>a  pastes the contents of the `a` register
" <C-R>"  pastes the contents of the unnamed register (last delete/yank/etc)
"
" zz center line on screen
" zt move current line to top
" zb move current line to bottom
"
" Completion
" <C-x><C-l> - whole lines
" <C-x><C-n> - keywords in the current file
" <C-x><C-i> - keywords in the current and included files
" <C-x><C-f> - file names
" <C-x><C-d> - function names

" send change arguments to blackhole registry
" nnoremap c "_c
" nnoremap C "_C

" copy paragraph
" nnoremap cp vap:t'><CR>

" insert mode paste from the clipboard just like on mac
inoremap <C-v> <C-r>*

" Indent/dedent what you just pasted
nnoremap <leader>< V`]<
nnoremap <leader>> V`]>

" Reverse the <C-r>/<C-r><C-o> meanings - make <C-r>" default to a repeatable behavior for text changes and keep indention
inoremap <C-r> <C-r><C-o>
inoremap <C-r><C-o> <C-r>

" `gp` reselect pasted text. `gv` reselects the last visual selection
nnoremap gp `[v`]

lua << EOF
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
EOF

" Plug 'kana/vim-textobj-user'
" https://github.com/kana/vim-textobj-user/wiki

" Plug 'rhysd/vim-textobj-anyblock'
" ib is a union of i(, i{, i[, i', i" and i<.
" ab is a union of a(, a{, a[, a', a" and a<.

" Plug 'kana/vim-textobj-line', { 'on': ['<Plug>(textobj-line-i', '<Plug>(textobj-line-a']}
xmap al <Plug>(textobj-line-a)
omap al <Plug>(textobj-line-a)
xmap il <Plug>(textobj-line-i)
omap il <Plug>(textobj-line-i)
" 'il' ignores leading and trailing spaces. 'al' ignoes EOL

" Plug 'michaeljsmith/vim-indent-object'
" <count>ai  (A)n (I)ndentation level and line above.
" <count>ii  (I)nner (I)ndentation level (no line above).
" <count>aI  (A)n (I)ndentation level and lines above/below.
" <count>iI  (I)nner (I)ndentation level (no lines above/below)

" add motions for words_like_this, etc
" i_ i. i: i, i; i| i/ i\ i* i+ i- i#
" a_ a. a: a, a; a| a/ a\ a* a+ a- a#
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '-', '#' ]
  execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
  execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
  execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
  execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

" change word movement?
" let someobject = response.user.posts[2].description.length
" ^   ^            ^        ^    ^     ^  ^           ^
" nnoremap w /\W\zs\w<CR>
" nnoremap W ?\W\zs\w<CR>

" change/delete surrounding function call
" Plug 'AndrewRadev/dsf.vim'
let g:dsf_no_mappings = 1
nmap dsf <Plug>DsfDelete
nmap csf <Plug>DsfChange
nmap dsnf <Plug>DsfNextDelete
nmap csnf <Plug>DsfNextChange
" omap af <Plug>DsfTextObjectA
" xmap af <Plug>DsfTextObjectA
" omap if <Plug>DsfTextObjectI
" xmap if <Plug>DsfTextObjectI

" Plug 'christoomey/vim-system-copy'
" cp for copying and cv for pasting
" cpiw => copy word into system clipboard
" cpi' => copy inside single quotes to system clipboard
" cvi' => paste inside single quotes from system clipboard
" cP is mapped to copy the current line directly.
" cV is mapped to paste the content of system clipboard to the next line.
" other option: Plug 'ojroques/vim-oscyank'

" scroll through time instead of space
" map <ScrollWheelUp>   :later 10m<CR>
" map <ScrollWheelDown> :earlier 10m<CR>
" nnoremap <Up>   :later 10m<CR>
" nnoremap <Down> :earlier 10m<CR>

"*** seems to remove the ability to '.' ***
" Re-select blocks after indenting in visual/select mode
" xnoremap < <gv
" xnoremap > >gv
" xnoremap > >gv| ?
" move cursor with it
" vnoremap <expr> > ">gv"..&shiftwidth.."l"
" vnoremap <expr> < "<gv"..&shiftwidth.."h"
" move cursor to beginning of line
" vnoremap > >gv^
" vnoremap < <gv^
" or
" vnoremap <Tab> >gv
" vnoremap <S-Tab> <gv

" allow tab/s-tab to filter with incsearch in-progress
" cnoremap <expr> <Tab>   getcmdtype() =~ "[?/]" ? "<c-g>" : "<Tab>"
" cnoremap <expr> <S-Tab> getcmdtype() =~ "[?/]" ? "<c-t>" : "<S-Tab>"
