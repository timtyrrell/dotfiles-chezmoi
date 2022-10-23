" Plug 'tpope/vim-fugitive'

" 1. Run :G mergetool.
" 2. (If you need a diff view, run :Gvdiffsplit! or any other variant.)
" 3. Resolve the conflicts, then write and stage the result with :Gwrite.
" 4. (Close other windows, if any, with <C-w><C-o>.)
" 5. Go to the next quickfix entry with ]q or :cnext.

" Fugitive Conflict Resolution
" nnoremap <leader>gd :Gvdiff<CR>
" nnoremap gdh :diffget //2<CR> (left key)
" nnoremap gdl :diffget //3<CR> (right key)
" jump conflicts: ]c [c
"
" When I'm in a 3-way diff and hit ,ga, vim opens a new tab and diffs the file in the active window against the common ancestor. When I'm done reading the diff, I just :tabclose and I'm right back to where I was.
" nnoremap <leader>ga :tab sp \| Gvedit :1 \| windo diffthis<CR>

" logs for entire repo
nnoremap <leader>gv :GV<cr>
" logs for entire repo, cleaned up
nnoremap <leader>gV :GV --first-parent -100<cr>
" nnoremap <leader>gV :GV --no-merges --first-parent -100<cr>
" logs for current file
nnoremap <leader>GV :GV! -100<cr>
" gq or q exit
" O opens a new tab instead
" gb for :GBrowse
" ]] and [[ to move between commits
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
" ~     reblame at commit~[count]
" P     reblame at commit^[count]

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

nnoremap <leader>gr :Gread<cr>:update<cr>
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
nnoremap <Leader>go <cmd>GBrowse master<cr>
" nnoremap <Leader>go <cmd>GBrowse main<cr>

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
nnoremap <leader>gs :tab Git<CR>
" P (on the file you want to run patch on)
" <C-N> or <C-P> to jump to the next/previous file
" - on a file, stages (or unstages) the entire file.
" = shows the git diff of the file your cursor is on.
" - on a hunk, stages (or unstages) the hunk.
" - in a visual selection, stages (or unstages) the selected lines in the hunk.
" cc                      Create a commit.
" ca                      Amend the last commit and edit the message.
" ce                      Amend the last commit without editing the message.
" cw                      Reword the last commit.
" cvc                     Create a commit with -v.
" cva                     Amend the last commit with -v
" cf                      Create a `fixup!` commit for the commit under the cursor.
" cF                      Create a `fixup!` commit for the commit under the cursor and immediately rebase it.
" cs                      Create a `squash!` commit for the commit under the cursor.
" cS                      Create a `squash!` commit for the commit under the cursor and immediately rebase it.
" cA                      Create a `squash!` commit for the commit under the cursor and edit the message.
" crc                     Revert the commit under the cursor.
" crn                     Revert the commit under the cursor in the index and work tree, but do not actually commit the changes.
" cr<Space>               Populate command line with ":Git revert ".
" cm<Space>               Populate command line with ":Git merge ".
" c?                      Show this help.
"
" Rebase maps ~
" ri                      Perform an interactive rebase.  Uses ancestor of
" u                       commit under cursor as upstream if available.
" rf                      Perform an autosquash rebase without editing the todo list.  Uses ancestor of commit under cursor as upstream if available.
" ru                      Perform an interactive rebase against @{upstream}.
" rp                      Perform an interactive rebase against @{push}.
" rr                      Continue the current rebase.
" rs                      Skip the current commit and continue the current rebase.
" ra                      Abort the current rebase.
" re                      Edit the current rebase todo list.
" rw                      Perform an interactive rebase with the commit under the cursor set to `reword`.
" rm                      Perform an interactive rebase with the commit under the cursor set to `edit`.
" rd                      Perform an interactive rebase with the commit under the cursor set to `drop`.
" r<Space>                Populate command line with ":Git rebase ".
" r?                      Show this help.
"
" :Gwrite[!] write the current file to the index and exits vimdiff mode.
" HUNKS
" do - `diffget` (obtain)
" dp - `diffput`
" staging hunks: https://vi.stackexchange.com/questions/10368/git-fugitive-how-to-git-add-a-visually-selected-chunk-of-code/10369#10369

" put changed file names from previous commit into the quickfix list
command -nargs=? -bar Gshow call setqflist(map(systemlist("git show --pretty='' --name-only <args>"), '{"filename": v:val, "lnum": 1}'))


" diff on file
nnoremap <leader>dvf <Cmd>DiffviewFileHistory <cr>
" diff on project commits
nnoremap <leader>dvF <Cmd>DiffviewFileHistory<cr>
nnoremap <leader>dvp <Cmd>DiffviewOpen HEAD~1<cr>
nnoremap <leader>dvm <Cmd>DiffviewOpen origin/master...HEAD<cr>
nnoremap <leader>dvh <Cmd>DiffviewFileHistory --range=origin/master..HEAD<cr>
vnoremap <leader>dvh <Cmd>'<,'>DiffviewFileHistory<CR>
nnoremap <leader>dvo <cmd>DiffviewOpen<cr>
" also use during a merge or rebase
" The default mapping `g<C-x>` allows you to cycle through the available layouts.
" "diff1_plain"
    " | "diff2_horizontal"
    " | "diff2_vertical"
    " | "diff3_horizontal"
    " | "diff3_vertical"
    " | "diff3_mixed"
    " | "diff4_mixed"
    " | -1
" to take all "theirs"
" !git checkout --theirs --

" Plug 'rhysd/git-messenger.vim'
let g:git_messenger_date_format = "%Y %b %d %X"
" <Leader>gm
" q 	Close the popup window
" o/O 	older commit/newer commit
" d/D 	Toggle diff hunks only related to current file in the commit/All Diffs

let g:git_messenger_always_into_popup = 1
let g:git_messenger_include_diff = 'current'
let g:git_messenger_extra_blame_args ='-w' " Ignore whitespace
let g:git_messenger_floating_win_opts = { 'border': 'single' }

" Plug 'andrewradev/linediff.vim'
" :Linediff

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

" Toggle diff view on the left, center, or right windows
" nmap <silent> <leader>dfl :call difftoggle#DiffToggle(1)<cr>
" nmap <silent> <leader>dfm :call difftoggle#DiffToggle(2)<cr>
" nmap <silent> <leader>dfr :call difftoggle#DiffToggle(3)<cr>

" Toggle ignoring whitespace
" nmap <silent> <leader>dw :call iwhitetoggle#IwhiteToggle()<CR>

" Find merge conflict markers
" map <leader>dc /\v^[<=>]{7}( .*\|$)<cr>

" Plug 'sindrets/diffview.nvim'
" diff on file
nnoremap <leader>dvf <Cmd>DiffviewFileHistory %<cr>
" diff on project commits
nnoremap <leader>dvF <Cmd>DiffviewFileHistory<cr>
nnoremap <leader>dvp <Cmd>DiffviewOpen HEAD~1<cr>
nnoremap <leader>dvm <Cmd>DiffviewOpen origin/master...HEAD<cr>
nnoremap <leader>dvh <Cmd>DiffviewFileHistory --range=origin/master..HEAD<cr>
vnoremap <leader>dvh <Cmd>'<,'>DiffviewFileHistory<CR>
nnoremap <leader>dvo <cmd>DiffviewOpen<cr>
" also use during a merge or rebase
" The default mapping `g<C-x>` allows you to cycle through the available layouts.
" "diff1_plain"
    " | "diff2_horizontal"
    " | "diff2_vertical"
    " | "diff3_horizontal"
    " | "diff3_vertical"
    " | "diff3_mixed"
    " | "diff4_mixed"
    " | -1
" to take all "theirs"
" !git checkout --theirs -- %

" Plug 'pwntester/octo.nvim'
nnoremap <leader>opr <cmd>Octo pr list<cr>
nnoremap <leader>ors <cmd>Octo review start<cr>
nnoremap <leader>orr <cmd>Octo review resume<cr>
nnoremap <leader>orb <cmd>Octo review submit<cr>

lua << EOF

require('octo').setup({
  submit_win = {
      approve_review = "<C-p>",            -- approve review
      comment_review = "<C-m>",            -- comment review
      request_changes = "<C-r>",           -- request changes review
      close_review_tab = "<C-c>",          -- close review tab
    },
})

-- require('litee.lib').setup({
--     tree = {
--         icon_set = "nerd"
--     },
--     panel = {
--         orientation = "left",
--         panel_size  = 50
--     }
-- })
-- require('litee.gh').setup({
--     icon_set    = "nerd",
--     -- remap the arrow keys to resize any litee.nvim windows.
--     map_resize_keys = false,
--     -- do not map any keys inside any gh.nvim buffers.
--     disable_keymaps = false,
--     -- defines keymaps in gh.nvim buffers.
--     keymaps = {
--         open = "<CR>",
--         expand = "zo",
--         collapse = "zc",
--         goto_issue = "gd",
--         details = "d",
--         submit_comment = "<C-s>",
--         actions = "<C-a>",
--         resolve_thread = "<C-r>",
--         goto_web = "gx"
--     },
--   })

EOF


" Plug 'ldelossa/litee.nvim'
" Plug 'ldelossa/gh.nvim'

" Plug 'ThePrimeagen/git-worktree.nvim'
nnoremap <silent><space>wl :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
nnoremap <silent><space>wb :lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>

lua << EOF
local actions = require("diffview.actions")
require("diffview").setup {
  file_panel = {
    listing_style = "list",
    win_config = {
      height = 16,
      width = 45,
      position = "bottom",
    },
  },
  file_history_panel = {
    single_file = {
      log_options = {
        max_count = 256,
        no_merges = true,
      },
    },
    multi_file = {
      log_options = {
        max_count = 256,
        no_merges = true,
      },
    },
    win_config = {
      width = 35,
      height = 16,
    },
  },
  keymaps = {
    view = {
      ["]q"]         = actions.select_next_entry,
      ["[q"]         = actions.select_prev_entry,
      ["gf"]         = actions.goto_file_tab,
      ["<C-w><C-f>"] = actions.goto_file_split,
      ["<C-w>gf"]    = actions.goto_file,            -- Open the file in a new split in previous tabpage
      ["<leader>ee"] = actions.focus_files,
      ["<leader>et"] = actions.toggle_files,
      ["g<C-x>"]     = actions.cycle_layout,              -- Cycle through available layouts.
      ["[x"]         = actions.prev_conflict,             -- In the merge_tool: jump to the previous conflict
      ["]x"]         = actions.next_conflict,             -- In the merge_tool: jump to the next conflict
      ["<leader>co"] = actions.conflict_choose("ours"),   -- Choose the OURS version of a conflict
      ["<leader>ct"] = actions.conflict_choose("theirs"), -- Choose the THEIRS version of a conflict
      ["<leader>cb"] = actions.conflict_choose("base"),   -- Choose the BASE version of a conflict
      ["<leader>ca"] = actions.conflict_choose("all"),    -- Choose all the versions of a conflict
      ["dx"]         = actions.conflict_choose("none"),   -- Delete the conflict region
    },
    diff1 = { --[[ Mappings in single window diff layouts ]] },
    diff2 = { --[[ Mappings in 2-way diff layouts ]] },
    diff3 = {
      -- Mappings in 3-way diff layouts
      { { "n", "x" }, "2do", actions.diffget("ours") },   -- Obtain the diff hunk from the OURS version of the file
      { { "n", "x" }, "3do", actions.diffget("theirs") }, -- Obtain the diff hunk from the THEIRS version of the file
    },
    diff4 = {
      -- Mappings in 4-way diff layouts
      { { "n", "x" }, "1do", actions.diffget("base") },   -- Obtain the diff hunk from the BASE version of the file
      { { "n", "x" }, "2do", actions.diffget("ours") },   -- Obtain the diff hunk from the OURS version of the file
      { { "n", "x" }, "3do", actions.diffget("theirs") }, -- Obtain the diff hunk from the THEIRS version of the file
    },
    file_panel = {
      ["<cr>"]          = actions.select_entry,         -- Open the diff for the selected entry.
      ["o"]             = actions.select_entry,
      ["-"]             = actions.toggle_stage_entry,
      ["S"]             = actions.stage_all,
      ["U"]             = actions.unstage_all,
      ["X"]             = actions.restore_entry,
      ["R"]             = actions.refresh_files,
      ["L"]             = actions.open_commit_log,
      ["]q"]            = actions.select_next_entry,
      ["[q"]            = actions.select_prev_entry,
      ["gf"]            = actions.goto_file_tab,
      ["<C-w><C-f>"]    = actions.goto_file_split,
      ["<C-w>gf"]       = actions.goto_file,            -- Open the file in a new split in previous tabpage
      ["i"]             = actions.listing_style,        -- Toggle between 'list' and 'tree' views
      ["f"]             = actions.toggle_flatten_dirs,  -- Flatten empty subdirectories in tree listing style.
      ["<leader>ee"]    = actions.focus_files,
      ["<leader>et"]    = actions.toggle_files,
      ["g<C-x>"]        = actions.cycle_layout,
      ["[x"]            = actions.prev_conflict,
      ["]x"]            = actions.next_conflict,
    },
    file_history_panel = {
      ["g!"]            = actions.options,              -- Open the option panel
      { "n", "r", "g!=r", { remap = true } }, -- Press `r` to change the `++rev-range`
      ["<C-A-d>"]       = actions.open_in_diffview,     -- Open the entry under the cursor in a diffview
      ["y"]             = actions.copy_hash,            -- Copy the commit hash of the entry under the cursor
      ["L"]             = actions.open_commit_log,
      ["zR"]            = actions.open_all_folds,
      ["zM"]            = actions.close_all_folds,
      ["<cr>"]          = actions.select_entry,         -- Open the diff for the selected entry.
      ["o"]             = actions.select_entry,
      ["]q"]            = actions.select_next_entry,
      ["[q"]            = actions.select_prev_entry,
      ["gf"]            = actions.goto_file_tab,
      ["<C-w><C-f>"]    = actions.goto_file_split,
      ["<C-w>gf"]       = actions.goto_file,            -- Open the file in a new split in previous tabpage
      ["<leader>ee"]    = actions.focus_files,
      ["<leader>et"]    = actions.toggle_files,
      ["g<C-x>"]        = actions.cycle_layout,
    },
    option_panel = {
      ["<cr>"]          = actions.select_entry,
      ["q"]             = actions.close,
    },
  },
}
EOF

" remove all this and use Plug 'sindrets/diffview.nvim'?
command! DiffHistory call s:view_git_history()

function! s:view_git_history() abort
  Git difftool --name-only ! !^@
  call s:diff_current_quickfix_entry()
  " Bind <CR> for current quickfix window to properly set up diff split layout after selecting an item
  " There's probably a better way to map this without changing the window
  copen
  nnoremap <buffer> <CR> <CR><BAR>:call <sid>diff_current_quickfix_entry()<CR>
  wincmd p
endfunction

function s:diff_current_quickfix_entry() abort
  " Cleanup windows
  for window in getwininfo()
    if window.winnr !=? winnr() && bufname(window.bufnr) =~? '^fugitive:'
      exe 'bdelete' window.bufnr
    endif
  endfor
  cc
  call s:add_mappings()
  let qf = getqflist({'context': 0, 'idx': 0})
  if get(qf, 'idx') && type(get(qf, 'context')) == type({}) && type(get(qf.context, 'items')) == type([])
    let diff = get(qf.context.items[qf.idx - 1], 'diff', [])
    echom string(reverse(range(len(diff))))
    for i in reverse(range(len(diff)))
      exe (i ? 'leftabove' : 'rightbelow') 'vert diffsplit' fnameescape(diff[i].filename)
      call s:add_mappings()
    endfor
  endif
endfunction

function! s:add_mappings() abort
  nnoremap <buffer>]q :cnext <BAR> :call <sid>diff_current_quickfix_entry()<CR>
  nnoremap <buffer>[q :cprevious <BAR> :call <sid>diff_current_quickfix_entry()<CR>
  " Reset quickfix height. Sometimes it messes up after selecting another item
  11copen
  wincmd p
endfunction

" https://github.com/tpope/vim-fugitive/issues/132#issuecomment-570844756
function DiffCurrentQuickfixEntry() abort
  cc
  let qf = getqflist({'context': 0, 'idx': 0})
  if get(qf, 'idx') && type(get(qf, 'context')) == type({}) && type(get(qf.context, 'items')) == type([])
    let diff = get(qf.context.items[qf.idx - 1], 'diff', [])
    for i in reverse(range(len(diff)))
      exe (i ? 'rightbelow' : 'leftabove') 'vert diffsplit' fnameescape(diff[i].filename)
      wincmd p
    endfor
  endif
endfunction

command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
                \ | diffthis | wincmd p | diffthis

