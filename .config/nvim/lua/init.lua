require 'bootstrap'
require 'base'
require 'plugins'
require 'commands'
require 'mappings'
require 'completion'
require 'lsp'
require 'diagnostic'
require 'ui'

vim.cmd([[
  augroup config_reload
    autocmd!
    autocmd BufWritePost $HOME/.config/nvim/lua/*.lua source <afile> | lua vim.notify('config reloaded')
  augroup end
]])

vim.cmd([[
  augroup packer_reload
    autocmd!
    autocmd BufWritePost $HOME/.config/nvim/lua/plugins.lua source <afile> | PackerSync
  augroup end
]])
