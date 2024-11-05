
-- fold settings
vim.wo.foldenable = false
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
vim.wo.fillchars = "fold:\\"
vim.wo.foldnestmax = 3
vim.wo.foldminlines = 1

vim.g.lazygit_floating_window_use_plenary = 1
vim.g.lazygit_use_custom_config_file_path = 1

-- transparency of floating window (10 in neovide, 0 otherwise)
vim.g.lazygit_floating_window_winblend = ( vim.g.neovide and 10 or 0 )

vim.g.lazygit_config_file_path = {
    (os.getenv("HOME") .. "/.config/lazygit/config.yml"),
    (os.getenv("HOME") .. "/.config/lazygit/pink.yml"),
}

vim.notify = require('notify')
