local dap, dapui, telescope = require("dap"), require("dapui"), require("telescope")

require("dap.ext.vscode").load_launchjs(nil)

dapui.setup()

telescope.load_extension("dap")

if os.name() == "Linux" then
    dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = os.getenv("HOME") .. '/.local/lib/cppdbg/debugAdapters/bin/OpenDebugAD7',
    }
elseif os.name() == "Windows" then
    dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = os.getenv("HOME") .. '\\.local\\lib\\cppdbg\\debugAdapters\\bin\\OpenDebugAD7.exe',
        options = {
            detached = false
        }
    }
end

dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
        setupCommands = {
            {
                text = '-enable-pretty-printing',
                description =  'enable pretty printing',
                ignoreFailures = false
            },
        },
    },
    {
        name = "Launch file with args",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        args = function()
            local arg_table={}
            local str_args = vim.fn.input('Args: ')
            for arg in str_args:gmatch("%w+") do
                table.insert(arg_table,arg)
            end
            print(dump_table(arg_table))
            return arg_table
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
        setupCommands = {
            {
                text = '-enable-pretty-printing',
                description =  'enable pretty printing',
                ignoreFailures = false
            },
        },
    },
    {
        name = 'Attach to gdbserver :69420',
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerServerAddress = 'localhost:69420',
        miDebuggerPath = '/usr/bin/gdb',
        cwd = '${workspaceFolder}',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
    },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
