return {
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'L3MON4D3/LuaSnip'},

    {
        'williamboman/mason.nvim',
        config = function() MASON_PATH = os.getenv("HOME") .. "/.local/share/nvim/mason"end,
    },
    {'williamboman/mason-lspconfig.nvim'},
    {
        'mrded/nvim-lsp-notify',
        dependencies = { 'rcarriga/nvim-notify' },
    }
}
