return {
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    keys = {
        {
            "n",
            function()
                require("tiny-glimmer").search_next()
            end,
            { noremap = true, silent = true },
        },
        {
            "N",
            function()
                require("tiny-glimmer").search_prev()
            end,
            { noremap = true, silent = true },
        },
        {
            "p",
            function()
                require("tiny-glimmer").paste()
            end,
            { noremap = true, silent = true },
        },
        {
            "P",
            function()
                require("tiny-glimmer").Paste()
            end,
            { noremap = true, silent = true },
        },
        {
            "*",
            function()
                require("tiny-glimmer").search_under_cursor()
            end,
            { noremap = true, silent = true },
        }
    },
    opts = {
        overwrite = {
            search = {
                enabled = true
            },
        },
    },
}
