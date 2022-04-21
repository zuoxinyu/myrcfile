vim.g.mapleader = ';'
---- Pure Settings ----

-- buffer switching
vim.api.nvim_set_keymap('n', '<C-h>', ':bp<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':bn<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-h>', ':tabnext<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-l>', ':tabprev<cr>', { noremap = true })
-- yank & paste
vim.api.nvim_set_keymap('n', '<Leader>p', '"p', { noremap = true })
vim.api.nvim_set_keymap('v', '<Leader>y', '"+y', { noremap = true })
-- terminal
vim.api.nvim_set_keymap('t', '<C-w>', [[<C-\><C-n><C-w>]], { noremap = true, silent = true })

---- Plugin Settings ----

vim.api.nvim_set_keymap('n', '<Leader>e', '<cmd>NvimTreeToggle<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader><space>', '<cmd>ToggleTerm<cr>', { noremap = true })
vim.api.nvim_set_keymap('t', '<Leader><space>', '<cmd>ToggleTerm<cr>', { noremap = true })

vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>Telescope git_files<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-f>', '<cmd>Telescope live_grep<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-t>', '<cmd>Telescope lsp_document_symbols<cr>', { noremap = true })

-- global things
vim.api.nvim_set_keymap('n', '<Leader>l', '<cmd>Telescope<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>c', '<cmd>Telescope command_history<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>b', '<cmd>Telescope buffers<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>d', '<cmd>Telescope diagnostics<cr>', { noremap = true })

-- git things
vim.api.nvim_set_keymap('n', '<Leader>gf', '<cmd>Telescope git_files<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>gm', '<cmd>Telescope git_commits<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>gs', '<cmd>Telescope git_status<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>gb', '<cmd>Telescope git_branches<cr>', { noremap = true })

---- LSP Settings ----

vim.api.nvim_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })

-- goto things
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gT', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { noremap = true, silent = true })

-- workspace things
vim.api.nvim_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', { noremap = true })

-- code refactor
vim.api.nvim_set_keymap('n', '<Leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<cr>', { noremap = true })
vim.api.nvim_set_keymap('v', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>a', '<cmd>Telescope lsp_code_actions<cr>', { noremap = true })
vim.api.nvim_set_keymap('v', '<Leader>a', '<cmd>Telescope lsp_range_code_actions<cr>', { noremap = true })

-- diagnostic
vim.api.nvim_set_keymap('n', '[c', '<cmd>lua vim.diagnostic.goto_prev()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']c', '<cmd>lua vim.diagnostic.goto_next()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']l', '<cmd>lua vim.diagnostic.open_float(nil, {})<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[l', '<cmd>lua vim.diagnostic.setloclist()<cr>', { noremap = true, silent = true })
