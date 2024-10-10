local clrs = require("catppuccin.palettes").get_palette()
local rainbow_delimiters = require("rainbow-delimiters")
local hooks = require("ibl.hooks")

local highlight = {
    "CatppuccinFlamingo",
    "CatppuccinTeal",
    "CatppuccinMauve",
    "CatppuccinSapphire",
    "CatppuccinRed",
    "CatppuccinYellow",
    "CatppuccinRosewater",
    "CatppuccinBlue",
    "CatppuccinMaroon",
    "CatppuccinPeach",
    "CatppuccinSky",
    "CatppuccinGreen",
    "CatppuccinPink",
    "CatppuccinLavender",
}

-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "CatppuccinRosewater", { fg = clrs.rosewater })
    vim.api.nvim_set_hl(0, "CatppuccinFlamingo", { fg = clrs.flamingo })
    vim.api.nvim_set_hl(0, "CatppuccinPink", { fg = clrs.pink })
    vim.api.nvim_set_hl(0, "CatppuccinMauve", { fg = clrs.mauve })
    vim.api.nvim_set_hl(0, "CatppuccinRed", { fg = clrs.red })
    vim.api.nvim_set_hl(0, "CatppuccinMaroon", { fg = clrs.maroon })
    vim.api.nvim_set_hl(0, "CatppuccinPeach", { fg = clrs.peach })
    vim.api.nvim_set_hl(0, "CatppuccinYellow", { fg = clrs.yellow })
    vim.api.nvim_set_hl(0, "CatppuccinGreen", { fg = clrs.green })
    vim.api.nvim_set_hl(0, "CatppuccinTeal", { fg = clrs.teal })
    vim.api.nvim_set_hl(0, "CatppuccinSky", { fg = clrs.sky })
    vim.api.nvim_set_hl(0, "CatppuccinSapphire", { fg = clrs.sapphire })
    vim.api.nvim_set_hl(0, "CatppuccinBlue", { fg = clrs.blue })
    vim.api.nvim_set_hl(0, "CatppuccinLavender", { fg = clrs.lavender })
end)


---@type rainbow_delimiters.config
vim.g.rainbow_delimiters = {
    strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
    },
    query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
    },
    priority = {
        [''] = 110,
        lua = 210,
    },
    highlight = highlight,
}

require("ibl").setup({
    indent = {
        highlight = highlight,
        smart_indent_cap = true,
    },
    whitespace = {
        highlight = "NonText",
        remove_blankline_trail = false,
    },
    scope = {
        enabled = true,
    },
})

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
