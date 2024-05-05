local M = {}

local icons = require 'icons'

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

function _G.qftf(info)
    local fn = vim.fn

    local items
    local ret = {}
    -- The name of item in list is based on the directory of quickfix window.
    -- Change the directory for quickfix window make the name of item shorter.
    -- It's a good opportunity to change current directory in quickfixtextfunc :)
    --
    -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
    -- local root = getRootByAlterBufnr(alterBufnr)
    -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
    --
    if info.quickfix == 1 then
        items = fn.getqflist({ id = info.id, items = 0 }).items
    else
        items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
    end
    local limit = 31
    local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
    local validFmt = '%s │%5d:%-3d│%s %s'
    for i = info.start_idx, info.end_idx do
        local e = items[i]
        local fname
        local str
        if e.valid == 1 then
            if e.bufnr > 0 then
                fname = fn.bufname(e.bufnr)
                if fname == '' or fname == nil then
                    fname = '[No Name]'
                else
                    fname = fname:gsub('^' .. vim.env.HOME, '~')
                end
                -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
                if #fname <= limit then
                    fname = fnameFmt1:format(fname)
                else
                    fname = fnameFmt2:format(fname:sub(1 - limit))
                end
            end
            local lnum = e.lnum > 99999 and -1 or e.lnum
            local col = e.col > 999 and -1 or e.col
            local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
            str = validFmt:format(fname, lnum, col, qtype, e.text)
        else
            str = e.text
        end
        table.insert(ret, str)
    end
    return ret
end

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
        view = { preserve_window_proportions = true },
        git = { enable = true },
        filters = { dotfiles = true },
        renderer = { icons = { git_placement = 'after' } },
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

local function cmake_actions()
    local cmake = require 'cmake-tools'
    return {
        configure = {
            function() return icons.ui.Pencil end,
            padding = 0,
            on_click = function(n, mouse) vim.cmd("CMakeGenerate") end
        },
        build_type = {
            function()
                local type = cmake.get_build_type()
                return "[" .. (type and type or "") .. "]"
            end,
            on_click = function(n, mouse) vim.cmd("CMakeSelectBuildType") end
        },
        build = {
            function() return icons.ui.Gear end,
            padding = 0,
            on_click = function(n, mouse) vim.cmd("CMakeBuild") end
        },
        build_target = {
            function()
                local target = cmake.get_build_target()
                return "[" .. (target and target or "unspecified") .. "]"
            end,
            on_click = function(n, mouse) vim.cmd("CMakeSelectBuildTarget") end
        },
        launch = {
            function() return icons.ui.Run end,
            padding = 0,
            on_click = function(n, mouse) vim.cmd("CMakeRun") end
        },
        launch_target = {
            function()
                local target = cmake.get_launch_target()
                return "[" .. (target and target or "unspecified") .. "]"
            end,
            on_click = function(n, mouse) vim.cmd("CMakeSelectLaunchTarget") end
        }
    }
end

function M.setup_lualine()
    ---@diagnostic disable-next-line: unused-local
    local winbar = {
        'filename',
        file_status = true,
        newfile_status = false,
        path = 1,
        shorting_target = 40,
    }

    local function quickfixtitle()
        local title = ''
        for _, win in pairs(vim.fn.getwininfo()) do
            if win["quickfix"] == 1 then
                title = 'QF:[' .. win['variables']['quickfix_title'] .. ']'
                break
            end
        end
        return title
    end

    local opts = {
        options = {
            theme = 'gruvbox',
            component_separators = '',
            section_separators = '',
            extensions = { 'nvim-tree', 'quickfix', 'toggleterm', 'fugitive', 'aerial', 'trouble' },
            globalstatus = true,
            disabled_filetypes = { statusline = { 'vista_kind' }, winbar = { 'lua' } },
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'filename', 'diff', 'diagnostics' },
            lualine_c = { 'aerial' },
            lualine_x = {},
            lualine_y = { quickfixtitle, 'encoding', 'fileformat', 'filetype', 'searchcount', 'selectioncount',
                'progress' },
            lualine_z = { 'location' }
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
    }

    if vim.fn.filereadable(vim.fs.normalize('./CMakeLists.txt')) == 1 then
        local actions = cmake_actions();
        opts.sections.lualine_x = {
            actions.configure, actions.build_type,
            actions.build, actions.build_target,
            actions.launch, actions.launch_target,
        }
    end

    require 'lualine'.setup(opts)
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
            border = 'single',
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

      highlight! VertSplit guifg=#595859

      " modify lsp semantic tokens
      " highlight! default link @lsp.type.namespace clear

      " disable italic operators
      " highlight! Operator gui=NONE cterm=None
    ]]

    vim.api.nvim_set_hl(0, 'InlayHintsUnderLine', { fg = '#444444', standout = false, underline = true, blend = 40 })
    vim.api.nvim_set_hl(0, 'CocInlayHint', { fg = '#444444', standout = false, underline = true, blend = 40 })

    -- disable lsp-semantic-highlighting
    -- for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
    --     vim.api.nvim_set_hl(0, group, {})
    -- end
end

function M.setup_flatten()
    ---@diagnostic disable-next-line: undefined-doc-name
    ---@type Terminal?
    local saved_terminal

    return {
        window = { open = "alternate" },
        callbacks = {
            should_block = function(argv)
                return vim.tbl_contains(argv, "-b")
            end,
            pre_open = function()
                local term = require("toggleterm.terminal")
                local termid = term.get_focused_id()
                saved_terminal = term.get(termid)
            end,
            post_open = function(bufnr, winnr, ft, is_blocking)
                if is_blocking and saved_terminal then
                    ---@diagnostic disable-next-line: undefined-field
                    saved_terminal:close()
                else
                    vim.api.nvim_set_current_win(winnr)
                end

                if ft == "gitcommit" or ft == "gitrebase" then
                    vim.api.nvim_create_autocmd("BufWritePost", {
                        buffer = bufnr,
                        once = true,
                        callback = vim.schedule_wrap(function()
                            vim.api.nvim_buf_delete(bufnr, {})
                        end),
                    })
                end
            end,
            block_end = function()
                vim.schedule(function()
                    if saved_terminal then
                        saved_terminal:open()
                        saved_terminal = nil
                    end
                end)
            end,
        },
    }
end

return M
