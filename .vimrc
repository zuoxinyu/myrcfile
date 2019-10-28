" SET {
    set nocompatible  "It should be the first line
    let mapleader=";"
    set mouse=a
    set magic
    set ai
    set autoread
    set autowrite
    set backspace=indent,eol,start
    set cindent
    set encoding=utf-8
    set helplang=cn
    set history=700
    set hlsearch incsearch
    set ignorecase
    set laststatus=2
    set wrap
    set nu
    set ruler
    set shiftwidth=4
    set smartcase
    set smarttab
    set tabstop=4
    set expandtab
    set wildmenu
    set cursorline 
    set noshowmode
    set tags=./.tags;,.tags
    set noswapfile
    set foldenable!
    set foldmethod=indent
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    set nobackup
    set nowritebackup
    " always show signcolumns
    set signcolumn=yes
    " don't give |ins-completion-menu| messages.
    set shortmess+=c
    " Smaller updatetime for CursorHold & CursorHoldI
    set updatetime=300
    set showmatch
    set splitright
    set splitbelow
    " Better display for messages
    "set cmdheight=2
    "set autochdir
    "set hidden
    "set paste
    "set noincsearch
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
"} SET

"KEYBINDINGS {
    nmap <F1>    :bp<CR>
    nmap <F2>    :bn<CR>
    nmap <F3>    :vert term<CR>
    nmap <F4>    :bd<CR>
    nmap <F9>    :Vista!!<CR>
    nmap <F10>   :NERDTreeToggle<CR>
    nmap <F12>   :copen 10<CR>
    nmap <Leader>p "+p                "Selected to clipboard
    vnoremap <Leader>y "+y            "Clipboard to vim
"} KEYBINDINGS
 
"TERMINAL {
    tnoremap <C-Q> <C-\><C-n>         "Enter normal mode in terminal
    au TerminalOpen * if &buftype == 'terminal' | setlocal bufhidden=hide | endif
    hi Terminal ctermbg=lightgrey ctermfg=blue guibg=lightgrey guifg=blue
"}

"UI {
    if has('gui_macvim')
        set gfn=FuraCode\ Nerd\ Font:h12 
    else
        set gfn=FuraCode\ Nerd\ Font\ 12 
    endif
    set bg=dark
    set t_Co=256
    if !has('nvim')
        set term=xterm-256color
        set balloondelay=250
    endif
    set termguicolors
    "set gcr=a:block-blinkon0
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
    set guioptions-=m "menu
    set guioptions-=T "toolbar
"} UI

source ~/.vim-plugins.vim

