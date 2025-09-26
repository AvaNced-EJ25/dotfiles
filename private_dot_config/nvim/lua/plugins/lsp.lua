return {
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'L3MON4D3/LuaSnip'},

    {
        'williamboman/mason.nvim',
        config = function()
            if os.name() == "Linux" then
                MASON_PATH = os.getenv("HOME") .. "/.local/share/nvim/mason"
            elseif os.name() == "Windows" then
                MASON_PATH = os.getenv("LOCALAPPDATA") .. "\\nvim-data\\mason"
            end
            if not os.file_exists(MASON_PATH) then
                MASON_PATH = ""
            end
        end,
    },
    {'williamboman/mason-lspconfig.nvim'},
    {'mfussenegger/nvim-lint'}
}
