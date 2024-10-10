return {
    { "folke/neodev.nvim" },
    { "folke/which-key.nvim" },
    { "folke/neoconf.nvim", cmd = "Neoconf" },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
        dependencies = {
            "HiPhish/rainbow-delimiters.nvim"
        }
    },
    {'akinsho/git-conflict.nvim', version = "*", config = true},
}
