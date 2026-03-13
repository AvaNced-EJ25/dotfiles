local C = require("catppuccin.palettes").get_palette()
local transparent_bg=C.mantle

require("catppuccin").setup({
    flavour = "macchiato",
    term_colors = true,
    background = {
        dark = "macchiato",
        light = "latte",
    },
    transparent_background = vim.fn.has('gui_running') == 0 and not vim.g.neovide,
    dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.20,
    },
    integrations = {
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        which_key = true,
        mason = true,
        nvim_surround = true,
        lsp_trouble = true,
        snacks = {
            enabled = true,
            indent_scope_color = 'pink'
        },
        indent_blankline = {
            enabled = true,
            scope_color = "pink",
            colored_indent_levels = true,
        },
        dropbar = {
            enabled = true,
            color_mode = true,
        },
        markview = true,
        -- transparent_bg = opts.transparent_background and "NONE" or C.mantle
        lualine = {
            normal = {
                a = { bg = C.blue, fg = C.mantle, gui = "bold" },
                b = { bg = C.surface0, fg = C.blue },
                c = { bg = transparent_bg, fg = C.text },
            },

            insert = {
                a = { bg = C.green, fg = C.base, gui = "bold" },
                b = { bg = C.surface0, fg = C.green },
            },

            terminal = {
                a = { bg = C.green, fg = C.base, gui = "bold" },
                b = { bg = C.surface0, fg = C.green },
            },

            command = {
                a = { bg = C.peach, fg = C.base, gui = "bold" },
                b = { bg = C.surface0, fg = C.peach },
            },
            visual = {
                a = { bg = C.mauve, fg = C.base, gui = "bold" },
                b = { bg = C.surface0, fg = C.mauve },
            },
            replace = {
                a = { bg = C.red, fg = C.base, gui = "bold" },
                b = { bg = C.surface0, fg = C.red },
            },
            inactive = {
                a = { bg = transparent_bg, fg = C.blue },
                b = { bg = transparent_bg, fg = C.surface1, gui = "bold" },
                c = { bg = transparent_bg, fg = C.overlay0 },
            },
        },
    },
    float = {
        transparent = true,
        solid = false,
    },
})

vim.cmd.colorscheme("catppuccin")
