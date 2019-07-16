set nocompatible  "It should be the first line
set mouse=a
let mapleader=";"
set magic
"set cindent
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" SET{
	"set foldmethod=indent "marker 折叠方式
	set ai
	set autoread										  " 当文件在外部被修改，自动更新该文件
	set backspace=indent,eol,start
	set cindent
	set encoding=utf-8
	set foldenable                                        "启用折叠
    set foldmethod=syntax                                 "indent 折叠方式
	set helplang=cn
	set history=700
	set hlsearch incsearch
	set ignorecase                                        "搜索模式里忽略大小写
	set laststatus=2
	set wrap
	set nu
	set ruler
	set shiftwidth=4
	set showmode
	set smartcase
	set smarttab
	set tabstop=4
	set expandtab
	set wildmenu
	set autochdir
	set t_Co=256
    set cursorline "high light current line"
    set noshowmode
    set tags=./.tags;,.tags
    set hidden                                            "multiple buffers editing
	"set paste
	" set noincsearch                                     "在输入要搜索的文字时，取消实时匹配
"}SET

"KEYBINDINGS{
	nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR> " 用空格键来开关折叠
	nmap <F1>    :bp<cr>
	nmap <F2>    :bn<cr>
    nmap <F4>    :bd<cr>
	nmap <F9>    :TagbarToggle <CR>
	nmap <F10>   :NERDTreeToggle<CR>
	nmap <F12>   :copen 10<CR>
	nmap <C-F11> gg=G<C-o>''
	nmap <C-F12> :FS
	nmap s <Plug>(easymotion-w)
	nmap S <Plug>(easymotion-b)
	nmap <Leader>p "+p 		                            "Selected to clipboard
	vnoremap <Leader>y "+y 	                            "Clipboard to vim
"}KEYBINDINGS


"UI{
 	set gfn=Fira\ Code
	"set gcr=a:block-blinkon0
	set guioptions-=l
	set guioptions-=L
	set guioptions-=r
	set guioptions-=R
	set guioptions-=m "menu
	set guioptions-=T "toolbar
"}UI

source ~/.vim-plugins.vim

