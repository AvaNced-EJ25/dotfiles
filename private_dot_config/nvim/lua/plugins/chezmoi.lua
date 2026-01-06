return {
    'xvzc/chezmoi.nvim',
    dependencies = {
        'folke/snacks.nvim',
        {
            'alker0/chezmoi.vim',
            lazy = false,
            init = function()
                -- This option is required.
                vim.g['chezmoi#use_tmp_buffer'] = true
                -- add other options here if needed.
            end,
        }
    },
    config = function()
        require("chezmoi").setup({
            -- your configurations
            edit = {
                watch = true,
            },
            notification = {
                on_open = true,
                on_apply = true,
                on_watch = true,
            },
        })
    end
}
