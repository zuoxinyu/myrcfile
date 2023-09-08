local M = {}

function M.run_debug()
    require 'dap.ext.vscode'.load_launchjs()
    require 'dapui'.open()
    require 'dap'.continue()
end

function M.setup_dap()
    local dap = require 'dap'
    local home = os.getenv('HOME') or (os.getenv('HOMEDRIVE') .. os.getenv('HOMEPATH'))
    -- TODO: find version
    local vscode_ext = home .. '/.vscode/extensions'
    local function input_file()
        return vim.fn.input('Exe: ', vim.fn.getcwd() .. '/', 'file')
    end
    local function input_args()
        return vim.fn.split(vim.fn.input('Args: '), ' ')
    end

    dap.defaults.fallback.terminal_win_cmd = '50vsplit new'

    dap.adapters.lldb = {
        id = 'lldb-vscode',
        name = 'lldb-vscode',
        type = 'executable',
        command = 'C:/Program Files/LLVM/bin/lldb-vscode.exe',
        -- options = { detached = false },
        -- console = 'integratedTerminal',
    }
    dap.adapters.cppdbg = {
        id = 'cppdbg',
        name = 'cppdbg',
        type = 'executable',
        command = vscode_ext .. '/ms-vscode.cpptools-1.17.5-win32-x64/debugAdapters/bin/OpenDebugAD7.exe',
        -- options = { detached = false },
        -- console = 'integratedTerminal',
    }
    dap.adapters.cppvsdbg = {
        id = 'cppvsdbg',
        name = 'cppvsdbg',
        type = 'executable',
        command = vscode_ext .. '/ms-vscode.cpptools-1.17.3-win32-x64/debugAdapters/vsdbg/bin/vsdbg.exe',
        args = { '--interpreter=vscode' },
        -- options = { detached = false },
        -- console = 'integratedTerminal',
    }
    dap.adapters.cpp = {
        id = 'codelldb',
        name = 'codelldb',
        type = 'server',
        port = '${port}',
        executable = {
            command = vscode_ext .. '/vadimcn.vscode-lldb-1.9.2/adapter/codelldb.exe',
            args = { '--port', '${port}' },
        },
        -- console = 'integratedTerminal',
    }

    dap.configurations.cpp = {
        {
            name = 'launch file (lldb-vscode)',
            type = 'lldb',
            request = 'launch',
            program = input_file,
            args = input_args,
            cwd = '${fileDirname}',
            stopAtEntry = false,
        },
        {
            name = 'launch file (cpptools)',
            type = 'cppdbg',
            request = 'launch',
            linux = { MIMode = 'gdb' },
            osx = { MIMode = 'lldb' },
            windows = { MIMode = 'lldb', miDebuggerPath = 'C:/Program Files/LLVM/bin/lldb.exe' },
            program = input_file,
            args = input_args,
            cwd = '${fileDirname}',
            stopOnEntry = false,
        },
        {
            name = 'launch file (codelldb)',
            type = 'cpp',
            request = 'launch',
            program = input_file,
            args = input_args,
            cwd = '${fileDirname}',
            stopOnEntry = false,
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
                if keymap.lhs == '<C-k>' then
                    table.insert(keymap_restore, keymap)
                    api.nvim_buf_del_keymap(buf, 'n', '<C-k>')
                end
            end
        end
        api.nvim_set_keymap('n', '<C-k>', '', {
            silent = true,
            callback = require('dap.ui.widgets').hover,
        })
    end

    dap.listeners.after['event_terminated']['me'] = function()
        for _, keymap in pairs(keymap_restore) do
            api.nvim_buf_set_keymap(keymap.buffer, keymap.mode, keymap.lhs, keymap.rhs,
                { silent = keymap.silent == 1 })
        end
        keymap_restore = {}
    end
end

function M.setup_dap_ui()
    require 'dapui'.setup()
end

return M
