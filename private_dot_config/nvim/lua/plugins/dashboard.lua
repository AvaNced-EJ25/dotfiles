return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        require('dashboard').setup({
            theme = 'hyper',
            config = {
                week_header = {
                    enable = true,
                },
                disable_move = true,
                shortcut = {
                    { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
                    {
                        icon = ' ',
                        icon_hl = '@variable',
                        desc = 'Files',
                        group = 'Label',
                        action = 'Telescope find_files',
                        key = 'f',
                    },
                    {
                        desc = ' dotfiles',
                        group = 'Number',
                        action = 'Telescope find_files cwd=' .. os.getenv('HOME') .. '/.dotfiles',
                        key = 'd',
                    },
                },
            },
        })
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'} }
}
