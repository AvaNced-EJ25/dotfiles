return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local function open_tab_silent(node)
            local api = require("nvim-tree.api")

            api.node.open.tab(node)
            vim.cmd.tabprev()
        end

        function find_directory_and_focus()
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")

            local function open_nvim_tree(prompt_bufnr, _)
                actions.select_default:replace(function()
                    local api = require("nvim-tree.api")

                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    api.tree.open()
                    api.tree.find_file(selection.cwd .. "/" .. selection.value)
                end)
                return true
            end

            require("telescope.builtin").find_files({
                find_command = { "fd", "--type", "directory", "--hidden", "--exclude", ".git/*" },
                attach_mappings = open_nvim_tree,
            })
        end

        local function my_on_attach(bufnr)
            local api = require("nvim-tree.api")

            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- default mappings
            api.config.mappings.default_on_attach(bufnr)

            -- custom mappings
            vim.keymap.set('n', '<C-t>',        api.tree.change_root_to_parent,     opts('Up'))
            vim.keymap.set('n', '?',            api.tree.toggle_help,               opts('Help'))
            vim.keymap.set('n', 'T',            open_tab_silent,                    opts('Open Tab Silent'))
            vim.keymap.set("n", "<leader>fd",   find_directory_and_focus,           opts('Find Directories'))
        end

        require("nvim-tree").setup({
            view = {
                side = "left",
                width = 38,
            },
            open_on_tab = true,
            on_attach = my_on_attach,
        })

    end,
}
