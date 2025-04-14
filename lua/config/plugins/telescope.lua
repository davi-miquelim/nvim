return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      require('telescope').setup {
        extensions = {
          fzf = {}
        }
      }

      require('telescope').load_extension('fzf')
      local builtin = require('telescope.builtin')

      vim.keymap.set("n", "<space>gs", builtin.grep_string)
      vim.keymap.set("n", "<space>g", builtin.live_grep)
      vim.keymap.set("n", "<space>fh", builtin.help_tags)
      vim.keymap.set("n", "<space>fd", builtin.find_files)
      vim.keymap.set("n", "<space>fp", builtin.git_files)
      vim.keymap.set("n", "<space>ec", function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath("config")
        }
      end)
    end
  }
}
