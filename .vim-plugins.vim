if filereadable(expand("~/.vim/autoload/plug.vim"))
    filetype off
    set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
    call plug#begin()

    " UI {
        "Plug 'rakr/vim-one'
        Plug 'ryanoasis/vim-devicons'
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        "Plug 'liuchengxu/eleline.vim'
        "Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
        Plug 'morhetz/gruvbox'
        "Plug 'tomasr/molokai'
        "Plug 'kaicataldo/material.vim'
        "Plug 'liuchengxu/space-vim-dark'
        "Plug 'altercation/vim-colors-solarized'
    "}
    " Management {
        Plug 'Yggdroot/LeaderF'
        Plug 'skywind3000/asyncrun.vim'
        "Plug 'junegunn/fzf', {'on': 'FZF'}
        Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
        Plug 'vim-scripts/SudoEdit.vim', {'on': 'SudoWrite'}
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        " if has('nvim')
        "     Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
        " else
        "     Plug 'Shougo/denite.nvim', { 'on': 'Denite' }
        "     Plug 'roxma/nvim-yarp'
        "     Plug 'roxma/vim-hug-neovim-rpc'
        " endif
        "if has('nvim')
        "    Plug 'Shougo/deocomplete', {'do': ':UpdateRemotePlugins'}
        "    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
        "else
        "    Plug 'Shougo/deocomplete'
        "    Plug 'Shougo/deoplete.nvim'
        "    Plug 'roxma/nvim-yarp'
        "    Plug 'roxma/vim-hug-neovim-rpc'
        "    Plug 'Shougo/deoplete-clangx'
        "endif

        "Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh'}
    "}
    " Dev {
        Plug 'majutsushi/tagbar'
        Plug 'scrooloose/nerdcommenter'
        Plug 'Lokaltog/vim-easymotion'
        Plug 'kien/rainbow_parentheses.vim'
        Plug 'nathanaelkane/vim-indent-guides', {'on': 'IndentGuidesEnable'}
        Plug 'vim-scripts/Align', {'on': 'Align'}
        "Plug 'vim-scripts/ShowPairs'
        Plug 'jiangmiao/auto-pairs'
        "Plug 'vim-scripts/vcscommand.vim'
        Plug 'mhinz/vim-signify'
        Plug 'tpope/vim-fugitive'
        "Plug 'Shougo/echodoc.vim'
        "Plug 'ludovicchabant/vim-gutentags'
        Plug 'rizzatti/dash.vim', {'on': 'Dash'}
    "}

    " Coc {
        Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
        Plug 'weirongxu/coc-explorer', {'do': 'yarn install --frozen-lockfile'}
    " }

    " Language Spec {
        Plug 'vim-scripts/std_c.zip', {'for': 'c'}
        Plug 'jackguo380/vim-lsp-cxx-highlight', {'for': 'cpp'}
        Plug 'octol/vim-cpp-enhanced-highlight', {'for': 'cpp'}
        Plug 'ilyachur/cmake4vim', {'for': 'cpp'}
        Plug 'fatih/vim-go', {'for': 'go'}
        Plug 'mattn/emmet-vim', {'for': ['html', 'vue', 'jsx']}
        Plug 'posva/vim-vue', {'for': 'vue'}
        Plug 'ekalinin/Dockerfile.vim', {'for': 'Dockerfile'}
        Plug 'kevinhui/vim-docker-tools', {'for': 'Dockerfile'}
        Plug 'mzlogin/vim-markdown-toc', {'for': 'markdown'}
        Plug 'rust-lang/rust.vim', {'for': 'rust'}
        Plug 'pangloss/vim-javascript', {'for': 'js'}
        "Plug 'mxw/vim-jsx', {'for': 'jsx'}
        "Plug 'posva/vim-vue'
        "Plug 'derekwyatt/vim-fswitch', { 'for': 'c' }
        "Plug 'vim-vdebug/vdebug', { 'for': 'php' }
        "Plug 'klen/python-mode', {'for': 'python'}
    "}

    " Misc {
        "Plug 'MarcWeber/vim-addon-mw-utils'
        "Plug 'Valloric/YouCompleteMe'
        "Plug 'ervandew/supertab'
        Plug 'https://github.com/adelarsq/vim-matchit'
        "Plug 'honza/vim-snippets'
        "Plug 'kien/ctrlp.vim'
        "Plug 'scrooloose/syntastic'
        "Plug 'shawncplus/phpcomplete.vim'
        "Plug 'sjl/gundo.vim'
        "Plug 'sukima/xmledit'
        "Plug 't9md/vim-quickhl'
        "Plug 'tomtom/tlib_vim'
        "Plug 'tpope/vim-surround'
        "Plug 'vim-scripts/EasyGrep'
        "Plug 'vim-scripts/OmniCppComplete'
        "Plug 'vim-scripts/Shougo/neocomplete'
        "Plug 'vim-scripts/VOoM'
        "Plug 'vim-scripts/YankRing.vim'
        "Plug 'w0rp/ale'
        "Plug 'SirVer/ultisnips'
        "Plug 'liuchengxu/vista.vim'
        "Plug 'marijnh/tern_for_vim'
        "Plug 'vim-scripts/VimIM'
        "Plug 'Chiel92/vim-autoformat'
        Plug 'rlue/vim-barbaric'
    "}

    call plug#end()
    source ~/.vim-plugin-settings.vim
endif

