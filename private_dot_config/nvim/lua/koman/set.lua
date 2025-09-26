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

vim.opt.foldcolumn = '1' -- '0' is not bad
vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim.undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt_global.visualbell = true

vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.o.guifont = "JetBrainsMono Nerd Font:h14"
vim.o.timeout = true
vim.o.timeoutlen = 3000

vim.cmd.colorscheme "catppuccin-macchiato"

-- If diff
if vim.opt.diff:get() then
    vim.o.diffopt = "internal,filler,closeoff,linematch:10,context:20"
end

-- If neovide session
if vim.g.neovide then
    vim.g.neovide_opacity = 0.95
    vim.g.neovide_cursor_animation_length = 0.13
    vim.g.neovide_cursor_trail_size = 0.5
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_padding_top=8
    vim.g.neovide_padding_left=8
    vim.g.neovide_padding_right=8
    vim.g.neovide_padding_bottom=8
end

local fzf_path = ""

if os.type() == "UNIX" then
    fzf_path = os.getenv("HOMEBREW_PREFIX") .. "/bin/fzf"
elseif os.name() == "Windows" then
    fzf_path = os.getenv("HOME") .. "\\scoop\\apps\\fzf\\current"
end

if (os.file_exists(fzf_path)) then
    vim.opt.rtp:append(fzf_path)
end

if os.file_exists(NODE_PATH) then
    vim.g.node_host_prog = NODE_PATH
end

vim.opt.titlelen = 70
vim.opt.title = true

vim.api.nvim_create_autocmd({'BufEnter'}, {
    callback = function()
        vim.opt.titlestring = "%t%( %M%)%( (%{expand(\"%:~:.:h\")})%)%( %a%)"
    end
})

vim.api.nvim_create_user_command('DiffOrig', function()
    local scratch_buffer = vim.api.nvim_create_buf(false, true)
    local current_ft = vim.bo.filetype
    vim.cmd('vertical sbuffer' .. scratch_buffer)
    vim.bo[scratch_buffer].filetype = current_ft
    vim.cmd('read ++edit #') -- load contents of previous buffer into scratch_buffer
    vim.cmd.normal('1G"_d_') -- delete extra newline at top of scratch_buffer without overriding register
    vim.cmd.diffthis() -- scratch_buffer
    vim.cmd.wincmd('p')
    vim.cmd.diffthis() -- current buffer
end, {})
