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
local use_coc = lsp.use_coc

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
        config = lsp.setup_tasks,
        cmd = 'Task',
    },
    {
        'stevearc/overseer.nvim',
        opts = {
            task_list = { direction = "bottom" }
        },
    },
    {
        'williamboman/mason.nvim',
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
            'jay-babu/mason-nvim-dap.nvim',
        },
        cmd = { 'Mason' },
        config = lsp.setup_mason,
    },
    {
        'neoclide/coc.nvim',
        branch = 'release',
        lazy = not use_coc,
        enabled = use_coc,
    },
    {
        'neovim/nvim-lspconfig',
        config = lsp.setup_lsp,
        priority = 400,
        event = { 'BufReadPost', 'BufNewFile' },
        enabled = not use_coc,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        config = ts.setup_treesitter,
        event = { 'BufReadPost', 'BufNewFile' },
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
        enabled = not use_coc,
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
        dependencies = {
            'shumphrey/fugitive-gitlab.vim',
        },
        event = { 'BufReadPost', 'BufNewFile' },
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
                log_level = 'warn',
                auto_session_suppress_dirs = { '~/' }
            }
        end,
        event = 'VeryLazy',
        enabled = true,
    },
    {
        'RRethy/vim-illuminate',
        config = function()
            vim.cmd [[hi! IlluminatedWordText guibg=#555555]]
            vim.cmd [[hi! IlluminatedWordRead guibg=#ccbb23]]
            vim.cmd [[hi! IlluminatedWordWrite guibg=#cc2c23]]
        end,
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
        'nvim-tree/nvim-web-devicons',
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
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
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
        config = ui.setup_alpha,
        priority = 100,
        lazy = false,
    },
    {
        'akinsho/bufferline.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        priority = 1000,
        config = true,
        lazy = false,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
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
        'stevearc/aerial.nvim',
        config = ui.setup_aerial,
        cmd = 'AerialToggle',
    },
    {
        'folke/trouble.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
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
            npairs.setup {
                check_ts = true,
                enable_check_bracket_line = false,
            }
            npairs.add_rules(require 'nvim-autopairs.rules.endwise-lua')
        end,
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
        "sindrets/diffview.nvim",
        cmd = "DiffviewOpen",
    },
    {
        "harrisoncramer/gitlab.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "stevearc/dressing.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        enabled = true,
        build = function() require("gitlab.server").build(true) end, -- Builds the Go binary
        config = function()
            require("gitlab").setup({
                config_path = vim.fs.normalize('~'),
            })
        end,
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
        -- opts = { window = { open = 'alternate' } },
        opts = ui.setup_flatten,
        lazy = false,
        priority = 1001,
    },
    {
        'nmac427/guess-indent.nvim',
        config = true,
        event = { 'BufReadPost', 'BufNewFile' },
    },
    {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        event = 'LspAttach',
        opts = { text = { done = '√' } },
    },
    {
        'kevinhwang91/nvim-bqf',
        init = function()
            vim.o.qftf = '{info -> v:lua._G.qftf(info)}'
        end,
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
        enabled = not use_coc,
    },
    {
        'p00f/clangd_extensions.nvim',
        config = lsp.setup_clangd,
        ft = clanguages,
        enabled = not use_coc,
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
    { 'glepnir/nerdicons.nvim', cmd = 'NerdIcons', config = function() require('nerdicons').setup({}) end }
} -- plugins

require('lazy').setup(plugins, { defaults = { lazy = true } })
