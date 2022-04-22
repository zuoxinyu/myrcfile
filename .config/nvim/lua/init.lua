require 'base'
require 'plugins'
require 'commands'
require 'mappings'
require 'completion'
require 'lsp'

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

vim.cmd([[
  augroup reload_settings
    autocmd!
    autocmd BufWritePost base.lua source <afile>
    autocmd BufWritePost mappings.lua source <afile>
    autocmd BufWritePost lsp.lua source <afile>
    autocmd BufWritePost completion.lua source <afile>
  augroup end
]])
