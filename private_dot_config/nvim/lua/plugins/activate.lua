return {
    "roobert/activate.nvim",
    keys = {
        {
            "<leader>P",
            function() require("activate").list_plugins()end,
            desc = "Plugins",
        },
    },
    dependencies = {
        { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } }
    }
}
