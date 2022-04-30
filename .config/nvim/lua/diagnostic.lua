vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    float = { border = 'none' },
    underline = true,
    severity_sort = false,
})

-- auto show diagnostic
vim.cmd [[
    autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})
]]
