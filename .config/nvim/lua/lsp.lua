-- Setup lspconfig.LSP
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require('lspconfig')

function ScrollWinDown()
    vim.cmd [[exe "norm \<c-e>"]]
end

function ScrollWinUp()
    vim.cmd [[exe "norm \<c-y>"]]
end

-- set c-j/c-k keymap for hover popup window
local function custom_hover_handler(origin_handler)
    local hover = vim.lsp.with(origin_handler, { border = 'single' })

    return function(u, result, ctx, config)
        local bufnr, winnr = hover(u, result, ctx, config)
        if winnr == nil then return end

        local buffer = vim.api.nvim_get_current_buf()
        local scroll_down = string.format([[:lua vim.api.nvim_win_call(%d, ScrollWinDown)<CR>]], winnr)
        local scroll_up = string.format([[:lua vim.api.nvim_win_call(%d, ScrollWinUp)<CR>]], winnr)
        vim.api.nvim_buf_set_keymap(buffer, 'n', '<C-j>', scroll_down, { silent = true })
        vim.api.nvim_buf_set_keymap(buffer, 'n', '<C-k>', scroll_up, { silent = true })
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

    if client.server_capabilities.documentSymbolProvider then
        require'nvim-navic'.attach(client, bufnr)
    end
end

local servers = {
    'neocmake',
    'dockerls',
    'gopls',
    'pyright',
    'vimls',
    'volar',
    'yamlls',
    'tsserver',
    'lua_ls',
    'hls',
    'taplo',
    -- 'bashls',
    -- 'sqlls',
    -- 'sqls',
    -- 'rust_analyzer',
    -- 'emmet_ls',
    -- 'ccls',
    -- 'clangd',
    -- 'cssls',
    -- 'html',
    -- 'jsonls',
}

local opts = {
    on_attach = on_attach,
    handlers = handlers,
    capabilities = capabilities,
    Lua = {
        runtime = {
            version = 'LuaJIT'
        },
    },
}

local function make_opts(y)
    local z = {}
    for k, v in pairs(opts) do z[k] = v end
    for k, v in pairs(y) do z[k] = v end
    return z
end

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup(opts)
end


---- LANGUAGE WISE ----

-- lua server is only for nvim configuration
require 'neodev'.setup({
    lspconfig = make_opts {}
})

lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace"
            }
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

-- ccls
-- lspconfig.ccls.setup(make_opts {
--     init_options = {
--         compilationDatabaseDirectory = 'build',
--     },
--     single_file_support = true,
-- })

-- clangd conflict with ccls
-- lspconfig.clangd.setup(make_opts {})

--bashls
lspconfig.bashls.setup(make_opts {
    settings = {
        cmd_env = {
            GLOB_PATTERN = '*@(.sh|.inc|.bash|.command|.zsh|.zshrc|zsh_*)',
        },
    }
})

-- rust_analyzer is overrided by rust-tools
-- lspconfig.rust_analyzer.setup(make_opts { })

-- some options are overrided by rust-tools
local rust_tools = require 'rust-tools'
if rust_tools then
    -- rust-tools will setup some enhanced handlers, don't use `make_opts` here
    rust_tools.setup({
        server = {
            on_attach = on_attach,
            handlers = handlers,
        },
        tools = {
            inlay_hints = {
                highlight = 'Comment',
                only_current_line = true,
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
    })
end

-- clangd extra
local clangd_ext = require 'clangd_extensions'
if clangd_ext then
    clangd_ext.setup({
        server = make_opts {},
        -- options to pass to nvim-lspconfig
        -- i.e. the arguments to require("lspconfig").clangd.setup({})
        extensions = {
            -- defaults:
            -- Automatically set inlay hints (type hints)
            autoSetHints = true,
            -- These apply to the default ClangdSetInlayHints command
            inlay_hints = {
                -- Only show inlay hints for the current line
                only_current_line = true,
                -- Event which triggers a refersh of the inlay hints.
                -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
                -- not that this may cause  higher CPU usage.
                -- This option is only respected when only_current_line and
                -- autoSetHints both are true.
                only_current_line_autocmd = "CursorHold",
                -- whether to show parameter hints with the inlay hints or not
                show_parameter_hints = true,
                -- prefix for parameter hints
                parameter_hints_prefix = "<- ",
                -- prefix for all the other hints (type, chaining)
                other_hints_prefix = "=> ",
                -- whether to align to the length of the longest line in the file
                max_len_align = false,
                -- padding from the left if max_len_align is true
                max_len_align_padding = 1,
                -- whether to align to the extreme right or not
                right_align = false,
                -- padding from the right if right_align is true
                right_align_padding = 7,
                -- The color of the hints
                highlight = "Comment",
                -- The highlight group priority for extmark
                priority = 100,
            },
            ast = {
                -- These are unicode, should be available in any font
                role_icons = {
                    type = "🄣",
                    declaration = "🄓",
                    expression = "🄔",
                    statement = ";",
                    specifier = "🄢",
                    ["template argument"] = "🆃",
                },
                kind_icons = {
                    Compound = "🄲",
                    Recovery = "🅁",
                    TranslationUnit = "🅄",
                    PackExpansion = "🄿",
                    TemplateTypeParm = "🅃",
                    TemplateTemplateParm = "🅃",
                    TemplateParamObject = "🅃",
                },
                --[[ These require codicons (https://github.com/microsoft/vscode-codicons)
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
            }, ]]

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
    })
end

-- my modified tsserver
-- lspconfig.tsserver.setup(make_opts {
--     cmd = { 'node', '/home/doubleleft/download/typescript-language-server/lib/cli.js', '--stdio' }
-- })
