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

---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= "table" then
            return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
                p[i] = {
                    token = ev.data.params.token,
                    msg = ("[%3d%%] %s%s"):format(
                        value.kind == "end" and 100 or value.percentage or 100,
                        value.title or "",
                        value.message and (" **%s**"):format(value.message) or ""
                    ),
                    done = value.kind == "end",
                }
                break
            end
        end

        local msg = {} ---@type string[]
        progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(table.concat(msg, "\n"), "info", {
            id = "lsp_progress",
            title = client.name,
            opts = function(notif)
                notif.icon = #progress[client.id] == 0 and " "
                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
        })
    end,
})

--- if you want to know more about mason.nvim
--- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require('mason').setup({
    pip = {
        upgrade_pip = true,
    }
})

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

local noop = function() end

-- Enable language servers with the additional completion capabilities offered by nvim-cmp
require('mason-lspconfig').setup({
    automatic_enable = true,
    handlers = {
        function(server_name)
            -- print("Auto Install LSP: " .. server_name)
            vim.lsp.config(server_name, { capabilities = capabilities })
        end,
        ['clangd'] = function()
            vim.lsp.config('clangd', {
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
            vim.lsp.config('harper_ls', { capabilities = capabilities, autostart = false })
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

local ftMap = {
    vim = 'indent',
    python = {'indent'},
    git = ''
}
require('ufo').setup({
    open_fold_hl_timeout = 150,
    close_fold_kinds_for_ft = {
        default = {'imports', 'comment'},
        json = {'array'},
        c = {'comment', 'region'}
    },
    preview = {
        win_config = {
            border = {'', '─', '', '', '', '─', '', ''},
            winhighlight = 'Normal:Folded',
            winblend = 0
        },
        mappings = {
            scrollU = '<C-u>',
            scrollD = '<C-d>',
            jumpTop = '[',
            jumpBot = ']'
        }
    },
    provider_selector = function(bufnr, filetype, buftype)
        -- if you prefer treesitter provider rather than lsp,
        -- return ftMap[filetype] or {'treesitter', 'indent'}
        return ftMap[filetype]

        -- refer to ./doc/example.lua for detail
    end
})

vim.keymap.set('n', 'zR', require('ufo').openAllFolds, {desc="Open All Folds"})
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, {desc="Close All Folds"})
vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds, {desc="Open All Folds Except"})
vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith, {desc="Close All Folds With"}) -- closeAllFolds == closeFoldsWith(0)
vim.keymap.set('n', 'K', function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
        -- choose one of coc.nvim and nvim lsp
        vim.lsp.buf.hover()
    end
end)
