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

function os.file_exists(file)
    if file == nil then
        return false
    end
    local f = io.open(file, 'rb')
    if f then io.close(f) end
    return f ~= nil
end

function os.read_lines(file)
    if not os.file_exists(file) then return {} end
    local lines = {}
    for line in io.lines(file) do
        lines[#lines+1] = line
    end
    return lines
end

if os.type() == "UNIX" then
    NODE_PATH = ""
    if os.getenv("HOMEBREW_PREFIX") ~= nil then
        NODE_PATH = os.getenv("HOMEBREW_PREFIX") .. "/bin/neovim-node-host"
    end
    if not os.file_exists(NODE_PATH) then
        local nvm_dir = os.getenv("HOME") .. '/.nvm'
        local lines = os.read_lines(nvm_dir .. '/alias/default')
        local version = nil

        if #lines > 0 then
            version = lines[#lines]
        end

        if version and string.find(version, "^v%d+%.[0-9%.]*$") == nil then
            lines = os.read_lines(nvm_dir .. '/alias/' .. version)
            if #lines > 0 then
                version = lines[#lines]
            end
        end

        if version and string.find(version, "^v%d+%.[0-9%.]*$") ~= nil then
            NODE_PATH = nvm_dir .. '/versions/node/' .. version .. '/bin/neovim-node-host'
        end
    end

    -- if not os.file_exists(NODE_PATH) then NODE_PATH="" end
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

