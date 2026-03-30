return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-dap.nvim',
      'nvim-telescope/telescope-node-modules.nvim',
      'LinArcX/telescope-env.nvim',
      'debugloop/telescope-undo.nvim',
      'piersolenski/import.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      local actions = require('telescope.actions')
      local action_layout = require('telescope.actions.layout')

      require('telescope').setup {
        defaults = {
          cache_picker = { num_pickers = 10 },
          dynamic_preview_title = true,
          layout_strategy = 'vertical',
          layout_config = {
            vertical = {
              width = 0.9, height = 0.9, preview_height = 0.6,
              preview_cutoff = 0, prompt_position = 'top', mirror = true,
            },
          },
          path_display = { 'smart', shorten = { len = 3 } },
          wrap_results = true,
          sorting_strategy = 'ascending',
          mappings = {
            n = {
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<esc>'] = actions.close,
              ['<M-p>'] = action_layout.toggle_preview,
              ['<C-n>'] = actions.cycle_history_next,
              ['<C-p>'] = actions.cycle_history_prev,
              ['<c-d>'] = actions.delete_buffer,
            },
            i = {
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<M-p>'] = action_layout.toggle_preview,
              ['<C-n>'] = actions.cycle_history_next,
              ['<C-p>'] = actions.cycle_history_prev,
              ['<c-d>'] = actions.delete_buffer,
            },
          },
        },
        pickers = {
          current_buffer_fuzzy_find = { skip_empty_lines = true },
          grep_string = { sort_only_text = true },
          live_grep = {
            mappings = {
              i = { ['<c-f>'] = require('telescope.actions').to_fuzzy_refine },
            },
            only_sort_text = true,
            on_input_filter_cb = function(prompt)
              return { prompt = prompt:gsub('%s', '.*') }
            end,
          },
          buffers = {
            ignore_current_buffer = true,
            sort_lastused = true,
          },
          colorscheme = { enable_preview = true },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          },
          heading = { treesitter = true },
          ['ui-select'] = { require('telescope.themes').get_dropdown({}) },
          undo = {
            side_by_side = true,
            layout_strategy = 'vertical',
            layout_config = { preview_height = 0.8 },
            mappings = {
              i = {
                ['<cr>'] = require('telescope-undo.actions').yank_additions,
                ['<S-cr>'] = require('telescope-undo.actions').yank_deletions,
                ['<C-cr>'] = require('telescope-undo.actions').restore,
              },
            },
          },
          import = { insert_at_top = true },
        },
      }

      require('telescope').load_extension('node_modules')
      require('telescope').load_extension('git_worktree')
      require('telescope').load_extension('fzf')
      require('telescope').load_extension('env')
      require('telescope').load_extension('notify')
      require('telescope').load_extension('ui-select')
      require('telescope').load_extension('undo')
      require('telescope').load_extension('dap')
    end,
  },
}
