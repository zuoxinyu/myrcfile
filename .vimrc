set nocompatible  "It should be first line
syntax enable
set ai
set cindent
set mouse=a
syntax enable	"必须在前
filetype indent on
filetype on
filetype plugin indent on
filetype plugin on
"GLOBAL{
	let g:iswindows = 0
	let g:islinux = 0
	if(has("win32") || has("win64") || has("win95") || has("win16"))
	    let g:iswindows = 1
	else
	    let g:islinux = 1
	endif
	
	if has("gui_running")
	    let g:isGUI = 1
	else
	    let g:isGUI = 0
	endif
	let mapleader=";"
	au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
"}Global


" SET{
	" set foldmethod=marker                                "marker 折叠方式
	" 当文件在外部被修改，自动更新该文件
	set ai
	set autoread
	set backspace=indent,eol,start
	set cindent
	set encoding=utf-8
	"set foldenable                                        "启用折叠
	"set foldmethod=indent                                 "indent 折叠方式
	set helplang=cn
	set history=700
	set hlsearch incsearch
	set ignorecase                                        "搜索模式里忽略大小写
	set laststatus=2
	set wrap
	set nu
	"set paste
	set ruler
	set shiftwidth=4
	set expandtab
	set showmode
	set smartcase 
	set smarttab 
	set tabstop=4
	set wildmenu
	set autochdir           "Automatically change the directory
	" set noincsearch                                       "在输入要搜索的文字时，取消实时匹配
"}SET

"MAP{
	" 用空格键来开关折叠
	nnoremap <space> 6j
	nnoremap <Enter> 6k
	nnoremap <Ins> :FSLeft<CR>
	nmap cS :%s/\s\+$//g<CR>:noh<CR> 		" 常规模式下输入 cS 清除行尾空格
	nmap cM :%s/\r$//g<CR>:noh<CR> 			" 常规模式下输入 cM 清除行尾 ^M 符号
	nmap <F1> :bp<cr>
	nmap <F2> :bn<cr>
	nmap <F3> :tabprevious<cr>
	nmap <F4> :tabnext<cr>
	nmap <F5> :b <tab>
	nmap <F6> :tabs<cr>
	nmap <C-F7> :tabnew<space>
	nmap <F8> :tabclose<cr>
	nmap <F9> :TagbarToggle<CR>
	nmap <F10> :NERDTreeToggle<CR>
	map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
	nmap <C-F11> gg=G<C-o>'' " Format all
	nmap <C-F12> :FS
	nmap s <Plug>(easymotion-w)
	nmap S <Plug>(easymotion-b)
	nnoremap <F5> <Esc>:w<CR>:!clang -std=c11 % -o /tmp/a.out && /tmp/a.out<CR>
	nnoremap <F7> <Esc>:w<CR>:!gcc -std=c11 %<CR>
	nnoremap <C-F5> <Esc>:w<CR>:!clang -std=c11 -g % -o /tmp/a.out && gdb /tmp/a.out<CR>
	nnoremap <Leader>t <Esc>:YcmCompleter GetType<CR>
	"nmap <Leader>p "+p "Selected to clipboard
	"vnoremap <Leader>y "+y "Clipboard to vim
"}MAP


"UI{
	"hi PreProc ctermfg=blue cterm=bold guifg=#FF00FF
	"hi Constant ctermfg=red cterm=none guifg=green
	"hi Comment	term=none	ctermfg=gray	guifg=Gray
	"hi Constant	term=underline	ctermfg=cyan	guifg=Cyan
	"hi Identifier	term=underline	ctermfg=green	guifg=White
	"hi Statement	term=bold	ctermfg=white	guifg=White
	"hi PreProc	term=underline	ctermfg=magenta	guifg=Magenta
	"hi Type		term=underline	ctermfg=white	guifg=White
	"hi Special	term=bold	ctermfg=blue	guifg=Blue
	"hi Nontext	term=bold	ctermfg=red	guifg=Red
	"hi Normal	guifg=Yellow	guibg=#00007F
	"hi Normal	ctermfg=darkgreen
	"
	"hi Comment      cterm=none	gui=none
	"hi Constant     cterm=bold	gui=none
	"hi Identifier   cterm=none	gui=none
	"hi Statement    cterm=bold	gui=none
	"hi PreProc      cterm=bold	gui=none
	"hi Type         cterm=bold	gui=none
	"hi Special      cterm=bold	gui=none
	"hi NonText	cterm=bold	gui=none


	" 设置80字符自动下划线
	" au BufWinEnter * let w:m2=matchadd('Underlined', '\%>80v.\+', -1) 
	"syn match out80 /\%80v./ containedin=ALL 
	"hi out80 guifg=white guibg=red
	set gfn=Consolas:h11:cANSI
	"自定义颜色
    "hi User0 ctermfg=yellow  ctermbg=138 
    "hi User1 ctermfg=white  ctermbg=darkred  
    "hi User2 ctermfg=yellow   ctermbg=darkblue
    "hi User3 ctermfg=yellow ctermbg=red
    "hi User4 ctermfg=darkred  ctermbg=white
    "hi User5 ctermfg=darkred  ctermbg=77  
    "hi User6 ctermfg=darkred  ctermbg=77 
    "hi User7 ctermfg=black  ctermbg=yellow cterm=bold  
    "hi User8 ctermfg=black ctermbg=white
    "hi User9 ctermfg=white ctermbg=black
    "hi User0 ctermfg=yellow  ctermbg=138 

	"Statusline{                                            
	    "set statusline=  
	    "set statusline+=%7*\[%n]                                  "buffernr  
	    "set statusline+=%1*\ %<%F\                                "文件路径  
	    "set statusline+=%2*\ %y\                                  "文件类型  
	    "set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "编码1  
	    "set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "编码2  
	    "set statusline+=%4*\ %{&ff}\                              "文件系统(dos/unix..)   
	    "set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\  "语言 & 是否高亮，H表示高亮?  
	    "set statusline+=%#warningmsg#
	    "set statusline+=%{SyntasticStatuslineFlag()}
	    "set statusline+=%*
	    "set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "光标所在行号/总行数 (百分比)  
	    "set statusline+=%9*\ col:%03c\                            "光标所在列  
	    "set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Read only? Top/bottom  
	    function! HighlightSearch()  
	          if &hls  
	              return 'H'  
	          else  
	              return ''  
	          endif  
	    endfunction  
	"}
	"GUI{
	" 禁止光标闪烁
	 	set gcr=a:block-blinkon0
	" " 禁止显示滚动条
	 	set guioptions-=l
	 	set guioptions-=L
	 	set guioptions-=r
	 	set guioptions-=R
	" " 禁止显示菜单和工具条
	 	set guioptions-=m
	 	set guioptions-=T
		" 将外部命令 wmctrl 控制窗口最大化的命令行参数封装成一个 vim 的函数
		if has('gui_running') && has("win32")
			au GUIEnter * simalt ~x
		endif
	"	fun! ToggleFullscreen()
	"		call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")
	"		endf
	"		" 全屏开/关快捷键
	"		map <silent> <F11> :call ToggleFullscreen()<CR>
	"		" 启动 vim 时自动全屏
	"		autocmd VimEnter * call ToggleFullscreen()
	"}
"}UI

"Vundle{
	set rtp+=~/.vim/bundle/vundle/
	set rtp+=D:/cygwin/home/ZXY/.vim/bundle/vundle
	call vundle#rc()
	Bundle 'gmarik/vundle'
	" original repos on github
	"Bundle 'Lokaltog/vim-powerline'
	Bundle 'SirVer/ultisnips'
	Bundle 'Valloric/ListToggle'
	"Bundle 'Valloric/YouCompleteMe'
	Bundle 'jiangmiao/auto-pairs'
	Bundle 'kien/ctrlp.vim'
	Bundle 'klen/python-mode'
	Bundle 'mattn/emmet-vim'
	Bundle 'scrooloose/nerdcommenter'
	Bundle 'scrooloose/nerdtree'
	Bundle 'scrooloose/syntastic'
	Bundle 'sjl/gundo.vim'
	"Bundle 'sukima/xmledit'
	"Bundle 't9md/vim-quickhl'
	"Bundle 'Shougo/neocomplete'
	Bundle 'OmniCppComplete'
	"Bundle 'msanders/snipmate.vim'
	Bundle 'std_c.zip'
	Plugin 'shawncplus/phpcomplete.vim'
	Bundle 'Align'

	Bundle 'Lokaltog/vim-easymotion'
	Plugin 'vim-airline/vim-airline'
	Plugin 'vim-airline/vim-airline-themes'
	Plugin 'octol/vim-cpp-enhanced-highlight'
	Plugin 'nathanaelkane/vim-indent-guides'
	Plugin 'derekwyatt/vim-fswitch'
	Plugin 'altercation/vim-colors-solarized'
	Plugin 'tomasr/molokai'
	"Plugin 'MarcWeber/vim-addon-mw-utils'
	"Plugin 'tomtom/tlib_vim'
	"Plugin 'garbas/vim-snipmate'
	"Plugin 'honza/vim-snippets'
	Plugin 'majutsushi/tagbar'
	Plugin 'Chiel92/vim-autoformat'
	""..................................
	"" vim-scripts repos
	"Bundle 'YankRing.vim'
	"Bundle 'vcscommand.vim'
	Bundle 'ShowPairs'
	"Bundle 'SudoEdit.vim'
	"Bundle 'EasyGrep'
	"Bundle 'VOoM'
	"Bundle 'VimIM'

	"Plugins{
		" YouCompleteMe {
			   let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
			   nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
		       " 自动补全配置
		       "set completeopt=longest,menu "让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
		       autocmd InsertLeave * if pumvisible() == 0|pclose|endif "离开插入模式后自动关闭预览窗口
		       inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"    "回车即选中当前项
		       "上下左右键的行为 会显示其他信息
		       inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
		       inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
		       inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
		       inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
		       "youcompleteme  默认tab  s-tab 和自动补全冲突
		       "let g:ycm_key_list_select_completion = ['<Down>']
		       "let g:ycm_key_list_previous_completion = ['<Up>']
		       let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示
		       let g:ycm_collect_identifiers_from_tags_files=1 " 开启 YCM 基于标签引擎
		       let g:ycm_min_num_of_chars_for_completion=2 " 从第2个键入字符就开始罗列匹配项
		       let g:ycm_cache_omnifunc=0  " 禁止缓存匹配项,每次都重新生成匹配项
		       let g:ycm_seed_identifiers_with_syntax=1    " 语法关键字补全
		       "nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>   "force recomile with syntastic
		       "nnoremap <leader>lo :lopen<CR> "open locationlist
		       "nnoremap <leader>lc :lclose<CR>    "close locationlist
		       inoremap <leader><leader> <C-x><C-o>
		       "在注释输入中也能补全
		       let g:ycm_complete_in_comments = 1
		       "在字符串输入中也能补全
		       let g:ycm_complete_in_strings = 1
		       "注释和字符串中的文字也会被收入补全
			   let g:ycm_collect_identifiers_from_comments_and_strings = 0
			   nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
			   let g:ycm_collect_identifiers_from_comments_and_strings = 0
			   let g:ycm_collect_identifiers_from_tags_files = 1
			   let g:ycm_semantic_triggers = {}
			   "let g:ycm_semantic_triggers.c = ['->', '.', ' ', '(', '[', '&']'])']

		"}
		"TagBar{
		"}TagBar
		"NerdTree{
			let NERDTreeShowBookmarks=1
			let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.	svn$', '\.bzr$']
			let NERDTreeChDirMode=1
			let NERDTreeQuitOnOpen=0
			let NERDTreeMouseMode=2
			let NERDTreeShowHidden=1 "显示隐藏文件
			let NERDTreeKeepTreeInNewTab=1
			let g:nerdtree_tabs_open_on_gui_startup=1
		"}NerdTree
		"NerdComment{
			let NERDSpaceDelims=1 " 让注释符与语句之间留一个空格
		"}
		" Syntastic Configuration{
			let g:syntastic_always_populate_loc_list = 1
			let g:Syntastic_auto_jump = 2
			let g:syntastic_auto_loc_list = 1
			let g:syntastic_check_on_open = 1
			let g:syntastic_check_on_wq = 0
			let g:syntastic_error_symbol = '✗'
			let g:syntastic_warning_symbol = '⚠'
			let g:syntastic_loc_list_height = 5
			let g:syntastic_enable_highlighting = 1
			let g:syntastic_c_compiler = "clang" 
			let g:syntastic_c_compiler_options = "-std=c11"
			let g:syntastic_c_include_dirs = ["include","./","/home/zuoxinyu/zlibc/include","/home/zuoxinyu/zlibc/misc/zjson"]
			let g:syntastic_c_auto_refresh_includes = 1
			let g:syntastic_shell = "/bin/zsh"
		"}
		"Indent Guides{
			let g:indent_guides_enable_on_vim_startup=1
			" 从第二层开始可视化显示缩进
			let g:indent_guides_start_level=2
			" " 色块宽度
			let g:indent_guides_guide_size=0"
			let g:indent_guides_space_guides = 1
			let g:indent_guides_tab_guides = 1
		"}
		"Yodao translator{
			vnoremap <silent> <C-T> :<C-u>Ydv<CR>
			nnoremap <silent> <C-T> :<C-u>Ydc<CR>
			noremap <leader>yd :<C-u>Yde<CR>
		"}
		"Easymotion{
			let g:Easymotion_do_shade = 0
			let g:Easymotion_use_upper = 1
			let g:Easymotion_keys = 'ASDFGHJKLQWERTYUIOP;'
			let g:Easymotion_inc_highlight = 0
			hi EasyMotionTarget ctermbg=none ctermfg=green
		"}
		"Airline{
			colorscheme molokai
			let g:airline_powerline_fonts = 1
			let g:airline#extensions#tabline#enabled = 1
			let g:airline_theme='simple'
			let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
			let g:airline#extensions#syntastic#enabled = 1
			let g:airline#extensions#branch#vcs_priority = ["git", "mercurial"]
			let g:airline#extensions#tagbar#enabled = 1
			let g:airline#extensions#branch#enabled = 1
			let g:airline#extensions#branch#empty_message = ''
		"}
		"Emmet{
			let g:user_emmet_expandabbr_key = '<C-e>'
		"}
	"}
"}
