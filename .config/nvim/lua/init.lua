require 'base'
require 'plugins'
require 'commands'
require 'mappings'
require 'diagnostic'

if vim.fn.filereadable(vim.fn.expand '~/.vimrc.local') == 1 then
    vim.cmd [[source ~/.vimrc.local]]
end
