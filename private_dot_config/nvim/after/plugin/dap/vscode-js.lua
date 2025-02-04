dap = require("dap")

dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "node",
        -- 💀 Make sure to update this path to point to your installation
        args = { MASON_PATH .. "/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}"},
    }
}

local js_based_languages = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }
for _, language in ipairs(js_based_languages) do
    dap.configurations[language] = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
            skipFiles = { '<node_internals>/**', 'node_modules/**' },
        },
    }
end

