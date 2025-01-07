-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    {
      "VonHeikemen/lsp-zero.nvim",
      branch = 'v3.x',
      dependencies = {
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},

        -- LSP Support
        {'neovim/nvim-lspconfig'},
        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'L3MON4D3/LuaSnip'},
      },
      config = function ()
          local cmp = require("cmp")

          cmp.setup({
            sources = {
              {name = 'path'},
              {name = 'nvim_lsp'},
              {name = 'nvim_lua'},
              {name = 'luasnip', keyword_length = 2},
              {name = 'buffer', keyword_length = 3},
            },
            formatting = require("lsp-zero").cmp_format(),
            mapping = cmp.mapping.preset.insert({
              ['<C-p>'] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}),
              ['<C-n>'] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}),
              ['<C-y>'] = cmp.mapping.confirm({ select = true }),
              ['<C-Space>'] = cmp.mapping.complete(),
            }),
          })

          vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
          vim.keymap.set("n", "<leader>h", function() vim.lsp.buf.hover() end)
          vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
          vim.keymap.set("n", "<leader>e", function() vim.diagnostic.open_float() end)
          vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end)
          vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end)
          vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end)
          vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end)
          vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end)
      end
    },
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "scottmckendry/cyberdream.nvim" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

local color = "cyberdream"
vim.cmd.colorscheme(color)
