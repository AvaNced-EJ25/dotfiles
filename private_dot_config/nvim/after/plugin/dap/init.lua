-- Keymaps
local map = vim.keymap
require("nvim-dap-virtual-text").setup({})

map.set('n', '<F5>', function() require('dap').continue() end, {desc="[DAP] Continue"})
map.set('n', '<F10>', function() require('dap').step_over() end, {desc="[DAP] Step Over"})
map.set('n', '<F11>', function() require('dap').step_into() end, {desc="[DAP] Step Into"})
map.set('n', '<F12>', function() require('dap').step_out() end, {desc="[DAP] Step Out"})
map.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end, {desc="[DAP] Toggle Breakpoint"})
map.set('n', '<Leader>B', function() require('dap').set_breakpoint() end, {desc="[DAP] Set Breakpoint"})

map.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
    {desc="[DAP] Set Breakpoint with Log"})

map.set('n', '<Leader>dr', function() require('dap').repl.open() end, {desc="[DAP] Open REPL / Debug Console"})
map.set('n', '<Leader>dl', function() require('dap').run_last() end, {desc="[DAP] Run Last"})
map.set({'n', 'v'}, '<Leader>dh', function() require('dap.ui.widgets').hover() end, {desc="[DAP] Hover"})
map.set({'n', 'v'}, '<Leader>dp', function() require('dap.ui.widgets').preview() end, {desc="[DAP] Preview"})

map.set('n', '<Leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
end, {desc="[DAP] View Frames"})

map.set('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end, {desc="[DAP] View Scope"})

map.set('n', '<Leader>dc', function() require('dapui').close() end, {desc="[DAP] Close Debug UI"})
