local keymap = vim.keymap

local ccc = require("ccc")
local picker= ccc.picker
local mapping = ccc.mapping

local clrs = require("catppuccin.palettes").get_palette()

local custom_colors = {
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
    pickers = {
        picker.hex,
        picker.css_rgb,
        picker.css_hsl,
        picker.css_hwb,
        picker.css_lab,
        picker.css_lch,
        picker.css_oklab,
        picker.css_oklch,
        picker.custom_entries(custom_colors)
    },
    mappings = mapping,
})

keymap.set('n', '<leader>cc', '<cmd>:CccPick<cr>', {desc = "Choose Color"})
keymap.set({'v', 'o'}, '<leader>cc', '<cmd>:CccPick<cr>', {desc = "Choose Color"})

keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
