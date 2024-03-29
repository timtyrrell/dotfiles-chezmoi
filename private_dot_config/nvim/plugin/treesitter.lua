require('nvim-treesitter.configs').setup {
  auto_install = true,
  ensure_installed = { "bash", "css", "embedded_template", "graphql", "html", "http", "javascript", "jsdoc", "json", "jsonc", "lua", "regex", "ruby", "tsx", "typescript" },
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

require('hlslens').setup({
  nearest_only = true
})

-- loaded after nvim-treesitter and any completion that already uses your tabkey.
require('tabout').setup {
  act_as_tab = true, -- shift content if tab out is not possible
  act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
  default_tab = '<C-t>', -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
  default_shift_tab = '<C-d>', -- reverse shift default action,
  enable_backwards = true, -- well ...
  completion = false, -- if the tabkey is used in a completion pum
}
