local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
vim.opt.rtp:prepend(lazypath)

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end

local ts = require 'treesitter'
local lsp = require 'lsp'
local cmp = require 'completion'
local ui = require 'ui'
local dbg = require 'debugger'

local web_filetypes = {
    'html',
    'jsx',
    'tsx',
    'vue',
    'xml',
}

local clanguages = { 'c', 'cpp', 'objc', 'objcpp' }

local plugins = {
    ---- Core Plugins ----
    {
        'akinsho/toggleterm.nvim',
        opts = { start_in_insert = false },
        cmd  = 'ToggleTerm',
    },
    {
        'Shatur/neovim-tasks',
        enabled = false,
    },
    {
        'williamboman/mason.nvim',
        cmd = { 'Mason' },
        config = lsp.setup,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = lsp.setup_mason
    },
    {
        'neovim/nvim-lspconfig',
        config = lsp.setup_lsp,
        priority = 400,
        event = { 'BufReadPost', 'BufNewFile' },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        config = ts.setup_treesitter,
        lazy = false,
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
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
            -- 'f3fora/cmp-spell',
            -- 'octaltree/cmp-look',
        },
        config = cmp.setup_cmp,
        event = 'InsertEnter',
    },
    {
        'mfussenegger/nvim-dap',
        config = dbg.setup_dap,
        cmd = 'DapContinue',
    },
    {
        'rcarriga/nvim-dap-ui',
        config = dbg.setup_dap_ui,
        dependencies = { 'mfussenegger/nvim-dap' },
        cmd = 'DapContinue',
    },
    {
        'tpope/vim-fugitive',
        event = { 'BufReadPost' },
    },
    {
        -- 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        'stefanwatt/lsp-lines.nvim',
        config = function()
            require('lsp_lines').setup()
            require('lsp_lines').toggle()
        end,
        lazy = true,
    },
    {
        'rmagatti/auto-session',
        config = function()
            require('auto-session').setup {
                log_level = 'info',
                auto_session_suppress_dirs = { '~/' }
            }
        end,
        enabled = false,
    },
    {
        'RRethy/vim-illuminate',
        event = 'CursorHold',
    },

    ---- UI & Themes ----
    {
        'ellisonleao/gruvbox.nvim',
        lazy = false,
        priority = 1000,
        config = ui.setup_colors,
        enabled = false,
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = false,
        priority = 1000,
        config = ui.setup_colors,
        enabled = false,
    },
    {
        'eddyekofo94/gruvbox-flat.nvim',
        lazy = false,
        priority = 1000,
        config = ui.setup_colors,
        enabled = false,
    },
    {
        'luisiacc/gruvbox-baby',
        lazy = false,
        priority = 1000,
        config = ui.setup_colors,
        enabled = true,
    },
    {
        'rcarriga/nvim-notify',
        config = ui.setup_notify,
        event = 'VeryLazy',
    },
    {
        'kyazdani42/nvim-tree.lua',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
        config = ui.setup_tree,
        cmd = 'NvimTreeToggle',
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim' },
        config = ui.setup_telescope,
        cmd = 'Telescope',
    },
    {
        'stevearc/dressing.nvim',
        config = ui.setup_dressing,
        event = 'VeryLazy',
    },
    {
        'folke/noice.nvim',
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
        config = ui.setup_noice,
        event = 'VeryLazy',
        enabled = false,
    },
    {
        'goolord/alpha-nvim',
        config = function()
            require 'alpha'.setup(require 'alpha.themes.startify'.config)
        end,
        priority = 100,
        lazy = false,
    },
    {
        'akinsho/bufferline.nvim',
        dependencies = 'kyazdani42/nvim-web-devicons',
        priority = 1000,
        config = true,
        lazy = false,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
        config = ui.setup_lualine,
        priority = 1000,
        lazy = false,
    },
    {
        'folke/which-key.nvim',
        config = true,
        event = 'VeryLazy',
    },
    {
        'liuchengxu/vista.vim',
        cmd = { 'Vista' },
        enabled = false,
    },
    {
        'stevearc/aerial.nvim',
        config = ui.setup_aerial,
        cmd = 'AerialToggle',
    },
    {
        'folke/trouble.nvim',
        dependencies = 'kyazdani42/nvim-web-devicons',
        config = true,
        cmd = { 'TroubleToggle' },
    },

    ---- Utils ----
    {
        'vim-scripts/SudoEdit.vim',
        cmd = { 'SudoRead', 'SudoWrite' }
    },
    {
        'Vonr/align.nvim',
        lazy = true,
    },
    {
        'SmiteshP/nvim-navic',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        enabled = false,
    },
    {
        'windwp/nvim-autopairs',
        config = function()
            local npairs = require 'nvim-autopairs'
            npairs.setup { check_ts = true }
            npairs.add_rules(require 'nvim-autopairs.rules.endwise-lua')
        end,
        lazy = false,
    },
    {
        'andymass/vim-matchup',
        init = function()
            vim.g.matchup_matchparen_offscreen = { method = 'popup' }
        end,
        -- event = { 'CursorMoved' },
    },
    {
        'lewis6991/gitsigns.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            current_line_blame = true,
            numhl              = false,
        },
        event = 'VeryLazy',
        -- lazy = false,
        -- cmd = 'Gitsigns',
    },
    {
        'terrortylor/nvim-comment',
        config = function() require 'nvim_comment'.setup({}) end,
        keys = { 'gc' },
    },
    {
        'antoinemadec/FixCursorHold.nvim',
        init = function()
            vim.g.cursorhold_updatetime = 100
        end,
        event = 'CursorHold',
        enabled = false,
    },
    {
        'norcalli/nvim-colorizer.lua',
        config = function() require('colorizer').setup() end,
        event = { 'BufReadPost', 'BufNewFile' },
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        config = ts.setup_treesitte_context,
        enabled = false,
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = 'nvim-treesitter/nvim-treesitter',
    },
    {
        'johmsalas/text-case.nvim',
        config = function() require('textcase').setup {} end
    },
    {
        'dstein64/vim-startuptime',
        cmd = 'StartupTime',
        init = function()
            vim.g.startuptime_tries = 10
        end,
    },
    {
        'willothy/flatten.nvim',
        opts = { window = { open = 'alternate' } },
        event = 'VeryLazy',
    },
    {
        'nmac427/guess-indent.nvim',
        config = true,
        event = { 'BufReadPost', 'BufNewFile' },
    },
    {
        'luckasRanarison/nvim-devdocs',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
        opts = {}
    },
    {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        event = 'LspAttach',
        opts = {},
    },
    {
        'kevinhwang91/nvim-bqf',
        config = ui.setup_bqf,
        ft = 'qf',
    },

    ---- LANGUAGE WISE ----
    {
        'folke/neodev.nvim',
        ft = { 'lua' },
    },
    {
        'mattn/emmet-vim',
        ft = web_filetypes,
    },
    {
        'windwp/nvim-ts-autotag',
        config = true,
        ft = web_filetypes,
    },
    {
        'Badhi/nvim-treesitter-cpp-tools',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = ts.setup_treesitter_cpp_tools,
        ft = clanguages,
    },
    {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = true,
        ft = web_filetypes,
    },
    {
        'jose-elias-alvarez/nvim-lsp-ts-utils',
        ft = web_filetypes,
    },
    {
        'b0o/schemastore.nvim',
        lazy = true,
    },
    {
        'simrat39/rust-tools.nvim',
        config = lsp.setup_rust,
        ft = { 'rust' },
    },
    {
        'p00f/clangd_extensions.nvim',
        config = lsp.setup_clangd,
        ft = clanguages,
    },
    {
        'Civitasv/cmake-tools.nvim',
        config = lsp.setup_cmake,
        ft = { 'cmake', 'cpp', 'c' }
    },
    {
        'Mythos-404/xmake.nvim',
        lazy = true,
        config = true,
        event = 'BufReadPost xmake.lua',
        dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    },
} -- plugins

require('lazy').setup(plugins, { defaults = { lazy = true } })
