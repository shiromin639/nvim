return {
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets" },
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
    },
    {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                window = {
                    completion = {
                        border = 'rounded',
                        max_height = 10,
                        side_padding = 0,
                    },
                    documentation = {
                        max_height = 10,
                        border = 'rounded',
                    },
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
                    ["<C-j>"] = cmp.mapping.select_next_item(),

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "zls" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "pylsp" },
                    { name = "gci" },
                    { name = "ts_ls" },
                    { name = "gopls" },
                    { name = "nix" },
                    { name = "buf_ls" },
                    { name = "render-markdown" },
                    { name = "cobol_ls" },
                }),
                -- formatting = {
                --     format = function(entry, item)
                --         local widths = {
                --             abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
                --             menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
                --         }
                --
                --         for key, width in pairs(widths) do
                --             if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
                --                 item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
                --             end
                --         end
                --
                --       return item 
                --     end,
                -- },
            })
        end,
    },
}
