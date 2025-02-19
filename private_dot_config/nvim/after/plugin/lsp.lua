local keymap = vim.keymap

-- note: diagnostics are not exclusive to lsp servers
-- so these can be global keybindings
keymap.set('n', 'gl', function () vim.diagnostic.open_float() end, { desc = 'Open Float Diagnostic'})
keymap.set('n', '[d', function () vim.diagnostic.jump({count=1, float=true}) end, { desc = 'Go to Next Diagnostic'})
keymap.set('n', ']d', function () vim.diagnostic.jump({count=-1, float=true}) end, { desc = 'Go to Previous Diagnostic'})

vim.diagnostic.config({
    signs = true,
    virtual_text = true,
})

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        -- these will be buffer-local keybindings
        -- because they only work if you have an active language server

        keymap.set('n', 'K', function () vim.lsp.buf.hover() end, { buffer = event.buf, desc = 'Lsp Hover' })
        keymap.set('n', 'gd', function () vim.lsp.buf.definition() end, { buffer = event.buf, desc = 'Lsp go to Definition' })
        keymap.set('n', 'gD', function () vim.lsp.buf.declaration() end, { buffer = event.buf, desc = 'Lsp go to Declaration' })
        keymap.set('n', 'gi', function () vim.lsp.buf.implementation() end, { buffer = event.buf, desc = 'Lsp go to Implementation' })
        keymap.set('n', 'go', function () vim.lsp.buf.type_definition() end, { buffer = event.buf, desc = 'Lsp go to Type Definition' })
        keymap.set('n', 'gr', function () vim.lsp.buf.references() end, { buffer = event.buf, desc = 'Lsp References' })
        keymap.set('n', 'gs', function () vim.lsp.buf.signature_help() end, { buffer = event.buf, desc = 'Lsp Signature Help' })
        keymap.set('n', '<F2>', function () vim.lsp.buf.rename() end, { buffer = event.buf, desc = 'Lsp Rename' })
        keymap.set({'n', 'x'}, '<F3>', function () vim.lsp.buf.format({async = true}) end, { buffer = event.buf, desc = 'Lsp Format' })
        keymap.set('n', '<F4>', function () vim.lsp.buf.code_action() end, { buffer = event.buf, desc = 'Lsp Code Action' })
    end
})

keymap.set('n', '<leader>fn', function () require("telescope").extensions.notify.notify() end, { desc = "Find notifications" })

require('lsp-notify').setup({})

--- if you want to know more about mason.nvim
--- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require('mason').setup({
    pip = {
        upgrade_pip = true,
    }
})

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local noop = function() end

-- Enable language servers with the additional completion capabilities offered by nvim-cmp
require('mason-lspconfig').setup({
    handlers = {
        function(server_name)
            -- print("Auto Install LSP: " .. server_name)
            require('lspconfig')[server_name].setup({ capabilities = capabilities })
        end,
        ['clangd'] = function()
            require('lspconfig')['clangd'].setup({
                capabilities = capabilities,
                cmd = {
                    "clangd",
                    "--background-index",
                    "-j=12",
                    "--query-driver=/usr/bin/**/clang-*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++",
                    "--clang-tidy",
                    "--clang-tidy-checks=*",
                    "--all-scopes-completion",
                    "--cross-file-rename",
                    "--completion-style=detailed",
                    "--header-insertion-decorators",
                    "--header-insertion=iwyu",
                    "--pch-storage=memory",
                }
            })
        end,
        ['bashls'] = function()
            require("lspconfig")['bashls'].setup({
                capabilities = capabilities,
                filetypes = {
                    "sh",
                    "zsh",
                },
                settings = {
                    bashIde = {
                        globPattern = "*@(.sh|.inc|.bash|.command)"
                    }
                }
            })

        end,
        ['lua_ls'] = function ()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }
                        }
                    }
                }
            }
        end,
        ['harper_ls'] = function ()
            require('lspconfig')['harper_ls'].setup({ capabilities = capabilities, autostart = false })
        end,
    },
})



local luasnip = require('luasnip')
local cmp = require('cmp')

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
        ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
        -- C-b (back) C-f (forward) for snippet placeholder navigation.
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}
