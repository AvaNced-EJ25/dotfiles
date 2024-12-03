return {
    "winston0410/range-highlight.nvim",
    dependencies = {
        "winston0410/cmd-parser.nvim",
    },
    configure = function()
        require('range-highlight').setup({})
    end,
}
