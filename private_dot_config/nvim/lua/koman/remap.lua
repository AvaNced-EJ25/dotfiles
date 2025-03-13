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
local keymap = vim.keymap

keymap.set('n', '<leader>nh', '<cmd>:noh<cr>', { desc = 'No Highlight Search' })

keymap.set('n', '<leader>sc', function() vim_opt_toggle("cursorcolumn", true, false, "Cursor Column") end,
    { desc = 'Toggle Cursor Column' })

keymap.set('n', '<leader>wd', function()
    local col = vim.o.columns - 4
    vim.cmd("w !difft --width " .. col .. " --syntax-highlight off % - ")
end, { desc = 'View File Diff' })

keymap.set('n', '<leader>ww', "<cmd>w<cr>", { silent = true })
keymap.set('n', '<leader>wq', "<cmd>wq<cr>", { silent = true })

keymap.set('n', '<leader>qq', "<cmd>q<cr>", { desc = "Quit Buffer" })
keymap.set('n', '<leader>qa', "<cmd>qall<cr>", { desc = "Quit All Buffers" })

keymap.set('n', '<leader>fe', tree_api.tree.toggle, { desc = 'Toggle Nvim Tree' })

keymap.set('i', '<C-d>', '<Esc>', { desc = "Enter normal mode" })
keymap.set({'n', 'v'}, '<leader>D', '"_d', { silent = true, nowait = true, desc = "Yeet into the black hole" })
