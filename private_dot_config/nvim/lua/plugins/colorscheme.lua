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
        end,
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
