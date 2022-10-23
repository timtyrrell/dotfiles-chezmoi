require('nvim-treesitter.configs').setup {
  auto_install = true,
  ensure_installed = { "bash", "comment", "css", "graphql", "html", "http", "javascript", "jsdoc", "json", "jsonc", "lua", "regex", "ruby", "tsx", "typescript" },
  ignore_install = { "phpdoc" },
  -- disable slow treesitter highlight for large files
  disable = function(lang, buf)
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    if ok and stats and stats.size > max_filesize then
      return true
    end
  end,
  highlight = {
    enable = true,
    disable = { },
  },
  indent = {
    enable = true
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  -- https://github.com/andymass/vim-matchup
  matchup = {
    enable = true,
  },
  context_commentstring = {
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
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
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
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
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

require('hlargs').setup({
  extras = {
    named_parameters = true,
  },
})

require('hlslens').setup({
  nearest_only = true
})

-- Plug 'nvim-treesitter/playground', { 'on': ['TSHighlightCapturesUnderCursor', 'TSNodeUnderCursor']}
-- :TSHighlightCapturesUnderCursor
-- :TSNodeUnderCursor
-- R: Refreshes the playground view when focused or reloads the query when the query editor is focused.
-- o: Toggles the query editor when the playground is focused.
-- a: Toggles visibility of anonymous nodes.
-- i: Toggles visibility of highlight groups.
-- I: Toggles visibility of the language the node belongs to.
-- t: Toggles visibility of injected languages.
-- f: Focuses the language tree under the cursor in the playground. The query editor will now be using the focused language.
-- F: Unfocuses the currently focused language.
-- <cr>: Go to current node in code buffer

-- loaded after nvim-treesitter and any completion that already uses your tabkey.
-- require('tabout').setup {}
