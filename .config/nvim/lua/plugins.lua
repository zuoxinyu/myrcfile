vim.cmd [[packadd packer.nvim]]

local function startup(use)
    ---- Core Plugins ----
    use 'wbthomason/packer.nvim'
    use "akinsho/toggleterm.nvim"
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

    use 'tpope/vim-fugitive'

    ---- UI & Themes ----
    use 'ellisonleao/gruvbox.nvim'
    -- use 'nvim-lua/popup.nvim'
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            vim.g.nvim_tree_icons = { default = '' }
            require 'nvim-tree'.setup {
                update_focused_file = { enable = true },
                diagnostics = { enable = true },
                git = { ignore = false },
                filters = { dotfiles = true },
            }
        end,
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            local function map_fn(x)
                if x == '╭' then return '┌' end
                if x == '╰' then return '└' end
                if x == '╮' then return '┐' end
                if x == '╯' then return '┘' end
                return x
            end

            local function replace_corner(o)
                for key, value in pairs(o) do
                    for i, x in ipairs(value) do
                        value[i] = map_fn(x)
                    end
                end
                return ret
            end

            local layout = {
                width = 0.8,
                height = 0.5,
                prompt_position = 'bottom',
            }

            local mappings = {
                i = { ['<esc>'] = require('telescope.actions').close, }
            }
            local defaults = require 'telescope.themes'.get_dropdown({
                layout_config = layout,
                mappings = mappings,
            })
            local cursor = require 'telescope.themes'.get_cursor({
                mappings = mappings,
            })
            replace_corner(defaults.borderchars)
            replace_corner(cursor.borderchars)

            require 'telescope'.setup {
                defaults = defaults,
                pickers = {
                    lsp_code_actions = cursor,
                    lsp_range_code_actions = cursor,
                    lsp_definitions = cursor,
                    lsp_references = cursor,
                    git_bcommits = cursor,
                }
            }
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
        tag = "*",
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require 'bufferline'.setup {
                diagnostics = 'nvim_lsp',
            }
        end,
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function() require 'lualine'.setup {
                options = {
                    component_separators = '',
                    section_separators = '',
                    extensions = { 'nvim-true', 'quickfix', 'toggleterm', 'fugitive' },
                },
                sections = {
                    lualine_c = { 'filename', require 'nvim-gps'.get_location },
                },
            }
        end
    }
    use {
        "folke/which-key.nvim",
        config = function() require("which-key").setup {} end
    }

    ---- Utils ----
    use "folke/lua-dev.nvim"
    use 'mattn/emmet-vim'
    use 'vim-scripts/SudoEdit.vim'

    use {
        "SmiteshP/nvim-gps",
        requires = "nvim-treesitter/nvim-treesitter",
        config = function() require("nvim-gps").setup() end
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
        'windwp/nvim-ts-autotag',
        config = function()
            require('nvim-ts-autotag').setup()
        end
    }

    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function() require('gitsigns').setup() end
    }

    use { -- fix cursor performance
        'antoinemadec/FixCursorHold.nvim',
        config = function()
            vim.g.cursorhold_updatetime = 100
        end
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
