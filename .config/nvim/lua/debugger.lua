local M = {}

function M.load_json()
    require 'dap.ext.vscode'.load_launchjs()
    require 'dapui'.toggle()
end

function M.setup_dap()
    local home = os.getenv('HOME') or (os.getenv('HOMEDRIVE') .. os.getenv('HOMEPATH'))
    local vscode_ext = 'C:/Users/Admin' .. '/.vscode/extensions'
    local dap = require 'dap'
    dap.adapters.lldb = {
        name = 'lldb',
        type = 'executable',
        command = 'C:/Program Files/LLVM/bin/lldb-vscode.exe', -- adjust as needed, must be absolute path
    }
    dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = vscode_ext .. '/ms-vscode.cpptools-1.17.5-win32-x64/debugAdapters/bin/OpenDebugAD7.exe',
        options = { detached = false },
    }
    dap.adapters.cppvsdbg = {
        id = 'cppvsdbg',
        type = 'executable',
        command = vscode_ext .. '/ms-vscode.cpptools-1.17.3-win32-x64/debugAdapters/vsdbg/bin/vsdbg.exe',
        args = { '--interpreter=vscode' },
        options = { detached = false },
    }
    dap.configurations.cpp = {
        {
            name = "Launch file",
            type = "cppdbg",
            request = "launch",
            miDebuggerPath = dap.adapters.cppdbg.command,
            program = 'C:/Users/Admin/workspace/smt-aoi/install/smt-aoi/smt-aoi.exe',
            cwd = 'C:/Users/Admin/workspace/smt-aoi/install/smt-aoi/',
            args = { '--env=dev' },
            -- program = function()
            --     return vim.fn.input('Exe: ', vim.fn.getcwd() .. '/', 'file')
            -- end,
            -- cwd = function()
            --     return vim.fn.input('Cwd: ', vim.fn.getcwd() .. '/', 'file')
            -- end,
            stopAtEntry = true,
        },
        {
            name = 'Attach to gdbserver :1234',
            type = 'cppdbg',
            request = 'launch',
            miDebuggerServerAddress = 'localhost:1234',
            miDebuggerPath = '/usr/bin/gdb',
            program = function()
                return vim.fn.input('Exe: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = function()
                return vim.fn.input('Cwd: ', vim.fn.getcwd() .. '/', 'file')
            end,
        },
    }

    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp

    local api = vim.api
    local keymap_restore = {}
    dap.listeners.after['event_initialized']['me'] = function()
        for _, buf in pairs(api.nvim_list_bufs()) do
            local keymaps = api.nvim_buf_get_keymap(buf, 'n')
            for _, keymap in pairs(keymaps) do
                if keymap.lhs == "K" then
                    table.insert(keymap_restore, keymap)
                    api.nvim_buf_del_keymap(buf, 'n', 'K')
                end
            end
        end
        api.nvim_set_keymap(
            'n', 'K', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
    end

    dap.listeners.after['event_terminated']['me'] = function()
        for _, keymap in pairs(keymap_restore) do
            api.nvim_buf_set_keymap(
                keymap.buffer,
                keymap.mode,
                keymap.lhs,
                keymap.rhs,
                { silent = keymap.silent == 1 }
            )
        end
        keymap_restore = {}
    end
end

function M.setup_dap_ui()
    require 'dapui'.setup()
end

return M
