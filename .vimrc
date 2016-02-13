"Global set
let mapleader=";"
"General set
set nu
set ai
set history=700
set autoread
set hlsearch incsearch
set wildmenu
set cindent
set showmode
set shiftwidth=4
set encoding=utf-8
set tabstop=4
set laststatus=2
set statusline=%<>%F%1*%m%*%r%y%=%b\ 0x%B\ \ [%l,%c]%V\ %p%%    
set cursorline
highlight CursorLine   cterm=NONE ctermbg=black ctermfg=NONE
set backspace=indent,eol,start
set nocompatible
set ruler
set nowrap


let &termencoding=&encoding
set fileencodings=utf-8,gbk

syntax enable
"Enable filetype plugins
filetype on
filetype plugin on
filetype indent on

"Selected to clipboard
vnoremap <Leader>y "+y
"Clipboard to vim
nmap <Leader>p "+p

au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"GUI settings
set gfn=Consolas:h11:cANSI

"Vundle configure

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
 Bundle 'gmarik/vundle'
"
" "my Bundle here:
" "
" " original repos on github
Bundle 'kien/ctrlp.vim'
Bundle 'sukima/xmledit'
Bundle 'sjl/gundo.vim'
Bundle 'jiangmiao/auto-pairs'
Bundle 'klen/python-mode'
Bundle 'Valloric/ListToggle'
Bundle 'SirVer/ultisnips'
Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
Bundle 't9md/vim-quickhl'
" " Bundle 'Lokaltog/vim-powerline'
Bundle 'scrooloose/nerdcommenter'
"..................................
" vim-scripts repos
Bundle 'YankRing.vim'
Bundle 'vcscommand.vim'
Bundle 'ShowPairs'
Bundle 'SudoEdit.vim'
Bundle 'EasyGrep'
Bundle 'VOoM'
Bundle 'VimIM'
filetype plugin indent on
