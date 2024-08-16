---@diagnostic disable: unused-local
local M = {}

M.use_coc = false
---- LSP Settings ----
M.lang_actions = {
    generate = [[]],
    build = [[]],
    install = [[]],
    run = [[]],
    debug = [[]],
}

local function action_wrapper(fn)
    return function()
        vim.cmd [[botright copen]]
        -- vim.cmd [[OverseerOpen]]
        fn()
    end
end

M.actions = {
    generate = action_wrapper(function()
        vim.cmd(M.lang_actions.generate)
    end),
    build = action_wrapper(function()
        vim.cmd(M.lang_actions.build)
    end),
    install = action_wrapper(function()
        vim.cmd(M.lang_actions.install)
    end),
    run = action_wrapper(function()
        vim.cmd(M.lang_actions.run)
    end),
    debug = action_wrapper(function()
        vim.cmd(M.lang_actions.debug)
    end),
}

M.commands = not M.use_coc and {
    hover = [[:lua vim.lsp.buf.hover()<cr>]],
    chover = [[:lua vim.lsp.buf.signature_help()<cr>]],
    definition = [[:lua vim.lsp.buf.definition()<cr>]],
    declaration = [[:lua vim.lsp.buf.declaration()<cr>]],
    references = [[:lua vim.lsp.buf.references()<cr>]],
    implementation = [[:lua vim.lsp.buf.implementation()<cr>]],
    type_def = [[:lua vim.lsp.buf.type_definition()<cr>]],
    incoming_calls = [[:lua vim.lsp.buf.incoming_calls()<cr>]],
    outgoing_calls = [[:lua vim.lsp.buf.outgoing_calls()<cr>]],
    switch_header = [[:ClangdSwitchSourceHeader<cr>]],
    rename = [[:lua vim.lsp.buf.rename()<cr>]],
    quickfix = [[:lua vim.lsp.buf.code_action()<cr>]],
    range_quickfix = [[:lua vim.lsp.buf.code_action()<cr>]],
    refactor = [[:lua vim.lsp.buf.code_action()<cr>]],
    range_refactor = [[:lua vim.lsp.buf.code_action()<cr>]],
    format = [[:lua vim.lsp.buf.format({async=true})<cr>]],
    range_format = [[:lua vim.lsp.buf.format({async=true})<cr>]],
    next_error = [[:lua vim.diagnostic.goto_next()<cr>]],
    prev_error = [[:lua vim.diagnostic.goto_prev()<cr>]],
    flist_error = [[:lua vim.diagnostic.open_float(nil, {})<cr>]],
    llist_error = [[:lua vim.diagnostic.setloclist()<cr>]],
} or {
    hover = [[:lua vim.fn.CocActionAsync('doHover')<cr>]],
    chover = [[:call CocActionAsync('showSignatureHelp')<cr>]],
    definition = [[<Plug>(coc-definition)]],
    declaration = [[<Plug>(coc-definition)]],
    references = [[<Plug>(coc-references)]],
    implementation = [[<Plug>(coc-implementation)]],
    type_def = [[<Plug>(coc-type-definition)]],
    incoming_calls = [[:CocCommand document.showIncomingCalls<cr>]],
    outgoing_calls = [[:CocCommand document.showOutgoingCalls<cr>]],
    switch_header = [[:CocCommand clangd.switchSourceHeader<cr>]],
    rename = [[<Plug>(coc-rename)]],
    quickfix = [[<Plug>(coc-codeaction-cursor)]],
    range_quickfix = [[<Plug>(coc-codeaction-selected)]],
    refactor = [[<Plug>(coc-codeaction-refactor)]],
    range_refactor = [[<Plug>(coc-codeaction-refactor-selected)]],
    format = [[:lua vim.fn.CocActionAsync('format')<cr>]],
    range_format = [[<Plug>(coc-format-selected)]],
    next_error = [[:CocNext<cr>]],
    prev_error = [[:CocPrev<cr>]],
    flist_error = [[:CocList diagnostics<cr>]],
    llist_error = [[:CocDiagnostics<cr>]],
}

-- set c-j/c-k keymap for hover popup window
local function custom_hover_handler(origin_handler)
    local hover = vim.lsp.with(origin_handler, { border = 'single' })

    return function(u, result, ctx, config)
        local bufnr, winnr = hover(u, result, ctx, config)
        if winnr == nil then return end

        local buffer = vim.api.nvim_get_current_buf()
        local function scrolldown()
            vim.api.nvim_win_call(winnr, function()
                vim.cmd [[exec "norm \<c-e>"]]
            end)
        end
        local function scrollup()
            vim.api.nvim_win_call(winnr, function()
                vim.cmd [[exec "norm \<c-y>"]]
            end)
        end
        vim.api.nvim_buf_set_keymap(buffer, 'n', '<C-j>', '', { callback = scrolldown, silent = true })
        vim.api.nvim_buf_set_keymap(buffer, 'n', '<C-k>', '', { callback = scrollup, silent = true })
        vim.api.nvim_buf_attach(bufnr, false, {
            on_detach = function()
                vim.api.nvim_buf_del_keymap(buffer, 'n', '<C-j>')
                vim.api.nvim_buf_del_keymap(buffer, 'n', '<C-k>')
            end
        })
    end
end

local handlers = {
    ['textDocument/hover'] = custom_hover_handler(vim.lsp.handlers.hover),
    ['textDocument/signatureHelp'] = custom_hover_handler(vim.lsp.handlers.signature_help),
}

local function on_attach(client, bufnr)
    if client.server_capabilities.document_highlight or client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup('lsp_document_highlight', {})
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            group = 'lsp_document_highlight',
            buffer = 0,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
            group = 'lsp_document_highlight',
            buffer = 0,
            callback = vim.lsp.buf.clear_references,
        })
    end
end

M.rust_settings = {
    server = {
        -- on_attach = on_attach,
        handlers = handlers,
        capabilities = {},
        standalone = true,
    },
    tools = {
        inlay_hints = {
            auto = true,
            show_parameter_hints = true,
            only_current_line = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "InlayHintsUnderLine",
        },
        -- hover_with_actions = true,
        hover_actions = {
            border = {
                { '┌', 'FloatBorder' },
                { '─', 'FloatBorder' },
                { '┐', 'FloatBorder' },
                { '│', 'FloatBorder' },
                { '┘', 'FloatBorder' },
                { '─', 'FloatBorder' },
                { '└', 'FloatBorder' },
                { '│', 'FloatBorder' },
            },
            keymaps = {
                enable = true,
                cmd_key = function(i) return string.format("%d", i) end
            },
        },
    }
}

M.clangd_settings = {
    server = {
        -- on_attach = on_attach,
        handlers = handlers,
        capabilities = {},
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        single_file_support = true,
    },
    -- autoSetHints = true,
    inlay_hints = {
        inline = false,
        only_current_line = false,
        only_current_line_autocmd = "CursorHold",
        show_parameter_hints = true,
        parameter_hints_prefix = "<- ",
        other_hints_prefix = "=> ",
        max_len_align = false,
        max_len_align_padding = 1,
        right_align = false,
        right_align_padding = 7,
        highlight = "InlayHintsUnderLine",
        priority = 100,
    },
    ast = {
        role_icons = {
            type = "",
            declaration = "",
            expression = "",
            specifier = "",
            statement = "",
            ["template argument"] = "",
        },

        kind_icons = {
            Compound = "",
            Recovery = "",
            TranslationUnit = "",
            PackExpansion = "",
            TemplateTypeParm = "",
            TemplateTemplateParm = "",
            TemplateParamObject = "",
        },

        highlights = {
            detail = "Comment",
        },
    },
    memory_usage = {
        border = "single",
    },
    symbol_info = {
        border = "single",
    },
}

M.inlay_hints_state = false

M.servers = {
    -- 'neocmake',
    -- 'dockerls',
    'gopls',
    'pyright',
    'vimls',
    -- 'volar',
    'yamlls',
    'tsserver',
    -- 'lua_ls',
    -- 'slint_lsp',
    -- 'hls',
    'taplo',
    -- 'bashls',
    -- 'sqlls',
    -- 'sqls',
    -- 'rust_analyzer',
    -- 'emmet_ls',
    -- 'ccls',
    -- "powershell_es",
    "bufls",
    "ast_grep",
    -- 'clangd',
    -- 'cssls',
    -- 'html',
    -- 'jsonls',
}

function M.switch_inline_inlay_hints()
    local clangd_ext = require 'clangd_extensions'
    M.clangd_settings.inlay_hints.inline = not M.clangd_settings.extensions.inlay_hints.inline
    clangd_ext.setup(M.clangd_settings)

    local rust_tools = require 'rust-tools'
    M.rust_settings.tools.inlay_hints.auto = not M.rust_settings.tools.inlay_hints.auto
    rust_tools.setup(M.rust_settings)

    M.inlay_hints_state = not M.inlay_hints_state
end

function M.setup_rust()
    local rust_tools = require 'rust-tools'
    M.rust_settings.server.capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol
        .make_client_capabilities())
    rust_tools.setup(M.rust_settings)
end

function M.setup_clangd()
    local clangd_ext = require 'clangd_extensions'
    M.clangd_settings.server.capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol
        .make_client_capabilities())
    clangd_ext.setup(M.clangd_settings)
    require("clangd_extensions.inlay_hints").setup_autocmd()
    require("clangd_extensions.inlay_hints").set_inlay_hints()
end

function M.setup_cmake()
    require('cmake-tools').setup {
        cmake_command = 'cmake',
        cmake_regenerate_on_save = true,
        cmake_build_directory = 'build',
        cmake_kits_path = vim.fs.normalize('~/.cmake-kits.json'),
        cmake_soft_link_compile_commands = true,
        cmake_executor = {
            name = 'quickfix',
            opts = { position = 'horizontal', size = 10 },
        },
        cmake_runner = {
            name = 'toggleterm',
            opts = { direction = 'horizontal' },
        },
    }

    M.lang_actions = {
        generate = 'CMakeGenerate',
        build = 'CMakeBuild',
        install = 'CMakeInstall',
        run = 'CMakeRun',
        debug = 'CMakeDebug',
        stop = 'CMakeStopExecutor',
    }
end

function M.setup_tasks()
    local Path = require('plenary.path')
    require('tasks').setup({
        default_params = {
            cmake = {
                cmd = 'cmake',
                build_dir = tostring(Path:new('{cwd}', 'build')),
                build_type = 'RelWithDebInfo',
                dap_name = 'lldb',
                args = {
                    configure = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1', '-G', 'Ninja' },
                },
            },
        },
        save_before_run = true,
        params_file = '.nvim-task.json',
        quickfix = {
            pos = 'botright',
            height = 12, -- Default height.
        },
        dap_open_command = function() return require('dap').repl.open() end,
    })
end

function M.setup_mason()
    require 'mason'.setup {}
    require 'mason-lspconfig'.setup {}
    require 'mason-nvim-dap'.setup {}
end

function M.setup_nullls()
    local null_ls = require("null-ls")
    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.stylua,
            -- null_ls.builtins.completion.spell,
            null_ls.builtins.code_actions.refactoring.with({
                filetypes = { "go", "javascript", "lua", "python", "typescript", "c", "cpp" }
            }),
            null_ls.builtins.code_actions.gitsigns,
            null_ls.builtins.diagnostics.buf,
            null_ls.builtins.diagnostics.zsh,
        },
    })
end

function M.setup_refactoring()
    require("refactoring").setup({
        prompt_func_return_type = {
            go = false,
            java = false,
            cpp = true,
            c = true,
            h = true,
            hpp = true,
            cxx = true,
        },
        prompt_func_param_type = {
            go = false,
            java = false,
            cpp = true,
            c = true,
            h = true,
            hpp = true,
            cxx = true,
        },
        printf_statements = {},
        print_var_statements = {},
        show_success_message = true,
    })
end

function M.setup_lsp()
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    local lspconfig = require('lspconfig')
    -- local mason = require('mason-lspconfig')

    local mason_path = vim.fs.normalize(vim.fn.stdpath('data') .. '/mason')
    vim.lsp.set_log_level("off")
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    local general_opts = {
        -- on_attach = on_attach,
        handlers = handlers,
        capabilities = capabilities,
        Lua = {
            runtime = {
                version = 'LuaJIT'
            },
        },
    }

    local make_opts = function(y)
        local z = {}
        for k, v in pairs(general_opts) do z[k] = v end
        for k, v in pairs(y) do z[k] = v end
        return z
    end

    ---- LANGUAGE WISE ----
    require 'neodev'.setup({
        library = { plugins = true, types = true }
    })

    -- neodev requires lua_ls
    lspconfig.lua_ls.setup(make_opts {})

    --jsonls
    lspconfig.jsonls.setup(make_opts {
        settings = {
            json = {
                schemas = require 'schemastore'.json.schemas(),
            }
        }
    })

    -- cssls
    lspconfig.cssls.setup(make_opts {})

    -- htmlls
    lspconfig.html.setup(make_opts {})

    --bashls
    lspconfig.bashls.setup(make_opts {
        settings = {
            cmd_env = {
                GLOB_PATTERN = '*@(.sh|.inc|.bash|.command|.zsh|.zshrc|zsh_*)',
            },
        }
    })

    -- neocmake
    local configs = require("lspconfig.configs")
    if not configs.neocmake then
        configs.neocmake = {
            default_config = {
                cmd = { "neocmakelsp", "--stdio" },
                filetypes = { "cmake" },
                root_dir = function(fname)
                    return lspconfig.util.find_git_ancestor(fname)
                end,
                single_file_support = true,-- suggested
                on_attach = on_attach, -- on_attach is the on_attach function you defined
                init_options = {
                    format = {
                        enable = true
                    },
                    lint = {
                        enable = true
                    },
                    scan_cmake_in_package = true, -- default is true
                    semantic_token = false,
                }
            }
        }
        lspconfig.neocmake.setup(make_opts{})
    end

    -- powershell_es
    local pwshes = vim.fs.normalize(vim.fs.joinpath(mason_path, "packages", "powershell-editor-services"))
    lspconfig.powershell_es.setup(make_opts {
        bundle_path = pwshes,
    })

    -- clangd
    lspconfig.clangd.setup(make_opts {
        filetypes = { 'c', 'cpp', 'cuda', 'objc', 'objcpp' },
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        cmd = {
            "clangd",
            "--offset-encoding=utf-16",
        },
    })

    for _, lsp in ipairs(M.servers) do
        lspconfig[lsp].setup(general_opts)
    end
end

local lsp_progress = ''
function M.setup_progress()
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.lsp.handlers['$/progress'] = function(_, result, ctx)
        local client_name = vim.lsp.get_client_by_id(ctx.client_id).name
        local val = result.value
        if not val.kind then
            return
        end

        if val.kind == 'begin' or val.kind == 'report' then
            lsp_progress = string.format('[%s]%s:%s (%d%%%%)', client_name, val.title or '', val.message or '',
                val.percentage or 100)
        elseif val.kind == 'end' then
            lsp_progress = '[' .. client_name .. ']:' .. (val.title or 'Complete')
            vim.defer_fn(function()
                lsp_progress = '[' .. client_name .. ']'
            end, 5000)
        end
    end
end

function M.progress()
    return lsp_progress
end

-- vim.cmd [[ autocmd BufRead,BufNewFile *.slint set filetype=slint ]]
-- vim.cmd [[
--     augroup slint_generate
--     autocmd!
--     autocmd BufWritePost,FileWritePost *.slint silent! !slint-compiler <afile> > <afile>.h
--     augroup end
-- ]]
return M
