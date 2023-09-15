local M = {}
M.setup_cmp = function()
    local cmp = require 'cmp'
    local types = require('cmp.types')
    local luasnip = require 'luasnip'
    local clangd_cmp = require('clangd_extensions.cmp_scores')
    local crates = require 'crates'

    local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
    end

    local kind_icons = {
        Text = '  ',
        Method = '  ',
        Function = '  ',
        Constructor = '  ',
        Field = '  ',
        Variable = '  ',
        Class = '  ',
        Interface = '  ',
        Module = '  ',
        Property = '  ',
        Unit = '  ',
        Value = '  ',
        Enum = '  ',
        Keyword = '  ',
        Snippet = '  ',
        Color = '  ',
        File = '  ',
        Reference = '  ',
        Folder = '  ',
        EnumMember = '  ',
        Constant = '  ',
        Struct = '  ',
        Event = '  ',
        Operator = '  ',
        TypeParameter = '  ',
    }

    cmp.setup({
        formatting = {
            format = function(entry, vim_item)
                -- This concatonates the icons with the name of the item kind
                vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
                vim_item.menu = ({
                    buffer = '[Buffer]',
                    nvim_lsp = '[LSP]',
                    luasnip = '[LuaSnip]',
                    nvim_lua = '[Lua]',
                    latex_symbols = '[LaTeX]',
                })[entry.source.name]
                return vim_item
            end
        },
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        sorting = {
            comparators = {
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.recently_used,
                clangd_cmp,
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        },
        matching = {
            disallow_fuzzy_matching = false,
        },
        window = {
            border = 'single',
            completion = { border = 'single', },
            documentation = { border = 'single', },
        },
        experimental = {
            ghost_text = true,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-j>'] = cmp.mapping.scroll_docs(4),
            ['<C-k>'] = cmp.mapping.scroll_docs(-4),
            -- ['<C-e>'] = cmp.mapping.complete(),
            ['<C-n>'] = {
                i = function()
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = types.cmp.SelectBehavior.Insert })
                    else
                        cmp.complete()
                    end
                end,
            },
            ['<C-p>'] = {
                i = function()
                    if cmp.visible() then
                        cmp.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert })
                    else
                        cmp.complete()
                    end
                end,
            },
            ['<C-y>'] = { i = cmp.mapping.confirm({ select = false }) },
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
        }, {
            { name = 'luasnip' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'buffer' },
            { name = 'path' }
        }),
    })

    -- git commit setup
    cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
            { name = 'cmp_git' },
        }, {
            { name = 'buffer' },
        })
    })

    -- cargo.toml
    cmp.setup.filetype('toml', {
        sources = cmp.config.sources({
            { name = 'crates' },
        }, {
            { name = 'buffer' },
        })
    })

    -- `/` cmdline setup.
    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'cmdline' },
            { name = 'lua' },
            { name = 'path' },
        })
    })

    -- for cargo.toml
    crates.setup()
    -- for autopairs
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local handlers = require('nvim-autopairs.completion.handlers')
    cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done({
            filetypes = {
                -- "*" is a alias to all filetypes
                ["*"] = {
                    ["("] = {
                        kind = {
                            cmp.lsp.CompletionItemKind.Function,
                            cmp.lsp.CompletionItemKind.Method,
                        },
                        handler = handlers["*"]
                    }
                },
                -- Disable for tex
                tex = false
            }
        }))
end
return M
