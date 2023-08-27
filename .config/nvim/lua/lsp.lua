local M = {}
-- Setup lspconfig.LSP

-- set c-j/c-k keymap for hover popup window
local function custom_hover_handler(origin_handler)
    local hover = vim.lsp.with(origin_handler, { border = 'single' })

    return function(u, result, ctx, config)
        local bufnr, winnr = hover(u, result, ctx, config)
        if winnr == nil then return end

        local buffer = vim.api.nvim_get_current_buf()
        local scrolldown = function()
            vim.api.nvim_win_call(winnr, function()
                vim.cmd [[exe "norm \<c-e>"]]
            end)
        end
        local scrollup = function()
            vim.api.nvim_win_call(winnr, function()
                vim.cmd [[exe "norm \<c-e>"]]
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

---@diagnostic disable-next-line: unused-local
local function on_attach(client, bufnr)
    if client.server_capabilities.document_highlight or client.server_capabilities.documentHighlightProvider then
        vim.cmd [[
            hi! LspReferenceText  cterm=bold,italic
            hi! LspReferenceRead  cterm=bold,undercurl guifg=Green  ctermbg=red guibg=None
            hi! LspReferenceWrite cterm=bold,undercurl guifg=Red    ctermbg=red guibg=None
        ]]
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
        on_attach = on_attach,
        handlers = handlers,
        -- capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
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
        on_attach = on_attach,
        handlers = handlers,
        -- capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    },
    single_file_support = true,
    extensions = {
        autoSetHints = true,
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
    'lua_ls',
    -- 'slint_lsp',
    -- 'hls',
    -- 'taplo',
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

function M.SwitchInlineInlayHints()
    local clangd_ext = require 'clangd_extensions'
    M.clangd_settings.extensions.inlay_hints.inline = not M.clangd_settings.extensions.inlay_hints.inline
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
end

function M.setup_lsp()
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    local lspconfig = require('lspconfig')
    local general_opts = {
        on_attach = on_attach,
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

    -- lua server is only for nvim configuration
    require 'neodev'.setup({
        lspconfig = make_opts {}
    })

    -- neodev requires lua_ls
    lspconfig.lua_ls.setup({
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace"
                },
                workspace = {
                    checkThirdParty = false,
                },
            }
        }
    })

    --jsonls
    lspconfig.jsonls.setup(make_opts {
        cmd = { 'vscode-json-languageserver', '--stdio' },
        settings = {
            json = {
                schemas = require 'schemastore'.json.schemas(),
            }
        }
    })

    -- cssls
    lspconfig.cssls.setup(make_opts {
        cmd = { 'vscode-css-languageserver', '--stdio' },
    })

    -- htmlls
    lspconfig.html.setup(make_opts {
        cmd = { 'vscode-html-languageserver', '--stdio' }
    })

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
                on_attach = on_attach,
            }
        }
    end

    for _, lsp in ipairs(M.servers) do
        lspconfig[lsp].setup(general_opts)
    end
end

return M
