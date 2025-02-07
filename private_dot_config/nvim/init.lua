local BinaryFormat = package.cpath:match("%p[\\|/]?%p(%a+)")
if BinaryFormat == "dll" then
    function os.name()
        return "Windows"
    end
elseif BinaryFormat == "so" then
    function os.name()
        return "Linux"
    end
elseif BinaryFormat == "dylib" then
    function os.name()
        return "MacOS"
    end
end
BinaryFormat = nil

PYTHON3_PATH = os.getenv("HOME") .. "/.pyenv/versions/neovim/bin/python"
PYTHON2_PATH = os.getenv("HOME") .. "/.pyenv/versions/neovim2/bin/python"
NODE_PATH = os.getenv("HOME") .. "/.nvm/versions/node/v22.11.0/bin/neovim-node-host"

-- Helper function for transparency formatting
-- local alpha = function()
--   return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
-- end

-- Dump table
function dump_table(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            s = s .. '['..k..'] = ' .. dump_table(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

function file_exists(filename)
    local file_obj = io.open(filename, 'r')
    if file_obj ~= nil then
        io.close(file_obj)
        return true
    else
        return false
    end
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.

    install = {
        missing = true,
    },
    -- automatically check for plugin updates
    checker = {
        enabled = true,
    },
    rtp = {
        disabled_plugins = {
            "gzip",
            "matchit",
            "matchparen",

            "netrwPlugin",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zipPlugin",
        },
    }
})

require("koman")

