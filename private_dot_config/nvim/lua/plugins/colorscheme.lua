return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('tokyonight').setup({
        lualine_bold = true,
        style = 'night',
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
        },
        dim_inactive = true,
        on_highlights = function(hl, c)
          hl.LeapBackdrop = { fg = '#545c7e' }
          hl.LeapLabel = { bold = true, fg = '#73daca' }
          hl.LeapMatch = { bg = '#ff007c', bold = true, fg = '#c0caf5' }
          -- Let tmux window-style/window-active-style show through so nvim panes
          -- dim with tmux pane focus. NormalNC is left alone so dim_inactive still
          -- dims inactive splits within a single nvim instance.
          hl.Normal = { fg = c.fg, bg = 'NONE' }
          hl.SignColumn = { fg = c.fg_gutter, bg = 'NONE' }
          hl.FoldColumn = { fg = c.comment, bg = 'NONE' }
          hl.EndOfBuffer = { fg = c.bg }
        end,
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
