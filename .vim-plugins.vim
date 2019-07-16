if filereadable(expand("~/.vim/autoload/plug.vim")) 
	filetype off
    set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
    call plug#begin()
	"Plug 'MarcWeber/vim-addon-mw-utils'
	"Plug 'Valloric/YouCompleteMe'
	"Plug 'ervandew/supertab'
	"Plug 'honza/vim-snippets'
	"Plug 'kien/ctrlp.vim'
	"Plug 'mzlogin/vim-markdown-toc'
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
    "Plug 'MarcWeber/vim-addon-mw-utils'
    "Plug 'SirVer/ultisnips'
    "Plug 'fatih/vim-go', { 'for': 'go' }
    "Plug 'liuchengxu/vista.vim'
    "Plug 'marijnh/tern_for_vim'
    "Plug 'rust-lang/rust.vim', { 'for': 'rust' }
    "Plug 'vim-scripts/VimIM' 
	Plug 'Chiel92/vim-autoformat'
	Plug 'Lokaltog/vim-easymotion'
	Plug 'Valloric/ListToggle'
	Plug 'altercation/vim-colors-solarized'
	Plug 'derekwyatt/vim-fswitch', { 'for': 'c' }
	Plug 'jiangmiao/auto-pairs'
	Plug 'kien/rainbow_parentheses.vim'
	Plug 'klen/python-mode', {'for': 'python'}
	Plug 'majutsushi/tagbar'
	Plug 'mattn/emmet-vim', {'for': 'html'}
	Plug 'nathanaelkane/vim-indent-guides'
	Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
	Plug 'scrooloose/nerdcommenter'
	Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
	Plug 'skywind3000/asyncrun.vim'
	Plug 'tomasr/molokai'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'vim-scripts/Align'
	Plug 'vim-scripts/ShowPairs'
	Plug 'vim-scripts/SudoEdit.vim', {'on': 'SudoWrite'}
	Plug 'vim-scripts/std_c.zip', {'for': 'c'}
	Plug 'vim-scripts/vcscommand.vim'
    Plug 'Shougo/echodoc.vim'
    Plug 'Yggdroot/LeaderF'
    Plug 'ekalinin/Dockerfile.vim', {'for': 'Dockerfile'}
    Plug 'ilyachur/cmake4vim'
    Plug 'jackguo380/vim-lsp-cxx-highlight', { 'for': 'cpp' }
    Plug 'junegunn/fzf'
    Plug 'kaicataldo/material.vim'
    Plug 'kevinhui/vim-docker-tools', {'for': 'Dockerfile'}
    Plug 'liuchengxu/space-vim-dark'
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'mhinz/vim-signify'
    Plug 'morhetz/gruvbox'
    Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
    Plug 'rakr/vim-one'
    Plug 'rizzatti/dash.vim', {'on': 'Dash'}
    Plug 'tpope/vim-fugitive'
    Plug 'vim-vdebug/vdebug', { 'for': 'php' }

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

    " another language server protocol plugin
    "Plug 'autozimu/LanguageClient-neovim', {
    "            \ 'branch': 'next',
    "            \ 'do': 'bash install.sh',
    "            \ }

    " (Optional) Multi-entry selection UI.
    call plug#end()
    source ~/.vim-plugin-settings.vim
endif

