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
vim.api.nvim_set_keymap('n', '<Leader>q', '', { callback = ToggleQuickFix, unpack(ns) })
vim.api.nvim_set_keymap('n', '<Leader>t', ':OverseerToggle<cr>', ns)
vim.api.nvim_set_keymap('n', '<Leader><space>', ':ToggleTerm size=16<cr>', ns)
vim.api.nvim_set_keymap('t', '<Leader><space>', '', {
    callback = function()
        vim.cmd [[ToggleTerm size=16]]
    end,
    unpack(nse)
})

vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope fd<cr>', n)
vim.api.nvim_set_keymap('n', '<C-f>', ':grep ', n)
vim.api.nvim_set_keymap('n', '<C-q>', ':grep <c-r><c-w>', n)
vim.api.nvim_set_keymap('n', '<C-t>', '', {
    callback = function()
        if lsp.use_coc then
            vim.cmd [[CocList outline]]
        else
            require('telescope.builtin').lsp_document_symbols({ symbol_width = 150 })
        end
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

-- hover
vim.api.nvim_set_keymap('n', 'K', lsp.commands.hover, ns)
vim.api.nvim_set_keymap('n', '<C-k>', lsp.commands.chover, ns)

-- goto
vim.api.nvim_set_keymap('n', 'gd', lsp.commands.definition, ns)
vim.api.nvim_set_keymap('n', 'gv', '<C-w>v' .. lsp.commands.definition, ns)
vim.api.nvim_set_keymap('n', 'gs', '<C-w>s' .. lsp.commands.definition, ns)
vim.api.nvim_set_keymap('n', 'gD', lsp.commands.declaration, ns)
vim.api.nvim_set_keymap('n', 'gi', lsp.commands.implementation, ns)
vim.api.nvim_set_keymap('n', 'gr', lsp.commands.references, ns)
vim.api.nvim_set_keymap('n', 'go', lsp.commands.incoming_calls, ns)
vim.api.nvim_set_keymap('n', 'gO', lsp.commands.outgoing_calls, ns)
vim.api.nvim_set_keymap('n', 'gT', lsp.commands.type_def, ns)
vim.api.nvim_set_keymap('n', 'gh', lsp.commands.switch_header, ns)

-- code refactor
vim.api.nvim_set_keymap('n', '<Leader>r', lsp.commands.rename, ns)
vim.api.nvim_set_keymap('n', '<Leader>f', lsp.commands.format, ns)
vim.api.nvim_set_keymap('v', '<Leader>f', lsp.commands.range_format, ns)
vim.api.nvim_set_keymap('n', '<Leader>a', lsp.commands.quickfix, ns)
vim.api.nvim_set_keymap('v', '<Leader>a', lsp.commands.range_quickfix, ns)
vim.api.nvim_set_keymap('n', '<Leader>h', lsp.commands.refactor, ns)
vim.api.nvim_set_keymap('v', '<Leader>h', lsp.commands.range_refactor, ns)

-- diagnostic
vim.api.nvim_set_keymap('n', '[c', lsp.commands.prev_error, ns)
vim.api.nvim_set_keymap('n', ']c', lsp.commands.next_error, ns)
vim.api.nvim_set_keymap('n', ']l', lsp.commands.flist_error, ns)
vim.api.nvim_set_keymap('n', '[l', lsp.commands.llist_error, ns)
vim.api.nvim_set_keymap('n', '[t', ':lua require("lsp_lines").toggle()<cr>', ns)

if lsp.use_coc then
    -- hover popup window
    vim.api.nvim_set_keymap("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', nse)
    vim.api.nvim_set_keymap("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', nse)
    vim.api.nvim_set_keymap("i", "<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', nse)
    vim.api.nvim_set_keymap("i", "<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', nse)
    vim.api.nvim_set_keymap("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', nse)
    vim.api.nvim_set_keymap("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', nse)

    function _G.check_back_space()
        local col = vim.fn.col('.') - 1
        ---@diagnostic disable-next-line: param-type-mismatch
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
    end

    -- complete popup window
    vim.api.nvim_set_keymap("i", "<TAB>",
        'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', nse)
    vim.api.nvim_set_keymap("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], nse)
    vim.api.nvim_set_keymap("i", "<cr>",
        [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], nse)
end

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
