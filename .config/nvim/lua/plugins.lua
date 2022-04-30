vim.cmd [[packadd packer.nvim]]

local web_filetypes = {
    'html',
    'jsx',
    'tsx',
    'vue',
    'xml',
}

local border_styles = {
    { '┌', 'FloatBorder' },
    { '─', 'FloatBorder' },
    { '┐', 'FloatBorder' },
    { '│', 'FloatBorder' },
    { '┘', 'FloatBorder' },
    { '─', 'FloatBorder' },
    { '└', 'FloatBorder' },
    { '│', 'FloatBorder' },
}

local function startup(use)
    ---- Core Plugins ----
    use 'wbthomason/packer.nvim'
    use 'akinsho/toggleterm.nvim'
    use 'neovim/nvim-lspconfig'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            vim.o.foldmethod = 'expr'
            vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
            vim.o.foldlevel = 20
            require 'nvim-treesitter.configs'.setup {
                -- indent = { enable = true }, -- experimental
                highlight = { enable = true },
                matchup = { enable = true },
                incremental_selection = { enable = true },
                ensure_installed = {
                    'vim', 'json', 'markdown', 'yaml', 'html', 'css', 'bash',
                    'make', 'cmake', 'c', 'cpp', 'lua', 'rust', 'javascript',
                    'typescript', 'go', 'haskell', 'tsx', 'vue', 'python', 'php',
                },
            }
        end
    }
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
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

    use 'mfussenegger/nvim-dap'

    use 'tpope/vim-fugitive'

    ---- UI & Themes ----
    use 'ellisonleao/gruvbox.nvim'
    use 'rcarriga/nvim-notify'
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
    }
    use {
        'stevearc/dressing.nvim',
        config = function()
            require 'dressing'.setup({
                input = {
                    border = 'single',
                    winblend = 10,
                },
                select = {
                    backend = { 'nui', 'builtin' },
                    builtin = { border = 'single', winlend = 0, },
                    nui = { border = 'single', winlend = 0, },
                },
            })
        end
    }
    use {
        'goolord/alpha-nvim',
        config = function()
            require 'alpha'.setup(require 'alpha.themes.startify'.config)
        end
    }
    use {
        'akinsho/bufferline.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require 'bufferline'.setup {}
        end,
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
    }
    use {
        'folke/which-key.nvim',
        config = function() require('which-key').setup {} end
    }
    use {
        'liuchengxu/vista.vim',
        cmd = { 'Vista', 'Vista!', 'Vista!!' },
    }

    use {
        'folke/trouble.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require('trouble').setup {} end,
        cmd = { 'TroubleToggle' },
    }

    ---- Utils ----
    use 'vim-scripts/SudoEdit.vim'

    use {
        'SmiteshP/nvim-gps',
        requires = 'nvim-treesitter/nvim-treesitter',
        config = function() require('nvim-gps').setup({
                icons = {
                    ['container-name'] = '  '
                }
            })
        end
    }
    use {
        'windwp/nvim-autopairs',
        config = function() require 'nvim-autopairs'.setup {}
        end
    }

    use {
        'andymass/vim-matchup',
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = 'popup' }
        end
    }

    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function() require('gitsigns').setup() end
    }

    use {
        'terrortylor/nvim-comment',
        config = function() require('nvim_comment').setup() end
    }

    use {
        'antoinemadec/FixCursorHold.nvim',
        config = function()
            vim.g.cursorhold_updatetime = 100
        end
    }

    ---- LANGUAGE WISE ----
    use 'folke/lua-dev.nvim'
    use {
        'mattn/emmet-vim',
        ft = web_filetypes,
    }
    use {
        'simrat39/rust-tools.nvim',
        config = function() require 'rust-tools'.setup({
                tools = {
                    hover_actions = {
                        border = border_styles,
                    },
                }
            })
        end,
        ft = 'rust',
    }
    use {
        'windwp/nvim-ts-autotag',
        config = function() require('nvim-ts-autotag').setup() end,
        ft = web_filetypes,
    }
    use {
        'jose-elias-alvarez/nvim-lsp-ts-utils',
        'jose-elias-alvarez/null-ls.nvim',
    }
    use 'b0o/schemastore.nvim'

end

return require('packer').startup({
    startup,
    config = {
        display = {
            open_cmd = '10new \\[packer\\]',
        },
    },
})
