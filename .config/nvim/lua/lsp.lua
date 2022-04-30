-- Setup lspconfig.LSP
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require('lspconfig')

local handlers = {
    ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' }),
    ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' }),
}

---@diagnostic disable-next-line: unused-local
local function on_attach(client, bufnr)
    if client.resolved_capabilities.document_highlight then
        vim.cmd [[
        hi! LspReferenceRead  cterm=bold,undercurl guifg=Green  ctermbg=red guibg=None
        hi! LspReferenceText  cterm=bold,undercurl guifg=Yellow ctermbg=red guibg=None
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
    'bashls',
    'cmake',
    'dockerls',
    'gopls',
    'pyright',
    'rust_analyzer',
    'vimls',
    'volar',
    'yamlls',
    'tsserver',
    'sumneko_lua',
    -- 'emmet_ls',
    -- 'ccls',
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
lspconfig.sumneko_lua.setup(require 'lua-dev'.setup({
    lspconfig = make_opts {}
}))

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

--ccls
lspconfig.ccls.setup(make_opts {
    init_options = {
        compilationDatabaseDirectory = 'build',
    },
    single_file_support = true,
})


lspconfig.tsserver.setup(make_opts {
    cmd = { 'node', '/home/doubleleft/download/typescript-language-server/lib/cli.js', '--stdio' }
})
