local M = {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,

    config = function ()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "lua", "luadoc", "vim", "vimdoc", "bash", "gitignore", "git_config", "ssh_config", "toml", "yaml",
                "json", "jsonc", "markdown", "markdown_inline", "latex", "powershell", "regex", "csv",
                "python", "tcl", "cpp", "c", "make", "cmake", "ninja", "comment", "tmux",
                "html", "javascript", "typescript", "css", "dockerfile",
            },
            sync_install = true,
            highlight = {
                enable = true,
                disable = function()
                    -- check if 'filetype' option includes 'chezmoitmpl'
                    if string.find(vim.bo.filetype, 'chezmoitmpl') then
                        return true
                    end
                end,
            },
            indent = {
                enable = true
            }
        })
    end,
}

return { M }
