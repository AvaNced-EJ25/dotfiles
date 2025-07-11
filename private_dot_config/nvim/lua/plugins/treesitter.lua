local M = {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
    },
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,

    config = function ()
        require("nvim-treesitter.install").prefer_git = false
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "lua", "luadoc", "vim", "vimdoc", "bash", "gitignore", "git_config", "ssh_config", "toml", "yaml",
                "json", "jsonc", "markdown", "markdown_inline", "latex", "powershell", "regex", "csv",
                "python", "tcl", "cpp", "c", "make", "cmake", "ninja", "comment", "tmux",
                "html", "javascript", "typescript", "tsx", "css", "dockerfile",
            },
            highlight = {
                enable = true,
                disable = function(lang, bufnr)
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

        require("treesitter-context").setup()
    end,
}

return { M }
