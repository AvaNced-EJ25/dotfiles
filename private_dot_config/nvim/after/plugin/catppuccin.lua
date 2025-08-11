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
    auto_integrations = true,
    -- integrations = {
    --     gitsigns = true,
    --     nvimtree = true,
    --     treesitter = true,
    --     which_key = true,
    --     mason = true,
    --     nvim_surround = true,
    --     lsp_trouble = true,
    --     snacks = {
    --         enabled = true,
    --         indent_scope_color = 'pink'
    --     },
    --     indent_blankline = {
    --         enabled = true,
    --         scope_color = "pink",
    --         colored_indent_levels = true,
    --     },
    --     dropbar = {
    --         enabled = true,
    --         color_mode = true,
    --     },
    -- },
})

vim.cmd.colorscheme("catppuccin")
