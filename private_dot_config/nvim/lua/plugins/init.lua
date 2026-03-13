---@module 'lazy'
---@type LazySpec
return {
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("lualine").setup({
                extensions = { "fzf", "lazy", "man", "mason", "nvim-dap-ui", "trouble" }
            });
        end
    },
    {
        'akinsho/bufferline.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        after = "catppuccin",
        config = function()
            local bufferline = require("bufferline")
            bufferline.setup({
                highlights = require("catppuccin.special.bufferline").get_theme(),
                options = {
                    mode = "tabs",
                    diagnostics = "nvim_lsp",
                    separator_style = "padded_slant",
                    style_preset = bufferline.style_preset.default,
                    offsets = {
                        {
                            filetype = "snacks_layout_box",
                            text = "Snacks Explorer" ,
                            text_align = "center",
                            separator = true
                        }
                    },
                    hover = {
                        enabled = true,
                        delay = 200,
                        reveal = {'close'}
                    }
                }
            })
        end
    },
    { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
    { -- optional completion source for require statements and module annotations
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {
                name = "lazydev",
                group_index = 0, -- set group index to 0 to skip loading LuaLS completions
            })
        end,
    },
    {'akinsho/git-conflict.nvim', version = "*", config = true},
    { 'mbbill/undotree' },
    { 'uga-rosa/ccc.nvim' },
    { "fladson/vim-kitty", ft = "kitty" },
    {
        "catgoose/nvim-colorizer.lua",
        event = "BufReadPre",
        opts = { -- set to setup table
        },
    },
    { 'kevinhwang91/nvim-ufo', dependencies = {'kevinhwang91/promise-async'} },
    { 'equalsraf/neovim-gui-shim' },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        -- install with yarn or npm
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        opts = {
            preview = {
                icon_provider = "devicons", -- "internal" or "mini" or "devicons"
            },
            markdown = {
                enable = true
            },
            markdown_inline = {
                enable = true
            },
            yaml = {
                enable = true
            }
        }
        -- Completion for `blink.cmp`
        -- dependencies = { "saghen/blink.cmp" },
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        opts = {},
    },
    { 'Bekaboo/dropbar.nvim' }
}
