local M = {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,

    config = function ()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {"lua", "vim", "vimdoc", "bash", "gitignore", "json", "python", "tcl", "cpp", "c"},
            sync_install = false,
            highlight = {
                enable = true
            },
            indent = {
                enable = true
            }
        })
    end,
}

return { M }
