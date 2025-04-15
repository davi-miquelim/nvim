return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      {
        "saghen/blink.cmp"
      },
    },
    opts = {
      servers = {
        lua_ls = {},
        ts_ls = {}
      }
    },
    config = function(_, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })

      local lspconfig = require("lspconfig")
      local blink = require("blink.cmp")

      for server, config in pairs(opts.servers) do
        local capabilities = config.capabilities
        capabilities = blink.get_lsp_capabilities(capabilities)
        lspconfig[server].setup(config)
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end
          local diagnostic = vim.diagnostic.get(0)
          vim.diagnostic.setqflist(diagnostic)

          if client:supports_method('textDocument/formatting') then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })
    end
  },
}
