local M = {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
    },
    lazy = false,
    build = ':TSUpdate',
    config = function ()
        require('nvim-treesitter').install({
            "lua", "luadoc", "bash", "gitignore", "git_config", "ssh_config", "toml", "yaml",
            "json", "jsonc", "markdown", "markdown_inline", "powershell", "regex", "csv",
            "python", "cpp", "c", "make", "cmake", "comment", "html", "javascript", "typescript", "tsx", "css",
        })

        require("treesitter-context").setup({
            max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
            min_window_height = 40, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        })
    end,
}

return { M }
