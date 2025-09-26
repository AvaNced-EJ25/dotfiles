local BinaryFormat = package.cpath:match("%p[\\|/]?%p(%a+)")
if BinaryFormat == "dll" then
    function os.name() return "Windows" end
    function os.type() return "NT" end
elseif BinaryFormat == "so" then
    function os.name() return "Linux" end
    function os.type() return "UNIX" end
elseif BinaryFormat == "dylib" then
    function os.name() return "MacOS" end
    function os.type() return "UNIX" end
else
    function os.name() return "Unknown" end
    function os.type() return "Unknown" end
end
BinaryFormat = nil

function os.file_exists(filename)
    local file_obj = io.open(filename, 'r')
    if file_obj ~= nil then
        io.close(file_obj)
        return true
    else
        return false
    end
end

if os.type() == "UNIX" then
    NODE_PATH = os.getenv("HOMEBREW_PREFIX") .. "/bin/neovim-node-host"
    if not os.file_exists(NODE_PATH) then
        NODE_PATH = os.execute('find ' .. os.getenv("HOME") .. '/.nvm/versions/node -name neovim-node-host')
    end
elseif os.type() == "NT" then
    NODE_PATH = os.getenv("HOME") .. "/scoop/persist/nvm/nodejs/nodejs/neovim-node-host"
end

-- Helper function for transparency formatting
-- local alpha = function()
--   return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
-- end

-- Dump table
function os.dump_table(o)
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

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
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
    install = {
        missing = true,
        colorscheme = { "catppuccin" },
    },
    -- automatically check for plugin updates
    rtp = {
        disabled_plugins = {
            "netrwPlugin",
            "tohtml",
            "tutor",
        },
    }
})

require("koman")

