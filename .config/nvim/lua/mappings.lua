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

---- Plugin Settings ----

vim.api.nvim_set_keymap('n', '<Leader>e', '<cmd>NvimTreeToggle<cr>', n)
vim.api.nvim_set_keymap('n', '<Leader>o', '<cmd>Vista nvim_lsp<cr>', n)
vim.api.nvim_set_keymap('n', '<Leader><space>', '<cmd>ToggleTerm<cr>', n)
vim.api.nvim_set_keymap('t', '<Leader><space>', '<cmd>ToggleTerm<cr>', n)

vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>Telescope git_files<cr>', n)
vim.api.nvim_set_keymap('n', '<C-f>', '<cmd>Telescope live_grep<cr>', n)
vim.api.nvim_set_keymap('n', '<C-q>', '<cmd>Telescope grep_string<cr>', n)
vim.api.nvim_set_keymap('n', '<C-t>',
    [[<cmd>lua require('telescope.builtin').lsp_document_symbols({symbol_width = 150})<cr>]], n)

-- global things
vim.api.nvim_set_keymap('n', '<Leader>l', '<cmd>Telescope<cr>', n)
vim.api.nvim_set_keymap('n', '<Leader>c', '<cmd>Telescope command_history<cr>', n)
vim.api.nvim_set_keymap('n', '<Leader>b', '<cmd>Telescope buffers<cr>', n)
vim.api.nvim_set_keymap('n', '<Leader>d', '<cmd>TroubleToggle<cr>', n)

-- git things
vim.api.nvim_set_keymap('n', '<Leader>gf', '<cmd>Telescope git_files<cr>', n)
vim.api.nvim_set_keymap('n', '<Leader>gm', '<cmd>Telescope git_commits<cr>', n)
vim.api.nvim_set_keymap('n', '<Leader>gs', '<cmd>Telescope git_status<cr>', n)
vim.api.nvim_set_keymap('n', '<Leader>gb', '<cmd>Telescope git_branches<cr>', n)

---- LSP Settings ----

vim.api.nvim_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', ns)
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', ns)
vim.api.nvim_set_keymap('n', '<Leader>q', '', { callback = function() SwitchInlineInlayHints() end })

-- goto things
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', ns)
vim.api.nvim_set_keymap('n', 'gv', '<C-w>v<cmd>lua vim.lsp.buf.definition()<cr>', ns)
vim.api.nvim_set_keymap('n', 'gs', '<C-w>s<cmd>lua vim.lsp.buf.definition()<cr>', ns)
vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', ns)
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', ns)
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', ns)
vim.api.nvim_set_keymap('n', 'gT', '<cmd>lua vim.lsp.buf.type_definition()<cr>', ns)
vim.api.nvim_set_keymap('n', 'gh', '<cmd>ClangdSwitchSourceHeader<cr>', ns)

-- workspace things
vim.api.nvim_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', n)
vim.api.nvim_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', n)
vim.api.nvim_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', n)

-- code refactor
vim.api.nvim_set_keymap('n', '<Leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', ns)
vim.api.nvim_set_keymap('n', '<Leader>f', '<cmd>lua vim.lsp.buf.format({async=true})<cr>', n)
vim.api.nvim_set_keymap('v', '<Leader>f', '<cmd>lua vim.lsp.buf.format({async=true})<cr>', n)
vim.api.nvim_set_keymap('n', '<Leader>a', '<cmd>lua vim.lsp.buf.code_action()<cr>', n)
vim.api.nvim_set_keymap('v', '<Leader>a', '<cmd>lua vim.lsp.buf.range_code_action()<cr>', n)

-- diagnostic
vim.api.nvim_set_keymap('n', '[c', '<cmd>lua vim.diagnostic.goto_prev()<cr>', ns)
vim.api.nvim_set_keymap('n', ']c', '<cmd>lua vim.diagnostic.goto_next()<cr>', ns)
vim.api.nvim_set_keymap('n', ']l', '<cmd>lua vim.diagnostic.open_float(nil, {})<cr>', ns)
vim.api.nvim_set_keymap('n', '[l', '<cmd>lua vim.diagnostic.setloclist()<cr>', ns)
vim.api.nvim_set_keymap('n', '<Leader>h', '<cmd>lua require("lsp_lines").toggle()<cr>', ns)

-- rename
vim.api.nvim_set_keymap('n', 'gas', [[<cmd>lua require('textcase').lsp_rename('to_snake_case')<cr>]],
    { desc = "LSP rename to snake case" })
vim.api.nvim_set_keymap('n', 'gaS', [[<cmd>lua require('textcase').current_word('to_snake_case')<cr>]],
    { desc = "Rename to snake case" })
vim.api.nvim_set_keymap('n', 'gai', "<cmd>TextCaseOpenTelescopeQuickChange<CR>", { desc = "Telescope Quick Change" })
vim.api.nvim_set_keymap('n', 'gaa', "<cmd>TextCaseOpenTelescopeLSPChange<CR>", { desc = "Telescope LSP Change" })

-- set key map for paticular floating window, e.g: the lsp.hover(), diagnostics popup
function ScrollPopup()
    local api = vim.api
    local ws = api.nvim_list_wins() -- returns windows id, not winnr
    for index, winid in ipairs(ws) do
        local config = api.nvim_win_get_config(winid)
        vim.notify(vim.inspect(config))
        if config.relative ~= '' or config.external ~= '' then
            local winnr = api.nvim_win_get_number(winid)
            local scroll_down = string.format([[:lua vim.api.nvim_win_call(%d, ScrollWinDown)<CR>]], winid)
            local scroll_up = string.format([[:lua vim.api.nvim_win_call(%d, ScrollWinUp)<CR>]], winnr)
            vim.api.nvim_buf_set_keymap(0, 'n', '<C-j>', scroll_down, { silent = true })
            vim.api.nvim_buf_set_keymap(0, 'n', '<C-k>', scroll_up, { silent = true })
        end
    end
end
