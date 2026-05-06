---@module 'lazy'
---@type LazySpec
return {
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'L3MON4D3/LuaSnip'},

    {
        'mason-org/mason.nvim',
        config = function()
            if os.name() == "Linux" then
                MASON_PATH = os.getenv("HOME") .. "/.local/share/nvim/mason"
            elseif os.name() == "Windows" then
                MASON_PATH = os.getenv("LOCALAPPDATA") .. "\\nvim-data\\mason"
            end
            if not os.file_exists(MASON_PATH) then
                MASON_PATH = ""
            end
        end,
    },
    {'mason-org/mason-lspconfig.nvim'},
    {'mfussenegger/nvim-lint'},
    {
        'bitwisecook/tcl-lsp',
        build = function()
            local python_version = "3.14"
            local install_path = vim.fn.stdpath("data") .. "/lazy/tcl-lsp"
            local out = vim.fn.system({ "uv", "python", "install", python_version })
            if vim.v.shell_error ~= 0 then
                vim.api.nvim_echo({
                    { "Failed to install Python " .. python_version .. ":\n", "ErrorMsg" },
                    { out, "WarningMsg" },
                    { "\n" },
                }, true, {})
            end
            out = vim.fn.system({ "uv", "sync", "--directory", install_path })
            if vim.v.shell_error ~= 0 then
                vim.api.nvim_echo({
                    { "Failed to install Python " .. python_version .. ":\n", "ErrorMsg" },
                    { out, "WarningMsg" },
                    { "\n" },
                }, true, {})
            end
        end
    }
}
