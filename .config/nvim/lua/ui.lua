local M = {}

-- Utility functions shared between progress reports for LSP and DAP

local lsp_progress = ''

function lsp_progress_bar()
    return lsp_progress
end

local function map_fn(x)
    if x == '╭' then return '┌' end
    if x == '╰' then return '└' end
    if x == '╮' then return '┐' end
    if x == '╯' then return '┘' end
    return x
end

local function replace_corner(o)
    ---@diagnostic disable-next-line: unused-local
    for key, value in pairs(o) do
        for i, x in ipairs(value) do
            value[i] = map_fn(x)
        end
    end
    return ret
end

function M.setup_tree()
    vim.g.nvim_tree_icons = { default = '' }
    require 'nvim-tree'.setup {
        update_focused_file = { enable = true },
        diagnostics = { enable = true },
        git = { ignore = false },
        filters = { dotfiles = true },
    }

end

function M.setup_telescope()
    local telescope = require 'telescope'
    local layout = {
        width = 0.8,
        height = 0.5,
        prompt_position = 'bottom',
    }
    local mappings = {
        i = { ['<esc>'] = require('telescope.actions').close, }
    }
    local defaults = require 'telescope.themes'.get_dropdown({
        layout_config = layout,
        mappings = mappings,
    })
    local cursor = require 'telescope.themes'.get_cursor({
        mappings = mappings,
    })

    replace_corner(defaults.borderchars)
    replace_corner(cursor.borderchars)

    telescope.setup {
        defaults = defaults,
        pickers = {
            lsp_code_actions = cursor,
            lsp_range_code_actions = cursor,
            lsp_definitions = defaults,
            lsp_references = defaults,
            git_bcommits = defaults,
        },
        extensions = {
            ['ui-select'] = cursor,
        },
    }
    -- telescope.load_extension('ui-select')
end

function M.setup_notify()
    -- replace native notify
    require 'notify'.setup({
        background_colour = '#000000',
        on_open = function(win)
            vim.api.nvim_win_set_config(win, { border = 'single' })
        end,
    })
    vim.notify = require 'notify'
end

function M.setup_lsp_progress()
    vim.lsp.handlers['$/progress'] = function(_, result, ctx)
        local client_name = vim.lsp.get_client_by_id(ctx.client_id).name
        local val = result.value
        if not val.kind then
            return
        end

        if val.kind == 'begin' or val.kind == 'report' then
            lsp_progress = string.format('[%s]%s:%s (%d%%%%)', client_name, val.title or '', val.message or '', val.percentage or 100)
        elseif val.kind == 'end' then
            lsp_progress = '[' .. client_name .. ']:' .. (val.title or 'Complete')
            vim.defer_fn(function()
                lsp_progress = '[' .. client_name .. ']'
            end, 5000)
        end
    end

end

function M.setup_lualine()
    require 'lualine'.setup {
        options = {
            component_separators = '',
            section_separators = '',
            extensions = { 'nvim-true', 'quickfix', 'toggleterm', 'fugitive' },
        },
        sections = {
            lualine_c = {
                'filename',
                lsp_progress_bar,
                require 'nvim-gps'.get_location,
            },
        },
    }
end

function M.setup_colors()
    vim.cmd [[
      silent! colorscheme gruvbox
      " fix fix_transparent bgcolor
      highlight Normal      ctermbg=NONE guibg=NONE
      highlight NonText     ctermbg=NONE guibg=NONE
      highlight LineNr      ctermbg=NONE guibg=NONE
      highlight SignColumn  ctermbg=NONE guibg=NONE

      " change float style
      highlight NormalFloat guibg=#504945
      highlight FloatBorder guifg=#888888 guibg=#504945
    
      " set completion menu
      highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
      highlight! CmpItemAbbrMatch      guibg=NONE guifg=#569CD6
      highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
      highlight! CmpItemKindVariable   guibg=NONE guifg=#9CDCFE
      highlight! CmpItemKindInterface  guibg=NONE guifg=#9CDCFE
      highlight! CmpItemKindText       guibg=NONE guifg=#9CDCFE
      highlight! CmpItemKindFunction   guibg=NONE guifg=#C586C0
      highlight! CmpItemKindMethod     guibg=NONE guifg=#C586C0
      highlight! CmpItemKindKeyword    guibg=NONE guifg=#D4D4D4
      highlight! CmpItemKindProperty   guibg=NONE guifg=#D4D4D4
      highlight! CmpItemKindUnit       guibg=NONE guifg=#D4D4D4
    ]]
end

M.setup_lsp_progress()
M.setup_notify()
M.setup_telescope()
M.setup_tree()
M.setup_colors()
M.setup_lualine()

return M
