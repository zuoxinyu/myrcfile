local lsp = require 'lsp'
local debug = require 'debugger'
---@diagnostic disable: unused-local
---- Pure Settings ----
local n = { noremap = true }
local e = { expr = true }
local ns = { noremap = true, silent = true }
local nse = { noremap = true, silent = true, expr = true }

vim.g.mapleader = ';'

-- buffer switching
vim.api.nvim_set_keymap('n', '<C-h>', ':bp<cr>', n)
vim.api.nvim_set_keymap('n', '<C-l>', ':bn<cr>', n)
vim.api.nvim_set_keymap('n', '<S-h>', ':tabnext<cr>', n)
vim.api.nvim_set_keymap('n', '<S-l>', ':tabprev<cr>', n)
-- yank & paste
vim.api.nvim_set_keymap('n', '<Leader>p', '"p', n)
vim.api.nvim_set_keymap('v', '<Leader>y', '"+y', n)
-- terminal
vim.api.nvim_set_keymap('t', '<C-w>', [[<C-\><C-n><C-w>]], ns)
vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], ns)

---- Plugin Settings ----

vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<cr>', n)
vim.api.nvim_set_keymap('n', '<Leader>o', ':AerialToggle<cr>', n)
vim.api.nvim_set_keymap('n', '<Leader><space>', ':ToggleTerm<cr>', n)
vim.api.nvim_set_keymap('t', '<Leader><space>', ':ToggleTerm<cr>', nse)

vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope git_files<cr>', n)
vim.api.nvim_set_keymap('n', '<C-f>', ':Telescope live_grep<cr>', n)
vim.api.nvim_set_keymap('n', '<C-q>', ':Telescope grep_string<cr>', n)
vim.api.nvim_set_keymap('n', '<C-t>', '', {
    callback = function()
        require('telescope.builtin').lsp_document_symbols({ symbol_width = 150 })
    end,
    noremap = true,
})

-- global things
vim.api.nvim_set_keymap('n', '<Leader>l', ':Telescope<cr>', n)
vim.api.nvim_set_keymap('n', '<Leader>c', ':Telescope command_history<cr>', n)
vim.api.nvim_set_keymap('n', '<Leader>b', ':Telescope buffers<cr>', n)
vim.api.nvim_set_keymap('n', '<Leader>d', ':TroubleToggle<cr>', n)

-- git things
vim.api.nvim_set_keymap('n', '<Leader>gf', ':Telescope git_files<cr>', n)
vim.api.nvim_set_keymap('n', '<Leader>gm', ':Telescope git_commits<cr>', n)
vim.api.nvim_set_keymap('n', '<Leader>gs', ':Telescope git_status<cr>', n)
vim.api.nvim_set_keymap('n', '<Leader>gb', ':Telescope git_branches<cr>', n)

---- LSP Settings ----

vim.api.nvim_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', ns)
vim.api.nvim_set_keymap('n', '<C-k>', '', { callback = vim.lsp.buf.signature_help, noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>q', '', { callback = lsp.SwitchInlineInlayHints, noremap = true, silent = true })

-- goto things
vim.api.nvim_set_keymap('n', 'gd', ':lua vim.lsp.buf.definition()<cr>', ns)
vim.api.nvim_set_keymap('n', 'gv', '<C-w>v:lua vim.lsp.buf.definition()<cr>', ns)
vim.api.nvim_set_keymap('n', 'gs', '<C-w>s:lua vim.lsp.buf.definition()<cr>', ns)
vim.api.nvim_set_keymap('n', 'gD', ':lua vim.lsp.buf.declaration()<cr>', ns)
vim.api.nvim_set_keymap('n', 'gi', ':lua vim.lsp.buf.implementation()<cr>', ns)
vim.api.nvim_set_keymap('n', 'go', ':Telescope lsp_incoming_calls<cr>', ns)
vim.api.nvim_set_keymap('n', 'gO', ':Telescope lsp_outgoing_calls<cr>', ns)
vim.api.nvim_set_keymap('n', 'gr', '', {
    callback = function()
        require('telescope.builtin').lsp_references({ fname_width = 100, trim_text = true })
    end,
    noremap = true,
    silent = true,
})
vim.api.nvim_set_keymap('n', 'gT', ':lua vim.lsp.buf.type_definition()<cr>', ns)
vim.api.nvim_set_keymap('n', 'gh', ':ClangdSwitchSourceHeader<cr>', ns)

-- workspace things
vim.api.nvim_set_keymap('n', '<leader>wa', ':lua vim.lsp.buf.add_workspace_folder()<CR>', n)
vim.api.nvim_set_keymap('n', '<leader>wr', ':lua vim.lsp.buf.remove_workspace_folder()<CR>', n)
vim.api.nvim_set_keymap('n', '<leader>wl', ':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', n)

-- code refactor
vim.api.nvim_set_keymap('n', '<Leader>r', ':lua vim.lsp.buf.rename()<cr>', ns)
vim.api.nvim_set_keymap('n', '<Leader>f', ':lua vim.lsp.buf.format({async=true})<cr>', n)
vim.api.nvim_set_keymap('v', '<Leader>f', ':lua vim.lsp.buf.format({async=true})<cr>', n)
vim.api.nvim_set_keymap('n', '<Leader>a', ':lua vim.lsp.buf.code_action()<cr>', n)
vim.api.nvim_set_keymap('v', '<Leader>a', ':lua vim.lsp.buf.range_code_action()<cr>', n)

-- diagnostic
vim.api.nvim_set_keymap('n', '[c', ':lua vim.diagnostic.goto_prev()<cr>', ns)
vim.api.nvim_set_keymap('n', ']c', ':lua vim.diagnostic.goto_next()<cr>', ns)
vim.api.nvim_set_keymap('n', ']l', ':lua vim.diagnostic.open_float(nil, {})<cr>', ns)
vim.api.nvim_set_keymap('n', '[l', ':lua vim.diagnostic.setloclist()<cr>', ns)
vim.api.nvim_set_keymap('n', '<Leader>h', ':lua require("lsp_lines").toggle()<cr>', ns)

-- rename
vim.api.nvim_set_keymap('n', 'gas', [[:lua require('textcase').lsp_rename('to_snake_case')<cr>]],
    { desc = "LSP rename to snake case" })
vim.api.nvim_set_keymap('n', 'gaS', [[:lua require('textcase').current_word('to_snake_case')<cr>]],
    { desc = "Rename to snake case" })
vim.api.nvim_set_keymap('n', 'gai', ":TextCaseOpenTelescopeQuickChange<CR>", { desc = "Telescope Quick Change" })
vim.api.nvim_set_keymap('n', 'gaa', ":TextCaseOpenTelescopeLSPChange<CR>", { desc = "Telescope LSP Change" })

-- run & debugging
vim.api.nvim_create_autocmd('FileType', {
    desc = 'CMake for cpp',
    pattern = { 'c', 'cpp' },
    callback = function()
        vim.api.nvim_set_keymap('n', '<leader>1', ':CMakeGenerate<cr>', ns)
        vim.api.nvim_set_keymap('n', '<leader>2', ':CMakeBuild<cr>', ns)
        vim.api.nvim_set_keymap('n', '<leader>3', ':CMakeInstall<cr>', ns)
    end
})
vim.api.nvim_set_keymap('n', '<leader>4', '', { callback = require 'dapui'.toggle })
vim.api.nvim_set_keymap('n', '<leader>5', '', { callback = debug.run_debug, unpack(n) })
vim.api.nvim_set_keymap('n', '<leader>6', ':DapToggleBreakpoint<cr>', n)
vim.api.nvim_set_keymap('n', '<leader>7', ':DapStepOver<cr>', n)
vim.api.nvim_set_keymap('n', '<leader>8', ':DapStepIn<cr>', n)
vim.api.nvim_set_keymap('n', '<leader>9', ':DapStepOut<cr>', n)
vim.api.nvim_set_keymap('n', '<leader>0', ':DapTerminate<cr>', n)
