return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all" (the listed parsers MUST always be installed)
	  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "typescript", "markdown", "markdown_inline", "javascript", "asm", "elixir"},

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

	highlight = {
	  enable = true,
	  --
	  -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
	  disable = function(lang, buf)
	      local max_filesize = 100 * 1024 -- 100 KB
	      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
	      if ok and stats and stats.size > max_filesize then
		  return true
	      end
	  end,

	  additional_vim_regex_highlighting = false,
	},
      }
    end
  },
}
