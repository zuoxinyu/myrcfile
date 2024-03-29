-- Setup lspconfig.LSP
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require('lspconfig')

local inlay_hints_state = false

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
end

local servers = {
    'neocmake',
    -- 'dockerls',
    -- 'gopls',
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
            single_file_support = true, -- suggested
            on_attach = on_attach       -- on_attach is the on_attach function you defined
        }
    }
end

-- rust_analyzer is overrided by rust-tools
-- lspconfig.rust_analyzer.setup(make_opts { })


-- some options are overrided by rust-tools
--
local rust_settings = {
    server = {
        on_attach = on_attach,
        handlers = handlers,
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
local rust_tools = require 'rust-tools'
if rust_tools then
    -- rust-tools will setup some enhanced handlers, don't use `make_opts` here
    rust_tools.setup(rust_settings)
end
local clangd_settings = {
    server = make_opts {
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }
    },
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
-- clangd extra
local clangd_ext = require 'clangd_extensions'
if clangd_ext then
    clangd_ext.setup(clangd_settings)
end

function SwitchInlineInlayHints()
    if clangd_ext then
        clangd_settings.extensions.inlay_hints.inline = not clangd_settings.extensions.inlay_hints.inline
        clangd_ext.setup(clangd_settings)
    end

    if rust_tools then
        rust_settings.tools.inlay_hints.auto = not rust_settings.tools.inlay_hints.auto
        rust_tools.setup()
    end
    inlay_hints_state = not inlay_hints_state
end

-- my modified tsserver
-- lspconfig.tsserver.setup(make_opts {
--     cmd = { 'node', '/home/doubleleft/download/typescript-language-server/lib/cli.js', '--stdio' }
-- })

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup(opts)
end
