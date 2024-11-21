return {
    'vyfor/cord.nvim',
    build = './build || .\\build',
    event = 'VeryLazy',
    opts = {}, -- calls require('cord').setup()
    config = function()
        if not vim.g.vscode then
            -- TODO: Custom icons using catppuccin
            -- https://github.com/catppuccin/vscord/tree/main
            -- https://github.com/vyfor/cord.nvim/wiki/Add-or-change-file-icons
            local languages_filenames = {}
            local assets = {}
            require("cord").setup({
            })
        end
    end,
}
