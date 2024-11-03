local builtin = require('telescope.builtin')
local telescope = require('telescope')
local keymap = vim.keymap

telescope.load_extension("chezmoi")

keymap.set('n', '<C-p>', builtin.git_files, {})
keymap.set('n', '<leader>cz', telescope.extensions.chezmoi.find_files, { desc = "Search dotfiles" })
