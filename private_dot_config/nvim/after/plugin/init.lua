local keymap = vim.keymap
-- fold settings
vim.wo.foldenable = false
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
vim.wo.fillchars = "fold:\\"
vim.wo.foldnestmax = 3
vim.wo.foldminlines = 1

local ccc = require("ccc")
local mapping = ccc.mapping

local clrs = require("catppuccin.palettes").get_palette()

custom_colors = {
    ctpRosewater = clrs.rosewater,
    ctpFlamingo = clrs.flamingo,
    ctpPink = clrs.pink,
    ctpMauve = clrs.mauve,
    ctpRed = clrs.red,
    ctpMaroon = clrs.maroon,
    ctpPeach = clrs.peach,
    ctpYellow = clrs.yellow,
    ctpGreen = clrs.green,
    ctpTeal = clrs.teal,
    ctpSky = clrs.sky,
    ctpSapphire = clrs.sapphire,
    ctpBlue = clrs.blue,
    ctpLavender = clrs.lavender,
    ctpMantle = clrs.mantle,
    ctpSubtext0 = clrs.subtext0,
    ctpSubtext1 = clrs.subtext1,
    ctpSurface0 = clrs.surface0,
    ctpSurface1 = clrs.surface1,
    ctpSurface2 = clrs.surface2,
    ctpOverlay0 = clrs.overlay0,
    ctpOverlay1 = clrs.overlay1,
    ctpOverlay2 = clrs.overlay2,
    ctpBase = clrs.base,
    ctpText = clrs.text,
    ctpCrust = clrs.crust,
}

ccc.setup({
    -- Your preferred settings
    -- Example: enable highlighter
    highlighter = {
        auto_enable = true,
        lsp = true,
    },
    pickers = { ccc.picker.custom_entries(custom_colors) },
    mappings = mapping,
})

keymap.set('n', '<leader>cc', '<cmd>:CccPick<cr>', {desc = "Choose Color"})

keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
