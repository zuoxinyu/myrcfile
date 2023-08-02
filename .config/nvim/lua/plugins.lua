vim.cmd [[packadd packer.nvim]]

local web_filetypes = {
    'html',
    'jsx',
    'tsx',
    'vue',
    'xml',
}

---@diagnostic disable-next-line: unused-local
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
    use { 'wbthomason/packer.nvim' }
    use {
        'akinsho/toggleterm.nvim',
        config = function()
            require 'toggleterm'.setup {
                start_in_insert = false,
            }
        end
    }
    use { 'neovim/nvim-lspconfig' }
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

    use { 'mfussenegger/nvim-dap' }

    use { 'tpope/vim-fugitive' }

    use {
        -- "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        'stefanwatt/lsp-lines.nvim',
        config = function()
            require("lsp_lines").setup({
                virtual_lines = false
            })
            require("lsp_lines").toggle()
        end,
    }
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
    use { 'ellisonleao/gruvbox.nvim' }
    use { 'eddyekofo94/gruvbox-flat.nvim' }
    use { 'luisiacc/gruvbox-baby' }
    use { 'rcarriga/nvim-notify' }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
    }
    use { 'stevearc/dressing.nvim' }
    use {
        'goolord/alpha-nvim',
        config = function()
            require 'alpha'.setup(require 'alpha.themes.startify'.config)
        end
    }
    use {
        'akinsho/bufferline.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require 'bufferline'.setup {}
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
    use {
        'vim-scripts/SudoEdit.vim',
        cmd = { 'SudoRead', 'SudoWrite' }
    }

    use { 'Vonr/align.nvim' }

    use {
        'SmiteshP/nvim-navic',
        requires = 'nvim-treesitter/nvim-treesitter',
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

    -- use {
        --    'nvim-treesitter/nvim-treesitter-context',
        --    requires = 'nvim-treesitter/nvim-treesitter',
        --    config = function()
        --        require 'treesitter-context'.setup {
        --            enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        --            max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        --            min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        --            line_numbers = true,
        --            multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
        --            trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        --            mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
        --            -- Separator between context and content. Should be a single character string, like '-'.
        --            -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        --            separator = '->',
        --            zindex = 20, -- The Z-index of the context window
        --            on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        --        }
        --    end
    -- }

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
    use {
        "johmsalas/text-case.nvim",
        config = function()
            require('textcase').setup {}
        end
    }

    ---- LANGUAGE WISE ----
    use { 'folke/neodev.nvim' }
    use { 'mattn/emmet-vim', ft = web_filetypes }
    use {
        'windwp/nvim-ts-autotag',
        config = function() require('nvim-ts-autotag').setup() end,
        ft = web_filetypes,
    }
    use {
        "Badhi/nvim-treesitter-cpp-tools",
        requires = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require 'nt-cpp-tools'.setup({
                preview = {
                    quit = 'q',          -- optional keymapping for quit preview
                    accept = '<tab>'     -- optional keymapping for accept preview
                },
                header_extension = 'hh', -- optional
                source_extension = 'cc', -- optional
                custom_define_class_function_commands = {
                    CppImplWrite = {
                        output_handle = require 'nt-cpp-tools.output_handlers'.get_add_to_cpp()
                    }
                }
            })
        end,
        ft = { 'cpp', 'c' },
    }
    use {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            require("null-ls").setup()
        end,
        requires = { "nvim-lua/plenary.nvim" },
        ft = web_filetypes,
    }
    use { 'jose-elias-alvarez/nvim-lsp-ts-utils', ft = web_filetypes }
    use { 'b0o/schemastore.nvim', }
    use {
        -- 'zuoxinyu/rust-tools.nvim',
        -- branch = 'add_run_cmd_keymaps',
        'simrat39/rust-tools.nvim',
    }
    use { 'p00f/clangd_extensions.nvim' }
end

return require('packer').startup({
    startup,
    config = {
        display = {
            open_cmd = '10new \\[packer\\]',
        },
    },
})
