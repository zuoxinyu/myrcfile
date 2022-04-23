vim.o.autoindent = true
vim.o.autoread = true
vim.o.autowrite = true
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.foldenable = true
vim.o.hidden = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.list = true
vim.o.magic = true
vim.o.backup = false
vim.o.showmode = false
vim.o.swapfile = false
vim.o.wrap = false
vim.o.writebackup = false
vim.o.number = true
vim.o.ruler = true
vim.o.showmatch = true
vim.o.smartcase = true
vim.o.smarttab = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.wildmenu = true
vim.o.termguicolors = true

vim.o.updatetime = 300
vim.o.history = 700
vim.o.laststatus = 2
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.t_Co = 256

vim.o.encoding = 'utf-8'
vim.o.helplang = 'cn'
vim.o.signcolumn = 'auto'
vim.o.mouse = 'a'
vim.o.listchars = 'tab:→ ,extends:⟩,precedes:⟨'
vim.o.backspace = 'indent,eol,start'
vim.o.tags = './.tags;,.tags'
vim.o.background = 'dark'
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.grepprg = 'rg --vimgrep --no-heading --smart-case'
-- vim.o.completeopt = 'menuone,noinsert,noselect'

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
})

-- remember last cursor position
vim.cmd [[
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
    hi Terminal ctermbg=lightgrey ctermfg=blue guibg=lightgrey guifg=blue
]]

