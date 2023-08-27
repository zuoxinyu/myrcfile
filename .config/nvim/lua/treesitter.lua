local M = {}

function M.setup_treesitter()
    vim.o.foldmethod = 'expr'
    vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
    vim.o.foldlevel = 20
    require 'nvim-treesitter.configs'.setup {
        modules = {
            'highlight',
            'incremental_selection',
            'indentation',
            'folding',
            'textobjects',
        },
        -- indent = { enable = true }, -- experimental
        highlight = { enable = true },
        matchup = { enable = true },
        incremental_selection = { enable = true },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner',
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    [']m'] = '@function.outer',
                    [']]'] = '@class.outer',
                },
                goto_next_end = {
                    [']M'] = '@function.outer',
                    [']['] = '@class.outer',
                },
                goto_previous_start = {
                    ['[m'] = '@function.outer',
                    ['[['] = '@class.outer',
                },
                goto_previous_end = {
                    ['[M'] = '@function.outer',
                    ['[]'] = '@class.outer',
                },
            },
        },
        ensure_installed = {
            'vim', 'json', 'markdown', 'yaml', 'html', 'css', 'bash',
            'make', 'cmake', 'c', 'cpp', 'lua', 'rust', 'javascript',
            'typescript', 'go', 'haskell', 'tsx', 'vue', 'python', 'php',
        },
        sync_install = false,
        auto_install = false,
        ignore_install = {},
    }
end

function M.setup_treesitter_context()
    require 'treesitter-context'.setup {
        enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
        trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = '->',
        zindex = 20,     -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    }
end

function M.setup_treesitter_cpp_tools()
    require 'nt-cpp-tools'.setup({
        preview = {
            quit = 'q',          -- optional keymapping for quit preview
            accept = '<tab>'     -- optional keymapping for accept preview
        },
        header_extension = 'hh', -- optional
        source_extension = 'cc', -- optional
        custom_define_class_function_commands = {
            CppImplWrite = {
                output_handle = require 'nt-cpp-tools.output_handlers'.get_add_to_cpp()
            }
        }
    })
end

return M
