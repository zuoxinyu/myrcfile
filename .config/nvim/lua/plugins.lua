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
    use {
        'akinsho/toggleterm.nvim',
        config = function()
            require 'toggleterm'.setup {
                start_in_insert = false,
            }
        end
    }
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
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-calc',
            'hrsh7th/cmp-emoji',
            'saecki/crates.nvim',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'f3fora/cmp-spell',
            'octaltree/cmp-look',
        }
    }

    use 'mfussenegger/nvim-dap'

    use 'tpope/vim-fugitive'

    -- use {
    --     'rmagatti/auto-session',
    --     config = function()
    --         require('auto-session').setup {
    --             log_level = 'info',
    --             auto_session_suppress_dirs = { '~/', '~/Projects' }
    --         }
    --     end
    -- }

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
        config = function()
            local npairs = require 'nvim-autopairs'
            npairs.setup { check_ts = true }
            npairs.add_rules(require 'nvim-autopairs.rules.endwise-lua')
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

    use {
        'norcalli/nvim-colorizer.lua',
        config = function() require('colorizer').setup() end
    }

    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        requires = 'nvim-treesitter/nvim-treesitter',
        config = function()
            require 'nvim-treesitter.configs'.setup {
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            [']m'] = '@function.outer',
                            [']]'] = '@class.outer',
                        },
                        goto_next_end = {
                            [']M'] = '@function.outer',
                            [']['] = '@class.outer',
                        },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.outer',
                        },
                        goto_previous_end = {
                            ['[M'] = '@function.outer',
                            ['[]'] = '@class.outer',
                        },
                    },
                },
            }
        end
    }

    ---- LANGUAGE WISE ----
    use 'folke/neodev.nvim'
    use {
        'mattn/emmet-vim',
        ft = web_filetypes,
    }
    use {
        'windwp/nvim-ts-autotag',
        config = function() require('nvim-ts-autotag').setup() end,
        ft = web_filetypes,
    }
    use {
        'jose-elias-alvarez/nvim-lsp-ts-utils',
        'jose-elias-alvarez/null-ls.nvim',
        ft = web_filetypes,
    }
    use {
        'b0o/schemastore.nvim',
    }
    use {
        'zuoxinyu/rust-tools.nvim',
        branch = 'add_run_cmd_keymaps',
    }
    use {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function() require("lsp_lines").setup() end,
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
