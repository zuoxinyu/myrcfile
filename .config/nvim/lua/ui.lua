---@diagnostic disable: unused-local
local M = {}

local function replace_corner(o)
    local function map_fn(x)
        if x == '╭' then return '┌' end
        if x == '╰' then return '└' end
        if x == '╮' then return '┐' end
        if x == '╯' then return '┘' end
        return x
    end
    for key, value in pairs(o) do
        for i, x in ipairs(value) do
            value[i] = map_fn(x)
        end
    end
end

M.border_styles = {
    { '┌', 'FloatBorder' },
    { '─', 'FloatBorder' },
    { '┐', 'FloatBorder' },
    { '│', 'FloatBorder' },
    { '┘', 'FloatBorder' },
    { '─', 'FloatBorder' },
    { '└', 'FloatBorder' },
    { '│', 'FloatBorder' },
}

function M.setup_alpha()
    local alpha = require 'alpha'
    local startify = require 'alpha.themes.startify'

    startify.section.top_buttons.val = {
        startify.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
        startify.button('c', '  Last Session', ':SessionRestore<CR>'),
    }
    alpha.setup(startify.config)
end

function M.setup_tree()
    require 'nvim-tree'.setup {
        update_focused_file = { enable = true },
        diagnostics = { enable = true },
        git = { ignore = false },
        filters = { dotfiles = true },
        renderer = { icons = { git_placement = 'after' } }
    }
end

function M.setup_dressing()
    require 'dressing'.setup({
        input = { border = 'single' },
        select = {
            backend = { 'nui', 'builtin' },
            builtin = { border = 'single', },
            nui = { border = { style = 'single' }, },
        },
    })
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
            lsp_document_symbols = defaults,
            lsp_definitions = defaults,
            lsp_references = defaults,
            git_bcommits = defaults,
        },
        extensions = {
            ['ui-select'] = cursor,
        },
    }
    telescope.load_extension('textcase')
    -- telescope.load_extension("noice")
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

function M.setup_noice()
    require 'noice'.setup({
        cmdline = {
            enabled = true,
            view = 'cmdline',
            format = {
                cmdline = { pattern = "^:", icon = ":", lang = "vim" },
                search_down = { kind = "search", pattern = "^/", icon = "/", lang = "regex" },
                search_up = { kind = "search", pattern = "^%?", icon = "/", lang = "regex" },
                filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
                lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
                help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
                input = {}, -- Used by input()
            },
        },
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        presets = {
            bottom_search = true,
            command_palette = false,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = true,
        },
    })
end

function M.setup_navic()
    require('nvim-navic').setup({
        icons = {
            ['container-name'] = '  '
        },
        lsp = {
            auto_attach = true,
        },
        highlight = true,
        separator = " > ",
        depth_limit = 0,
        depth_limit_indicator = "..",
        safe_output = false,
    })
end

function M.setup_lualine()
    local winbar = {
        'filename',
        file_status = true,
        newfile_status = false,
        path = 1,
        shorting_target = 40,
    }
    require 'lualine'.setup {
        options = {
            theme = 'auto',
            component_separators = '',
            section_separators = '',
            extensions = { 'nvim-tree', 'quickfix', 'toggleterm', 'fugitive', 'aerial', 'trouble' },
            globalstatus = true,
            disabled_filetypes = {
                statusline = { 'NvimTree', 'vista_kind' },
            },
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'filename', 'diff', 'diagnostics' },
            lualine_c = { 'aerial' },
            lualine_x = {},
            lualine_y = { 'encoding', 'fileformat', 'filetype', 'searchcount', 'selectioncount', 'progress' },
            lualine_z = { 'location' }
        },
        winbar = {
            lualine_a = {},
        },
        inactive_winbar = {
            lualine_a = {},
        },
    }
end

function M.setup_aerial()
    require 'aerial'.setup({
        layout = { min_width = 30 },
        autojump = true,
        highlight_on_hover = true,
        keymaps = { ['<Esc>'] = 'actions.close' },
    })
end

function M.setup_bqf()
    require 'bqf'.setup {
        preview = {
            border = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' },
        },
    }
end

function M.git_term()
    local Terminal = require 'toggleterm.terminal'.Terminal
    local gitterm = Terminal:new({
        cmd = 'tig',
        hidden = true,
        direction = 'float',
        on_open = function(term)
            vim.cmd("startinsert!")
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
        on_close = function()
            vim.cmd("startinsert!")
        end,
    })
    return gitterm
end

function M.setup_colors()
    -- require 'catppuccin'.setup {
    --     transparent_background = true,
    --     dim_inactive = { enabled = true }
    -- }
    -- require 'gruvbox'.setup {
    --     transparent_mode = true,
    --     dim_inactive = true,
    -- }

    vim.cmd [[
      silent! colorscheme gruvbox-baby
      " fix fix_transparent bgcolor
      " highlight Normal      ctermbg=NONE guibg=NONE
      " highlight NonText     ctermbg=NONE guibg=NONE
      " highlight LineNr      ctermbg=NONE guibg=NONE
      " highlight SignColumn  ctermbg=NONE guibg=NONE

      " change float style
      " highlight NormalFloat guibg=#504945
      " highlight FloatBorder guifg=#888888 guibg=#504945

      "highlight! LspReferenceText  cterm=bold ctermfg=DarkYellow   ctermbg=#555555     guifg=DarkYellow guibg=#555555
      "highlight! LspReferenceRead  cterm=bold ctermfg=Green        ctermbg=#555555     guifg=Green      guibg=#555555
      "highlight! LspReferenceWrite cterm=bold ctermfg=Brown        ctermbg=#555555     guifg=Brown      guibg=#555555

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

      " modify lsp semantic tokens
      " highlight! default link @lsp.type.namespace clear

      " disable italic operators
      " highlight! Operator gui=NONE cterm=None
    ]]

    vim.api.nvim_set_hl(0, 'InlayHintsUnderLine', { fg = '#444444', standout = false, underline = true, blend = 40 })

    -- disable lsp-semantic-highlighting
    -- for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
    --     vim.api.nvim_set_hl(0, group, {})
    -- end
end

return M
