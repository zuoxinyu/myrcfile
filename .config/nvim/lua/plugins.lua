vim.cmd [[packadd packer.nvim]]

local startup = function(use)
    ---- Core Plugins ----

    use 'wbthomason/packer.nvim'
    use {
        "akinsho/toggleterm.nvim",
        config = function() require 'toggleterm'.setup {} end
    }
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require 'nvim-treesitter'.setup()
        end
    }
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-calc',
            'hrsh7th/cmp-emoji',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'f3fora/cmp-spell',
            'octaltree/cmp-look',
        }
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
        config = function() require 'nvim-tree'.setup {
                diagnostics = {
                    enable = true,
                }
            }
        end,
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function()
            require 'telescope'.setup {
                pickers = {
                    lsp_code_actions = {
                        theme = 'cursor',
                    },
                    lsp_range_code_actions = {
                        theme = 'cursor',
                    },
                    diagnostics = {
                        theme = 'dropdown',
                    },
                }
            }

        end
    }

    ---- UI & Themes ----
    use 'ellisonleao/gruvbox.nvim'
    use 'nvim-lua/popup.nvim'

    use {
        'goolord/alpha-nvim',
        config = function()
            require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
        end
    }

    use {
        'akinsho/bufferline.nvim',
        tag = "*",
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require 'bufferline'.setup {
                diagnostics = 'nvim_lsp',
            }
        end,
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require 'lualine'.setup {
                options = {
                    component_separators = '',
                    section_separators = '',
                }
            }
        end
    }

    ---- Utils ----

    use {
        "folke/lua-dev.nvim",
        config = function()
            local luadev = require 'lua-dev'.setup()
            local lspconfig = require 'lspconfig'
            lspconfig.sumneko_lua.setup(luadev)
        end
    }

    use {
        'windwp/nvim-autopairs',
        config = function() require 'nvim-autopairs'.setup {} end
    }

    use {
        'andymass/vim-matchup',
        event = 'VimEnter'
    }

    use {
        'w0rp/ale',
        ft = { 'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex' },
        cmd = 'ALEEnable',
        config = 'vim.cmd[[ALEEnable]]'
    }

    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function() require('gitsigns').setup() end
    }

end

return require('packer').startup({
    startup,
    config = {
        display = {
            open_cmd = '10new \\[packer\\]',
        },
    },
})
