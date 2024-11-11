return {
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
    { -- optional completion source for require statements and module annotations
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {
                name = "lazydev",
                group_index = 0, -- set group index to 0 to skip loading LuaLS completions
            })
        end,
    },
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
    { 'mbbill/undotree' },
    { 'tpope/vim-fugitive' },
    { 'uga-rosa/ccc.nvim' },
}
