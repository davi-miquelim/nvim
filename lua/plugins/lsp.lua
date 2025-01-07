return {
    {
        'williamboman/mason.nvim',
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()
            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {'ts_ls', 'html', 'eslint', 'gopls', 'lua_ls', 'pyright' , 'emmet_ls', 'templ'},
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require("lspconfig").lua_ls.setup(lua_opts)
                  end,
                }
            })
        end
    },
    {
        "hrsh7th/nvim-cmp",
    }
}

