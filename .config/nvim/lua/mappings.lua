---@diagnostic disable: unused-local
local debug = require 'debugger'
local ui = require 'ui'
local lsp = require 'lsp'

---- Pure Settings ----
local n = { noremap = true }
local e = { expr = true }
local ns = { noremap = true, silent = true }
local nse = { noremap = true, silent = true, expr = true }

vim.g.mapleader = ';'

-- buffer switching
vim.api.nvim_set_keymap('n', '<C-h>', ':bp<cr>', ns)
vim.api.nvim_set_keymap('n', '<C-l>', ':bn<cr>', ns)
vim.api.nvim_set_keymap('n', '<S-h>', ':tabnext<cr>', ns)
vim.api.nvim_set_keymap('n', '<S-l>', ':tabprev<cr>', ns)
-- yank & paste
vim.api.nvim_set_keymap('n', '<Leader>p', '"p', n)
vim.api.nvim_set_keymap('v', '<Leader>y', '"+y', n)
-- terminal
vim.api.nvim_set_keymap('t', '<C-w>', [[<C-\><C-n><C-w>]], ns)
vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], ns)

---- Plugin Settings ----

vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<cr>', ns)
vim.api.nvim_set_keymap('n', '<Leader>o', ':AerialToggle<cr>', ns)
vim.api.nvim_set_keymap('n', '<Leader>q', ':ToggleQuickfix<cr>', ns)
vim.api.nvim_set_keymap('n', '<Leader><space>', ':ToggleTerm size=16<cr>', ns)
vim.api.nvim_set_keymap('t', '<Leader><space>', '', {
    callback = function()
        vim.cmd [[ToggleTerm size=16]]
    end,
    unpack(nse)
})

vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope git_files<cr>', n)
vim.api.nvim_set_keymap('n', '<C-f>', ':Telescope live_grep<cr>', n)
vim.api.nvim_set_keymap('n', '<C-q>', ':Telescope grep_string<cr>', n)
vim.api.nvim_set_keymap('n', '<C-t>', '', {
    callback = function()
        require('telescope.builtin').lsp_document_symbols({ symbol_width = 150 })
    end,
    noremap = true,
    desc = 'Show local symbols',
})

-- global things
vim.api.nvim_set_keymap('n', '<Leader>l', ':Telescope<cr>', n)
vim.api.nvim_set_keymap('n', '<Leader>c', ':Telescope command_history<cr>', n)
vim.api.nvim_set_keymap('n', '<Leader>b', ':Telescope buffers<cr>', n)
vim.api.nvim_set_keymap('n', '<Leader>d', ':TroubleToggle<cr>', n)

-- git things
vim.api.nvim_set_keymap('n', '<Leader>g', '', {
    unpack(n),
    callback = function()
        ui.git_term():toggle()
    end,
    desc = 'Tig',
})

---- LSP Settings ----

-- hover
vim.api.nvim_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', ns)
vim.api.nvim_set_keymap('n', '<C-k>', '', { callback = vim.lsp.buf.signature_help, unpack(ns) })

-- goto
vim.api.nvim_set_keymap('n', 'gd', ':lua vim.lsp.buf.definition()<cr>', ns)
vim.api.nvim_set_keymap('n', 'gv', '<C-w>v:lua vim.lsp.buf.definition()<cr>', ns)
vim.api.nvim_set_keymap('n', 'gs', '<C-w>s:lua vim.lsp.buf.definition()<cr>', ns)
vim.api.nvim_set_keymap('n', 'gD', ':lua vim.lsp.buf.declaration()<cr>', ns)
vim.api.nvim_set_keymap('n', 'gi', ':lua vim.lsp.buf.implementation()<cr>', ns)
vim.api.nvim_set_keymap('n', 'gr', ':lua vim.lsp.buf.references()<cr>', ns)
vim.api.nvim_set_keymap('n', 'go', ':lua vim.lsp.buf.incoming_calls()<cr>', ns)
vim.api.nvim_set_keymap('n', 'gO', ':lua vim.lsp.buf.outgoing_calls()<cr>', ns)
vim.api.nvim_set_keymap('n', 'gT', ':lua vim.lsp.buf.type_definition()<cr>', ns)
vim.api.nvim_set_keymap('n', 'gh', ':ClangdSwitchSourceHeader<cr>', ns)

-- code refactor
vim.api.nvim_set_keymap('n', '<Leader>r', ':lua vim.lsp.buf.rename()<cr>', ns)
vim.api.nvim_set_keymap('n', '<Leader>f', ':lua vim.lsp.buf.format({async=true})<cr>', ns)
vim.api.nvim_set_keymap('v', '<Leader>f', ':lua vim.lsp.buf.format({async=true})<cr>', ns)
vim.api.nvim_set_keymap('n', '<Leader>a', ':lua vim.lsp.buf.code_action()<cr>', ns)
vim.api.nvim_set_keymap('v', '<Leader>a', ':lua vim.lsp.buf.range_code_action()<cr>', ns)

-- diagnostic
vim.api.nvim_set_keymap('n', '[c', ':lua vim.diagnostic.goto_prev()<cr>', ns)
vim.api.nvim_set_keymap('n', ']c', ':lua vim.diagnostic.goto_next()<cr>', ns)
vim.api.nvim_set_keymap('n', ']l', ':lua vim.diagnostic.open_float(nil, {})<cr>', ns)
vim.api.nvim_set_keymap('n', '[l', ':lua vim.diagnostic.setloclist()<cr>', ns)
vim.api.nvim_set_keymap('n', '[t', ':lua require("lsp_lines").toggle()<cr>', ns)

-- rename
vim.api.nvim_set_keymap('n', 'gas', '',
    {
        callback = function()
            require('textcase').lsp_rename('to_snake_case')
        end,
        desc = "To snake case (LSP)",
    })
vim.api.nvim_set_keymap('n', 'gaS', [[:lua <cr>]],
    {
        callback = function()
            require('textcase').current_word('to_snake_case')
        end,
        desc = "To snake case (LEX)",
    })
vim.api.nvim_set_keymap('n', 'gai', ":TextCaseOpenTelescopeQuickChange<CR>", { desc = "Telescope Quick Change" })
vim.api.nvim_set_keymap('n', 'gaa', ":TextCaseOpenTelescopeLSPChange<CR>", { desc = "Telescope LSP Change" })

-- align
vim.api.nvim_set_keymap('x', 'g=', '', {
    callback = function()
        require 'align'.align_to_string(false, false, true)
    end,
    desc = 'Align to',
    unpack(ns),
})

-- run & debugging
vim.api.nvim_set_keymap('n', '<leader>v', '', {
    callback = function()
        require 'dapui'.toggle()
    end,
    desc = 'Toggle DapUI'
})
vim.api.nvim_set_keymap('n', '<leader>1', '', { callback = lsp.actions.generate, desc = 'Run: Config' })
vim.api.nvim_set_keymap('n', '<leader>2', '', { callback = lsp.actions.build, desc = 'Run: Build' })
vim.api.nvim_set_keymap('n', '<leader>3', '', { callback = lsp.actions.install, desc = 'Run: Install' })
vim.api.nvim_set_keymap('n', '<leader>4', '', { callback = lsp.actions.run, desc = 'Action: Run' })
vim.api.nvim_set_keymap('n', '<leader>5', '', { callback = debug.run, desc = 'Debug: Run' })
vim.api.nvim_set_keymap('n', '<leader>6', '', { callback = debug.run_last, desc = 'Debug: Run last' })
vim.api.nvim_set_keymap('n', '<leader>7', '', { callback = debug.run_to_cursor, desc = 'Debug: Run to cursor' })
vim.api.nvim_set_keymap('n', '<leader>8', ':DapToggleBreakpoint<cr>', n)
vim.api.nvim_set_keymap('n', '<leader>9', ':DapStepIn<cr>', n)
vim.api.nvim_set_keymap('n', '<leader>0', ':DapStepOver<cr>', n)
vim.api.nvim_set_keymap('n', '<leader>-', ':DapStepOut<cr>', n)
vim.api.nvim_set_keymap('n', '<leader>=', ':DapTerminate<cr>', n)
