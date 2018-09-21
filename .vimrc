set nocompatible  "It should be first line
set mouse=a
"set cindent
set magic
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
	"set paste
	set ruler
	set shiftwidth=4
	set showmode
	set smartcase                                         "如果搜索模式包含大写字符，不使用 	'ignorecase' 选项，只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用
	set smarttab                                          "指定按一次backspace就删除shiftwidth宽度的空格
	set tabstop=4
	set expandtab
	set wildmenu
	set autochdir                                         "Automatically change the directory
	set t_Co=256
    set cursorline                                        "high light current line"
    set noshowmode
    set tags=./.tags;,.tags
	" set noincsearch                                     "在输入要搜索的文字时，取消实时匹配
"}SET

"MAP{
	" 用空格键来开关折叠
	"nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
	" map ` :%s/\t/    /g<CR>
	" map / /\v
	nnoremap <Ins> :FSLeft<CR>
	nmap cS :%s/\s\+$//g<CR>:noh<CR> 		             "常规模式下输入 cS 清除行尾空格
	nmap cM :%s/\r$//g<CR>:noh<CR> 			             "常规模式下输入 cM 清除行尾 ^M 符号
	" nmap <C-t> :s/\t/    /g<CR>
	nmap <F1> :bp<cr>
	nmap <F2> :bn<cr>
	nmap <F3> :tabprevious<cr>
	nmap <F4> :tabnext<cr>
	"nmap <F5> :b <tab>
	nmap <F6> :tabs<cr>
	"nmap <F7> :tabnew<space>
	nmap <F8> :tabclose<cr>
	nmap <F9> :TagbarToggle<CR>
	nmap <F10> :NERDTreeToggle<CR>
	nmap <F11> :GundoToggle<CR>
	nmap <F12> :copen 10<CR>
	nmap <C-F11> gg=G<C-o>'' 	" Format all
	nmap <C-F12> :FS
	nmap s <Plug>(easymotion-w)
	nmap S <Plug>(easymotion-b)
	nnoremap <F5>   <Esc>:w<CR>:!clang -std=c11 % -o /tmp/a.out && /tmp/a.out<CR>
	nnoremap <F7>   <Esc>:w<CR>:!gcc -std=c11 %<CR>
	nnoremap <C-F5> <Esc>:w<CR>:!clang -std=c11 -g % -o /tmp/a.out && gdb /tmp/a.out<CR>
	nnoremap <Leader>t <Esc>:YcmCompleter GetType<CR>
	"nmap <Leader>p "+p 		                       "Selected to clipboard
	"vnoremap <Leader>y "+y 	                       "Clipboard to vim
"}MAP


"UI{
	set gcr=a:block-blinkon0
	" 禁止显示滚动条
	set guioptions-=l
	set guioptions-=L
	set guioptions-=r
	set guioptions-=R
	" 禁止显示菜单和工具条
	set guioptions-=m
	set guioptions-=T
	" 设置80字符自动下划线
	"au BufWinEnter * let w:m2=matchadd('Underlined', '\%>80v.\+', -1) 
	"syn match out80 /\%80v./ containedin=ALL 
    "hi out80 guifg=white guibg=red
 	set gfn=Monaco
	"自定义颜色
    if !filereadable(expand("~/.vim/autoload/plug.vim"))
        hi User0 ctermfg=yellow   ctermbg=138 
        hi User1 ctermfg=white    ctermbg=darkred  
        hi User2 ctermfg=yellow   ctermbg=darkblue
        hi User3 ctermfg=yellow   ctermbg=red
        hi User4 ctermfg=darkred  ctermbg=white
        hi User5 ctermfg=darkred  ctermbg=77  
        hi User6 ctermfg=darkred  ctermbg=77 
        hi User7 ctermfg=black    ctermbg=yellow cterm=bold  
        hi User8 ctermfg=black    ctermbg=white
        hi User9 ctermfg=white    ctermbg=black
        hi User0 ctermfg=yellow   ctermbg=138 

	"Statusline{                                            
	    set statusline+=%7*\[%n]                                  "buffernr  
	    set statusline+=%1*\ %<%F\                                "文件路径  
	    set statusline+=%2*\ %y\                                  "文件类型  
	    set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "编码1  
	    set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "编码2  
	    set statusline+=%4*\ %{&ff}\                              "文件系统(dos/unix..)   
	    set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\  "语言 & 是否高亮，H表示高亮?  
	    set statusline+=%#warningmsg#
	    set statusline+=%{SyntasticStatuslineFlag()}
	    set statusline+=%*
	    set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "光标所在行号/总行数 (百分比)  
	    set statusline+=%9*\ col:%03c\                            "光标所在列  
	    set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Read only? Top/bottom  
	    function! HighlightSearch()  
	          if &hls  
	              return 'H'  
	          else  
	              return ''  
	          endif  
	    endfunction  
   endif
	"}statusline
"}UI

"if filereadable(expand("~/.vim/bundle/vundle/autoload/vundle.vim"))
"Vundle{
	filetype off
	set rtp+=~/.vim/bundle/Vundle.vim
    set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
	"call vundle#rc()
    "call vundle#begin()
    call plug#begin()
	"Bundle 'gmarik/Vundle.vim'
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
	Plug 'klen/python-mode', {'for': 'python'}
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
	"Plug 'vim-scripts/ShowPairs'
	"Plug 'vim-scripts/Shougo/neocomplete'
	"Plug 'vim-scripts/OmniCppComplete'
	"Plug 'vim-scripts/YankRing.vim'
	"Plug 'vim-scripts/EasyGrep'
	"Plug 'vim-scripts/VOoM'
	"call vundle#end()
    call plug#end()
    "endif
    filetype plugin indent on

    syntax on

	"Plugins Configuration{
		" ALE {
	 		let g:ale_set_quickfix=1
			let g:ale_echo_msg_error_str='Error'
			let g:ale_echo_msg_warning_str='Warning'
			let g:ale_echo_msg_format='[%linter% %severity%:] %s'
            let g:ale_linter_explicit=1
            let g:ale_completion_delay = 500
            let g:ale_echo_delay = 20
            let g:ale_lint_delay = 500
            let g:ale_echo_msg_format = '[%linter%] %code: %%s'
            let g:ale_lint_on_text_changed = 'normal'
            let g:ale_lint_on_insert_leave = 1
            let g:airline#extensions#ale#enabled = 1

            let g:ale_c_gcc_options = '-Wall -O2 -std=c11'
            let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
            let g:ale_c_cppcheck_options = ''
            let g:ale_cpp_cppcheck_options = ''
            let g:ale_sign_error = "x"
            let g:ale_sign_warn = "-"
            hi! clear SpellBad
            hi! clear SpellCap
            hi! clear SpellRare
            hi! SpellBad gui=undercurl guisp=red
            hi! SpellCap gui=undercurl guisp=blue
            hi! SpellRare gui=undercurl guisp=magenta
		" }
		" YouCompleteMe {
			"source ~/.ycm.vim
			"let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
			nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
			" 自动补全配置
			"set completeopt=longest,menu "让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
			autocmd InsertLeave * if pumvisible() == 0|pclose|endif "离开插入模式后自动关闭预览窗口
			"inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"    "回车即选中当前项
			"上下左右键的行为 会显示其他信息
			"inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
			"inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
			"inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
			"inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
			"youcompleteme  默认tab  s-tab 和自动补全冲突
			"let g:ycm_key_list_select_completion = ["<C-n>","<tab>"]
			"let g:ycm_key_list_previous_completion = ["<C-p>", "<s-tab>"]
			let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示
			let g:ycm_collect_identifiers_from_tags_files=1 " 开启 YCM 基于标签引擎
			let g:ycm_min_num_of_chars_for_completion=1 " 从第2个键入字符就开始罗列匹配项
			let g:ycm_cache_omnifunc=0  " 禁止缓存匹配项,每次都重新生成匹配项
			let g:ycm_seed_identifiers_with_syntax=1    " 语法关键字补全
			nnoremap <C-F5> :YcmForceCompileAndDiagnostics<CR> 
			nnoremap <leader>lo :lopen<CR>     "open locationlist
			nnoremap <leader>lc :lclose<CR>    "close locationlist
			nnoremap <C-f> :YcmComplete FixIt<CR>
            noremap <c-z> <NOP>
			inoremap <leader><leader> <C-x><C-o>

            set completeopt=menu,menuone
			"在注释输入中也能补全
			"在字符串输入中也能补全
			"注释和字符串中的文字也会被收入补全
			"let g:ycm_semantic_triggers = {}
			"let g:ycm_key_invoke_completion = '<leader><leader>'
			"let g:ycm_semantic_triggers.c = ['->', '.', ' ', '(', '[', '&']
			"let g:ycm_semantic_triggers.c = "_abcdefghigklmnopqrstuvwxyzABCDEFGHIGKLMNOPQRSTUVWXYZ."
            let g:ycm_key_invoke_completion = '<c-z>'
            let g:ycm_add_preview_to_completeopt = 0
            let g:ycm_show_diagnostics_ui = 0
            let g:ycm_server_log_level = 'info'
			let g:ycm_complete_in_comments = 0
			let g:ycm_complete_in_strings = 0
            let g:ycm_min_num_identifier_candidate_chars = 2
			let g:ycm_collect_identifiers_from_tags_files = 1
            let g:ycm_collect_identifiers_from_comments_and_strings = 1

            let g:ycm_semantic_triggers =  {
                        \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
                        \ 'cs,lua,javascript': ['re!\w{2}'],
                        \ }
		"}
		"TagBar{
			"nmap <F9> :TagbarToggle<CR>
		"}TagBar
		"NerdTree{
			"nmap <F10> :NERDTreeToggle<CR>
			"autocmd vimenter * NERDTree "Auto open at start vim
			let NERDTreeShowBookmarks=1
			let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.	svn$', '\.bzr$', '\.ui$']
			let NERDTreeChDirMode=0
			let NERDTreeQuitOnOpen=0
			let NERDTreeMouseMode=2
			let NERDTreeShowHidden=0 "显示隐藏文件
			let NERDTreeKeepTreeInNewTab=1
			let g:nerdtree_tabs_open_on_gui_startup=1
		"}NerdTree
		" Syntastic Configuration{
			let g:syntastic_always_populate_loc_list = 1
			let g:syntastic_auto_loc_list = 1
			let g:syntastic_check_on_open = 1
			let g:syntastic_check_on_wq = 0
			let g:syntastic_error_symbol = '✗'
			let g:syntastic_warning_symbol = '⚠'
			let g:syntastic_loc_list_height = 5
			let g:syntastic_enable_highlighting = 1
			let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
			let g:syntastic_haskell_checkers = ['hlint']
			let g:syntastic_html_tidy_exec = 'tidy5'
			let g:syntastic_c_compiler = "clang" 
			let g:syntastic_c_compiler_options = "-std=c11"
			let g:syntastic_c_include_dirs = ["include","./","/home/doubleleft/zlibc/include","/home/doubleleft/zlibc/misc/zjson"]
			let g:syntastic_c_auto_refresh_includes = 1
			let g:syntastic_shell = "/bin/zsh"
			let g:syntastic_rust_checker= "rustc" 
            let g:syntastic_javascript_checker = ["eslint"]
            let g:syntastic_javascript_eslint_exec = "eslint"

            let g:formatters_javascript = ['eslint']
            let g:formatdef_eslint = '"SRC=eslint-temp-${RANDOM}.js; cat - >$SRC; eslint --fix $SRC >/dev/null 2>&1; cat $SRC | perl -pe \"chomp if eof\"; rm -f $SRC"'

		"}Syntastic 
		"Rainbow{
        "
			au VimEnter * RainbowParenthesesToggle
			au Syntax * RainbowParenthesesLoadRound
			au Syntax * RainbowParenthesesLoadSquare
			au Syntax * RainbowParenthesesLoadBraces
		"}
		"Yodao translator{
			"vnoremap <silent> <C-T> :<C-u>Ydv<CR>
			"nnoremap <silent> <C-T> :<C-u>Ydc<CR>
			"noremap <leader>yd :<C-u>Yde<CR>
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
			let g:airline_extensions = ['tabline'] ",'syntastic']
			let g:airline_powerline_fonts = 1
			let g:airline_theme='simple'
  			let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
			let g:airline#extensions#syntastic#enabled = 1
			let g:airline#extensions#ycm#enabled = 1
			let g:airline#extensions#tabline#enabled = 1
			let g:airline#extensions#tagbar#enabled = 1
			let g:airline#extensions#branch#enabled = 1
            let g:airline#extensions#branch#vcs_priority = ["git", "mercurial"]
			let g:airline#extensions#ctrlp#color_template = 'insert' 
			let g:airline#extensions#ctrlp#color_template = 'normal'
			let g:airline#extensions#ctrlp#color_template = 'visual'
			let g:airline#extensions#ctrlp#color_template = 'replace'
            let g:airline#extensions#branch#empty_message = ''
		"}
		"Emmet{
			let g:user_emmet_expandabbr_key = '<C-e>'
		"}
		"ultisnips{
			"let g:UltiSnipsExpandTrigger = "<leader><CR>"
			"let g:UltiSnipsJumpForwardTrigger = "<C-j>"
			"let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
			let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
			let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
			let g:SuperTabDefaultCompletionType = '<C-n>'
			let g:UltiSnipsExpandTrigger = "<tab>"
			let g:UltiSnipsJumpForwardTrigger = "<tab>"
			let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
		"}
		"Haskell{
            let hs_highlight_boolean = 1
            let hs_highlight_type = 1
            let hs_highlight_more_types = 1
            let hs_highlight_debug = 1
            let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
            let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
            let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
            let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
            let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
            let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
            let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
            let g:haskell_indent_if = 3
            let g:haskell_indent_case = 2
            let g:haskell_indent_let = 4
            let g:haskell_indent_where = 6
            let g:haskell_indent_do = 3
            let g:haskell_indent_in = 1
            let g:haskell_indent_guard = 2
		"}
        "vim-go{
            let g:go_auto_type_info = 1
            let g:go_fmt_autosave = 0
            let g:go_def_reuse_buffer = 1
        "}
        "gutentags{
            " gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
            let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

            " 所生成的数据文件的名称
            let g:gutentags_ctags_tagfile = '.tags'

            " 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
            let s:vim_tags = expand('~/.cache/tags')
            let g:gutentags_cache_dir = s:vim_tags

            " 配置 ctags 的参数
            let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
            let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
            let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

            " 检测 ~/.cache/tags 不存在就新建
            if !isdirectory(s:vim_tags)
                silent! call mkdir(s:vim_tags, 'p')
            endif
        "}
	"}
"}
"if filereadable
"endif

