return {
    'freddiehaddad/feline.nvim',
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {},
    config = function(_, opts)

        -- clrs:
        -- rosewater, flamingo, pink, mauve, red, maroon, peach, yellow, green, teal, sky, sapphire, blue, lavender
        -- text, subtext1, subtext0, overlay2, overlay1, overlay0, surface2, surface1, surface0, base, mantle, crust
        local clrs = require("catppuccin.palettes").get_palette()
        local ctp_feline = require('catppuccin.groups.integrations.feline')
        local U = require("catppuccin.utils.colors")

        local function is_enabled(min_width)
            if shortline then return true end

            return vim.api.nvim_win_get_width(0) > min_width
        end


        local macchiato = require("catppuccin.palettes").get_palette("macchiato")
        local icons = {
            dos = "", -- e70f
            unix = "", -- f17c
            mac = "", -- f179
        }

        local sett = {
            text = U.vary_color({ macchiato = macchiato.base }, clrs.surface0),
            bkg = U.vary_color({ macchiato = macchiato.crust }, clrs.surface0),
            encoding = clrs.mauve,
            curr_file = clrs.maroon,
            curr_dir = clrs.flamingo,
            diffs = clrs.mauve,
            extras = clrs.overlay1,
            show_modified = true -- show if the file has been modified
        }

        local assets = {
            left_separator = "",
            right_separator = "",
            mode_icon = ":3 󱢇",
            dir = "󰉖",
            file = "󰈙",
            lsp = {
                server = "󰅡",
                error = "",
                warning = "",
                info = "",
                hint = "",
            },
            git = {
                branch = "",
                added = "",
                changed = "",
                removed = "",
            },
        }

        ctp_feline.setup({
            assets = assets,
            sett = sett,
            mode_colors = {
                ["n"] = { "NORMAL", clrs.lavender },
                ["no"] = { "N-PENDING", clrs.lavender },
                ["i"] = { "INSERT", clrs.green },
                ["ic"] = { "INSERT", clrs.green },
                ["t"] = { "TERMINAL", clrs.green },
                ["v"] = { "VISUAL", clrs.flamingo },
                ["V"] = { "V-LINE", clrs.flamingo },
                ["�"] = { "V-BLOCK", clrs.flamingo },
                ["R"] = { "REPLACE", clrs.maroon },
                ["Rv"] = { "V-REPLACE", clrs.maroon },
                ["s"] = { "SELECT", clrs.maroon },
                ["S"] = { "S-LINE", clrs.maroon },
                ["�"] = { "S-BLOCK", clrs.maroon },
                ["c"] = { "COMMAND", clrs.peach },
                ["cv"] = { "COMMAND", clrs.peach },
                ["ce"] = { "COMMAND", clrs.peach },
                ["r"] = { "PROMPT", clrs.teal },
                ["rm"] = { "MORE", clrs.teal },
                ["r?"] = { "CONFIRM", clrs.mauve },
                ["!"] = { "SHELL", clrs.green },
            },
            view = {
                lsp = {
                    progress = true, -- if true the status bar will display an lsp progress indicator
                    name = false, -- if true the status bar will display the lsp servers name, otherwise it will display the text "Lsp"
                    exclude_lsp_names = {}, -- lsp server names that should not be displayed when name is set to true
                    separator = "|", -- the separator used when there are multiple lsp servers
                },
            }
        })

        local comp = ctp_feline.get()

        -- Active
        comp.active[1][2].short_provider = function() return string.upper(vim.fn.mode() .. " ")end
        comp.active[1][2].priority = 100

        comp.active[1][13].enabled = is_enabled(2)

        comp.active[3][1].truncate_hide = true
        comp.active[3][1].short_provider = function()
            local pattern = "%u*%-%d*"
            -- print(string.match(vim.b.gitsigns_head, pattern))

            return (string.match(vim.b.gitsigns_head or '', pattern)) or ''
        end
        comp.active[3][1].priority = 4

        comp.active[3][3] = {
            provider = function()
                local filename = vim.fn.expand "%:t"
                local extension = vim.fn.expand "%:e"
                local buf_num = "[" .. vim.call("bufnr", "%") .. "]"
                local present, devicons = pcall(require, "nvim-web-devicons")
                local icon = present and devicons.get_icon(filename, extension) or assets.file
                return (sett.show_modified and "%m" or "") .. " " .. icon .. " " .. filename .. " " .. buf_num .. " "
            end,
            enabled = is_enabled(70),
            hl = {
                fg = sett.text,
                bg = sett.curr_file,
            },
            left_sep = {
                str = assets.left_separator,
                hl = {
                    fg = sett.curr_file,
                    bg = sett.bkg,
                },
            },
        }

        table.insert(comp.active[3], 4, {
            provider = function()
                local os = icons[vim.bo.fileformat] or ""
                return string.format(" %s %s ", os, vim.bo.fileencoding)
            end,
            enabled = is_enabled(80),
            truncate_hide = true,
            hl = {
                fg = sett.text,
                bg = sett.encoding
            },
            left_sep = {
                str = assets.left_separator,
                hl = {
                    fg = sett.encoding,
                    bg = sett.curr_file
                },
            }
        })

        comp.active[3][5].left_sep.hl.bg = sett.encoding

        -- Inactive
        comp.inactive[1][1] = comp.active[3][3]

        table.insert(comp.inactive, {})
        table.insert(comp.inactive[2], {
            provider = function()
                local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
                return " " .. assets.dir .. " " .. dir_name .. " "
            end,
            enabled = is_enabled(30),
            hl = {
                fg = sett.text,
                bg = sett.curr_dir,
            },
            left_sep = {
                str = assets.left_separator,
                hl = {
                    fg = sett.curr_dir,
                    bg = sett.curr_file,
                },
            },
        })

        -- print(dump(comp))

        -- local f = io.open("~/feline_table.json", "w")
        -- f:write(dump(comp))
        -- f:close()

        require("feline").setup({
            components = comp,
            -- components = ctp_feline.get()
        })

    end
}
