if filereadable(expand("~/.vim/autoload/plug.vim")) 
	filetype off
    set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
    call plug#begin()
	"Bundle 'gmarik/Vundle.vim'
	"set rtp+=~/.vim/bundle/Vundle.vim
    Plug 'tpope/vim-fugitive'
	Plug 'Chiel92/vim-autoformat'
	Plug 'skywind3000/asyncrun.vim'
	Plug 'Valloric/ListToggle'
	Plug 'ervandew/supertab'
    Plug 'rizzatti/dash.vim', {'on': 'Dash'}
	Plug 'tomasr/molokai'
    "Plug 'SirVer/ultisnips'
	"Plug 'honza/vim-snippets'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'jiangmiao/auto-pairs'
	Plug 'kien/ctrlp.vim'
	"Plug 'klen/python-mode', {'for': 'python'}
	Plug 'mattn/emmet-vim', {'for': 'html'}
	Plug 'scrooloose/nerdcommenter'
	Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'Shougo/echodoc.vim'
	Plug 'kien/rainbow_parentheses.vim'
	Plug 'sjl/gundo.vim'
    Plug 'mhinz/vim-signify'
	Plug 'Lokaltog/vim-easymotion'
	"Plug 'sukima/xmledit'
	"Plug 't9md/vim-quickhl'
	"Plug 'shawncplus/phpcomplete.vim'
    Plug 'vim-vdebug/vdebug', { 'for': 'php' }
    Plug 'lvht/phpcd.vim', {'for': 'php', 'do': 'composer install'}
    if has('nvim')
        Plug 'Shougo/deocomplete', {'do': ':UpdateRemotePlugins'}
    else
        Plug 'Shougo/deocomplete'
    endif
	"Plug 'MarcWeber/vim-addon-mw-utils'
	"Plug 'tomtom/tlib_vim'
	"Plug 'scrooloose/syntastic'
	Plug 'w0rp/ale'
	Plug 'Valloric/YouCompleteMe'
    Plug 'Yggdroot/LeaderF'
	Plug 'majutsushi/tagbar'
    Plug 'ludovicchabant/vim-gutentags'
	Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
	Plug 'nathanaelkane/vim-indent-guides'
	Plug 'derekwyatt/vim-fswitch', { 'for': 'c' }
    Plug 'rust-lang/rust.vim', { 'for': 'rust' }
    Plug 'fatih/vim-go', { 'for': 'go' }
	"Plug 'tpope/vim-surround'
	"Plug 'mzlogin/vim-markdown-toc'
    "Plug 'marijnh/tern_for_vim'
	Plug 'altercation/vim-colors-solarized'
	""..................................
	"" vim-scripts repos
	Plug 'vim-scripts/std_c.zip', {'for': 'c'}
	Plug 'vim-scripts/Align'
	Plug 'vim-scripts/vcscommand.vim'
	Plug 'vim-scripts/SudoEdit.vim', {'on': 'SudoWrite'}
    "Plug 'vim-scripts/VimIM' 
	Plug 'vim-scripts/ShowPairs'
	"Plug 'vim-scripts/Shougo/neocomplete'
	"Plug 'vim-scripts/OmniCppComplete'
	"Plug 'vim-scripts/YankRing.vim'
	"Plug 'vim-scripts/EasyGrep'
	"Plug 'vim-scripts/VOoM'
	"call vundle#end()
    call plug#end()
    source ~/.plugin_settings.vim
endif

