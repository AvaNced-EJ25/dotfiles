vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.showmode = false

vim.opt.wrap = false
vim.opt.list = true
vim.opt.listchars = "tab:󰌒∙,leadmultispace: :,multispace:∙,precedes:󰅁,extends:󰅂,nbsp:∙,trail:"
vim.opt.cursorline = true
vim.opt.showbreak = "󰌑"
vim.opt.colorcolumn = "120"

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 2

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim.undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.o.guifont = "JetBrainsMono Nerd Font:h10"
vim.o.timeout = true
vim.o.timeoutlen = 3000

vim.cmd.colorscheme "catppuccin-macchiato"

-- If diff
if vim.opt.diff:get() then
    vim.o.diffopt = "internal,filler,closeoff,linematch:10,context:20"
end

-- If neovide session
if vim.g.neovide then
    vim.g.neovide_transparency = 0.97
    vim.g.neovide_cursor_animation_length = 0.13
    vim.g.neovide_cursor_trail_size = 0.5
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_padding_top=8
    vim.g.neovide_padding_left=8
    vim.g.neovide_padding_right=8
    vim.g.neovide_padding_bottom=8
end

local fzf_path = ""

if os.name() == "Linux" then
    fzf_path = "/home/linuxbrew/.linuxbrew/opt/fzf"
elseif os.name() == "MacOS" then
    fzf_path = "/opt/homebrew/bin/fzf"
elseif os.name() == "Windows" then
    fzf_path = vim.env("HOME") .. "\\scoop\\apps\\fzf\\current"
end

if (file_exists(fzf_path)) then
    vim.opt.rtp:append(fzf_path)
end

if file_exists(PYTHON3_PATH) then
    vim.g.python3_host_prog = PYTHON3_PATH
end

if file_exists(PYTHON2_PATH) then
    vim.g.python_host_prog = PYTHON2_PATH
end

if file_exists(NODE_PATH) then
    vim.g.node_host_prog = NODE_PATH
end

vim.opt.titlelen = 70
vim.opt.title = true

vim.api.nvim_create_autocmd({'BufEnter'}, {
    callback = function()
        vim.opt.titlestring = "%t%( %M%)%( (%{expand(\"%:~:.:h\")})%)%( %a%)"
    end
})
