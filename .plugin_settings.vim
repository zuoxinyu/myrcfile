filetype plugin indent on
syntax on
"Plugins Configuration{
    " ALE {
        let g:ale_set_quickfix=1
        let g:ale_echo_msg_error_str='Error'
        let g:ale_echo_msg_warning_str='⚠ Warning'
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
        let g:ale_sign_error = "✗"
        let g:ale_sign_warn = "⚠"
        hi! clear SpellBad
        hi! clear SpellCap
        hi! clear SpellRare
        hi! SpellBad gui=undercurl guisp=red
        hi! SpellCap gui=undercurl guisp=blue
        hi! SpellRare gui=undercurl guisp=magenta
    " }
    "
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
        let g:syntastic_c_include_dirs = ["include","./"]
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
        let g:airline_theme='simple'
        let g:airline_extensions = ['ale', 'branch', 'tagbar', 'ycm', 'fugitiveline', 'quickfix', 'tabline'] ",'syntastic']
        let g:airline_powerline_fonts = 1
        let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
        let g:airline#extensions#syntastic#enabled = 1
        let g:airline#extensions#ycm#enabled = 1
        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tagbar#enabled = 1
        let g:airline#extensions#branch#enabled = 1 
        let g:airline#extensions#branch#empty_message = ''
        let g:airline#extensions#branch#vcs_priority = ["git", "mercurial"]
        let g:airline#extensions#ctrlp#color_template = 'insert' 
        let g:airline#extensions#ctrlp#color_template = 'normal'
        let g:airline#extensions#ctrlp#color_template = 'visual'
        let g:airline#extensions#ctrlp#color_template = 'replace'
        let airline#extensions#ale#error_symbol = 'E:'
        let airline#extensions#ale#warning_symbol = 'W:'
        let g:airline#extensions#branch#vcs_priority = ["git"]
        let g:airline#extensions#branch#empty_message = 'branch:empty'
        let g:airline#extensions#nrrwrgn#enabled = 1
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
