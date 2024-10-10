local function vim_opt_toggle(opt, on, off, name)
    local message = name
    if vim.opt[opt]:get() == off then
        vim.opt[opt] = on
        message = message .. " Enabled"
    else
        vim.opt[opt] = off
        message = message .. " Disabled"
    end
    vim.notify(message)
end

local tree_api = require("nvim-tree.api")
-- local tele_api = require("telescope.builtin")

vim.keymap.set('n', '<leader>nh', '<cmd>:noh<cr>', {desc = 'No Highlight Search'})

vim.keymap.set('n', '<leader>sc', function() vim_opt_toggle("cursorcolumn", true, false, "Cursor Column")end, {desc = 'Toggle Cursor Column'})
-- vim.keymap.set('n', '<leader>sv', '<cmd>:vsplit<cr><c-w>l', {desc = 'Vertical Split'})
-- vim.keymap.set('n', '<leader>sx', '<cmd>:split<cr><c-w>j', {desc = 'Horizontal Split'})

vim.keymap.set('n', '<leader>wd', '<cmd>:w !diff % - <cr>', {desc = 'View File Diff'})
vim.keymap.set('n', '<leader>ww', "<cmd>w<cr>", { silent = true})
vim.keymap.set('n', '<leader>wq', "<cmd>wq<cr>", { silent = true})

vim.keymap.set('n', '<leader>qq', "<cmd>q<cr>", {desc = "Quit Buffer"})
vim.keymap.set('n', '<leader>qa', "<cmd>qall<cr>", {desc = "Quit All Buffers"})

vim.keymap.set('n', '<leader>fe', tree_api.tree.toggle, {desc = 'Toggle Nvim Tree'})
