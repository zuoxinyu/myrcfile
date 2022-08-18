vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    float = {
        focus = false,
        header = 'issues:',
        source = false,
        border = 'single',
    },
    underline = true,
    severity_sort = true,
})

vim.api.nvim_create_autocmd('CursorHold', {
    pattern = '*',
    callback = function()
        vim.diagnostic.open_float(nil, {})
    end
})
