" SET {
    set nocompatible  "It should be the first line
    let mapleader=";"
    set mouse=a
    set magic
    set autoindent
    "set autochdir
    set autoread
    set autowrite
    set backspace=indent,eol,start
    "set cindent
    set encoding=utf-8
    set helplang=cn
    set history=700
    set hlsearch incsearch
    set ignorecase
    set laststatus=2
    set nowrap
    set number
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
    set foldenable
    "set foldmethod=indent
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
    set list
    set listchars=tab:→\ ,extends:⟩,precedes:⟨
    set splitbelow
    "set cmdheight=2
    set hidden
    "set paste
    "set noincsearch
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
"} SET

"TERMINAL {
    if has('nvim')
    elseif has('win32') || has('win64')
        set term=win32
    else
        set term=xterm-256color
        set balloondelay=250
    endif
    if !has('win32') && !has('nvim')
        au TerminalOpen * if &buftype == 'terminal' | setlocal bufhidden=hide | endif
    endif
    hi Terminal ctermbg=lightgrey ctermfg=blue guibg=lightgrey guifg=blue
"} TERMINAL

"UI {
    set t_Co=256
    set termguicolors
    set background=dark
    if has('gui_running')
        if has('gui_macvim')
            set gfn=CascadiaCode\ Nerd\ Font:h24
        elseif has('gui_win32')
            set gfn=CascadiaCode_Nerd_Font:h10
        endif
        set guioptions-=l
        set guioptions-=L
        set guioptions-=r
        set guioptions-=R
        set guioptions-=m "menu
        set guioptions-=T "toolbar
    endif
"} UI

"Functions {
	function! CopyMatches(reg)
		let hits = []
		%s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
		let reg = empty(a:reg) ? '+' : a:reg
		execute 'let @'.reg.' = join(hits, "\n") . "\n"'
	endfunction
	command! -register CopyMatches call CopyMatches(<q-reg>)

    function! ToggleQuickFix()
        if empty(filter(getwininfo(), 'v:val.quickfix'))
            copen
        else
            cclose
        endif
    endfunction
    " custom util commands
    command! -range=% -nargs=0 RemoveTrailingSpaces :<line1>,<line2>%s/\s\+$//
    command! -range=% -nargs=0 RenameSnakeCaseToCamel :<line1>,<line2>s#_\(\l\)#\u\1#g
    command! -range=% -nargs=0 RenameSnakeCaseToPascal :<line1>,<line2>s#\(\%(\<\l\+\)\%(_\)\@=\)\|_\(\l\)#\u\1\2#g
"}

"KEYBINDINGS {
    nmap <F1>    :bp<CR>
    nmap <F2>    :bn<CR>
    nmap <C-h>   :bp<CR>
    nmap <C-l>   :bn<CR>
    nmap <S-h>   :tabnext<CR>
    nmap <S-l>   :tabprev<CR>
    nmap <F12>   :call ToggleQuickFix()<CR>
    nmap <Leader>p "+p
    vnoremap <Leader>y "+y
    tnoremap <silent> <C-w> <C-\><C-n><C-w>
"} KEYBINDINGS

source ~/.vimrc.plugins

if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
