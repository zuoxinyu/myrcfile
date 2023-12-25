---@diagnostic disable: unused-local
local M = {}

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
    'neocmake',
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
    'clangd',
    -- 'cssls',
    -- 'html',
    -- 'jsonls',
}

M.lang_actions = {
    generate = [[]],
    build = [[]],
    install = [[]],
    run = [[]],
    debug = [[]],
}

local function action_wrapper(fn)
    return function()
        vim.cmd [[copen]]
        fn()
    end
end

M.actions = {
    generate = action_wrapper(function()
        vim.cmd(M.lang_actions.stop)
        vim.cmd(M.lang_actions.generate)
    end),
    build = action_wrapper(function()
        vim.cmd(M.lang_actions.stop)
        vim.cmd(M.lang_actions.build)
    end),
    install = action_wrapper(function()
        vim.cmd(M.lang_actions.stop)
        vim.cmd(M.lang_actions.install)
    end),
    run = action_wrapper(function()
        vim.cmd(M.lang_actions.stop)
        vim.cmd(M.lang_actions.run)
    end),
    debug = action_wrapper(function()
        vim.cmd(M.lang_actions.debug)
    end),
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
    local home = vim.fn.expand('~')
    require("cmake-tools").setup {
        cmake_command = "cmake",                                           -- this is used to specify cmake command path
        cmake_regenerate_on_save = true,                                   -- auto generate when save CMakeLists.txt
        cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" }, -- this will be passed when invoke `CMakeGenerate`
        cmake_build_options = {},                                          -- this will be passed when invoke `CMakeBuild`
        cmake_build_directory = "build",                                   -- this is used to specify generate directory for cmake
        cmake_build_directory_prefix = "cmake_build_",                     -- when cmake_build_directory is set to "", this option will be activated
        cmake_soft_link_compile_commands = true,                           -- this will automatically make a soft link from compile commands file to project root dir
        cmake_compile_commands_from_lsp = false,                           -- this will automatically set compile commands file location using lsp, to use it, please set `cmake_soft_link_compile_commands` to false
        cmake_kits_path = home .. '/.cmake-kits.json',                     -- this is used to specify global cmake kits path, see CMakeKits for detailed usage
        cmake_variants_message = {
            short = { show = true },                                       -- whether to show short message
            long = { show = true, max_length = 40 },                       -- whether to show long message
        },
        cmake_dap_configuration = {
            name = "cpp",
            type = "codelldb",
            request = "launch",
            stopOnEntry = false,
            runInTerminal = true,
            console = "integratedTerminal",
        },
    }

    M.lang_actions = {
        generate = 'CMakeGenerate',
        build = 'CMakeBuild',
        install = 'CMakeInstall',
        run = 'CMakeRun',
        debug = 'CMakeDebug',
        stop = 'CMakeStop',
    }
end

function M.setup_mason()
    require 'mason'.setup {}
    require 'mason-lspconfig'.setup {}
    require 'mason-nvim-dap'.setup {}
end

function M.setup_lsp()
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    local lspconfig = require('lspconfig')
    -- local mason = require('mason-lspconfig')

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
    require 'neodev'.setup({})

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
                single_file_support = true,
            }
        }
    end

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
