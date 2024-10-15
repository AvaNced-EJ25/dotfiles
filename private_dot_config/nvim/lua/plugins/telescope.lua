return {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim', build = 'make'
        },
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ['<C-k>'] = actions.move_selection_previous,
                        ['<C-j>'] = actions.move_selection_next,
                        ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
                    }
                }
            },
        })

        telescope.load_extension('fzf');

        local keymap = vim.keymap
        local builtin = require('telescope.builtin')

        keymap.set('n', '<leader>ff', builtin.find_files, {desc = "Fuzzy find files in cwd" })
        keymap.set('n', '<leader>fr', builtin.oldfiles, {desc = "Fuzzy find recent files" })
        keymap.set('n', '<leader>fs', builtin.live_grep, {desc = "Find string in cwd" })
        keymap.set('n', '<leader>fb', builtin.buffers, {desc = "Find buffers" })
        keymap.set('n', '<leader>fh', builtin.help_tags, {desc = "Find help" })
        keymap.set('n', '<leader>fc', builtin.grep_string, {desc = "Find string under cursor in cwd" })
        keymap.set('n', '<leader>fg', builtin.git_files, {desc = "Find git files" })
        keymap.set('n', '<leader>fm', builtin.marks, {desc = "Find marks" })
        keymap.set('n', '<leader>fl', builtin.man_pages, {desc = "Find man pages" })
    end
}
