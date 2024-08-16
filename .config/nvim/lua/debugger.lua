local M = {}

function M.run()
    require('dap.ext.vscode').load_launchjs()
    require('dapui').open()
    require('dap').continue()
end

function M.run_last()
    require('dap').run_last()
end

function M.run_to_cursor()
    require('dap').run_to_cursor()
end

function M.toggle_breakpoint()
    require('dap').toggle_breakpoint()
end

function M.setup_dap()
    -- local mason = require 'mason-registry'
    -- local codelldb = mason.get_package('codelldb')

    local dap = require 'dap'
    local vscode_ext = vim.fn.expand '~/.vscode/extensions'
    local function input_file()
        return vim.fn.input('executable: ', vim.fn.getcwd() .. '/', 'file')
    end
    local function input_args()
        return vim.fn.input 'args: '
    end
    local function input_cwd()
        return vim.fn.input 'cwd: '
    end

    -- dap.defaults.fallback.terminal_win_cmd = '50vsplit new'

    dap.adapters.gdb = {
        type = 'executable',
        command = 'gdb',
        args = { '-i', 'dap' },
    }
    dap.adapters['lldb-dap'] = {
        name = 'lldb-dap',
        type = 'executable',
        command = 'C:/Program Files/LLVM/bin/lldb-vscode.exe',
        -- options = { detached = false },
        -- console = 'integratedTerminal',
    }
    dap.adapters.cppdbg = {
        -- id = 'cppdbg',
        name = 'cppdbg',
        type = 'executable',
        command = vscode_ext .. '/ms-vscode.cpptools-1.19.1-win32-x64/debugAdapters/bin/OpenDebugAD7.exe',
        options = { detached = false },
        -- console = 'integratedTerminal',
    }
    dap.adapters.cppvsdbg = {
        -- id = 'cppvsdbg',
        name = 'cppvsdbg',
        type = 'executable',
        command = vscode_ext .. '/ms-vscode.cpptools-1.19.1-win32-x64/debugAdapters/vsdbg/bin/vsdbg.exe',
        args = { '--interpreter=vscode' },
        -- options = { detached = false },
        -- console = 'integratedTerminal',
    }
    dap.adapters.codelldb = {
        id = 'codelldb',
        name = 'codelldb',
        type = 'server',
        port = '${port}',
        executable = {
            command = vscode_ext .. '/vadimcn.vscode-lldb-1.10.0/adapter/codelldb.exe',
            args = { '--port', '${port}' },
        },
        -- console = 'integratedTerminal',
    }

    dap.configurations.cpp = {
        {
            name = 'launch file (lldb-vscode)',
            type = 'lldb-dap',
            request = 'launch',
            program = input_file,
            args = input_args,
            cwd = input_cwd,
            -- cwd = '${workspaceFolder}',
            -- cwd = '${fileDirname}',
            stopAtEntry = false,
            -- runInTerminal = true,
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
            type = 'codelldb',
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
                    api.nvim_buf_set_keymap(buf, 'n', '<C-k>', '', {
                        silent = true,
                        callback = require('dap.ui.widgets').hover,
                    })
                end
            end
        end
    end

    dap.listeners.after['event_terminated']['me'] = function()
        for _, keymap in pairs(keymap_restore) do
            api.nvim_buf_set_keymap(keymap.buffer, keymap.mode, keymap.lhs, keymap.rhs, { silent = keymap.silent == 1 })
        end
        keymap_restore = {}
    end
    vim.cmd [[au FileType dap-repl lua require('dap.ext.autocompl').attach()]]
end

function M.setup_dap_ui()
    require('dapui').setup {
        controls = {
            element = 'console',
        },
    }
end

return M
