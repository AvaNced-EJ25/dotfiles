require("catppuccin").setup({
    flavour = "macchiato",
    term_colors = true,
    transparent_background = true,
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
        indent_blankline = {
            enabled = true,
            scope_color = "sapphire",
            colored_indent_levels = true,
        },
        dropbar = {
            enabled = true,
            color_mode = true,
        },
    },
})

vim.cmd.colorscheme "catppuccin"

