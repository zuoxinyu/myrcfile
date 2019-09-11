filetype plugin indent on
syntax on
colorscheme one
"Plugins Configuration {
    " Coc.vim {
        " Use tab for trigger completion with characters ahead and navigate.
        " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
        inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

        function! s:check_back_space() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        " Use <c-space> to trigger completion.
        inoremap <silent><expr> <c-space> coc#refresh()

        " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
        " Coc only does snippet and additional edit on confirm.
        inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
        inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"    "回车即选中当前项
        " Use `[c` and `]c` to navigate diagnostics
        nmap <silent> [c <Plug>(coc-diagnostic-prev)
        nmap <silent> ]c <Plug>(coc-diagnostic-next)

        " Remap keys for gotos
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)

        " Use K to show documentation in preview window
        nnoremap <silent> K :call <SID>show_documentation()<CR>

        function! s:show_documentation()
          if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
          else
            call CocAction('doHover')
          endif
        endfunction

        " Highlight symbol under cursor on CursorHold
        autocmd CursorHold * silent call CocActionAsync('highlight')
        hi CocHighlightText ctermfg=Yellow guifg=#ffff00

        " Remap for rename current word
        nmap <leader>rn <Plug>(coc-rename)

        " Remap for format selected region
        "xmap <leader>f  <Plug>(coc-format-selected)
        "nmap <leader>f  <Plug>(coc-format-selected)

        augroup mygroup
          autocmd!
          " Setup formatexpr specified filetype(s).
          autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
          " Update signature help on jump placeholder
          autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        augroup end

        " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
        xmap <leader>a  <Plug>(coc-codeaction-selected)
        nmap <leader>a  <Plug>(coc-codeaction-selected)

        " Remap for do codeAction of current line
        nmap <leader>ac  <Plug>(coc-codeaction)
        " Fix autofix problem of current line
        nmap <leader>qf  <Plug>(coc-fix-current)

        " Use `:Format` to format current buffer
        command! -nargs=0 Format :call CocAction('format')

        " Use `:Fold` to fold current buffer
        command! -nargs=? Fold :call     CocAction('fold', <f-args>)


        " Add diagnostic info for https://github.com/itchyny/lightline.vim
        let g:lightline = {
              \ 'colorscheme': 'wombat',
              \ 'active': {
              \   'left': [ [ 'mode', 'paste' ],
              \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
              \ },
              \ 'component_function': {
              \   'cocstatus': 'coc#status'
              \ },
              \ }
    " }
    
    " YouCompleteMe {
        let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
        nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
        " 自动补全配置
        "set completeopt=longest,menu "让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
        autocmd InsertLeave * if pumvisible() == 0|pclose|endif "离开插入模式后自动关闭预览窗口
        let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示
        let g:ycm_collect_identifiers_from_tags_files=1 " 开启 YCM 基于标签引擎
        let g:ycm_min_num_of_chars_for_completion=1 " 从第2个键入字符就开始罗列匹配项
        let g:ycm_cache_omnifunc=0  " 禁止缓存匹配项,每次都重新生成匹配项
        let g:ycm_seed_identifiers_with_syntax=1    " 语法关键字补全
        nnoremap <C-F5> :YcmForceCompileAndDiagnostics<CR> 
        nnoremap <leader>lo :lopen<CR>
        nnoremap <leader>lc :lclose<CR>

        "set completeopt=menu,menuone
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
    
    "TagBar {
        "nmap <F9> :TagbarToggle<CR>
    "}TagBar
    
    "NerdTree {
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
    
    "Rainbow {
        au VimEnter * RainbowParenthesesToggle
        au Syntax * RainbowParenthesesLoadRound
        au Syntax * RainbowParenthesesLoadSquare
        au Syntax * RainbowParenthesesLoadBraces
    "}
    
    "Easymotion {
        let g:Easymotion_do_shade = 0
        let g:Easymotion_use_upper = 1
        let g:Easymotion_keys = 'ASDFGHJKLQWERTYUIOP;'
        let g:Easymotion_inc_highlight = 0
        hi EasyMotionTarget ctermbg=none ctermfg=green
    "}
    
    "Airline{
        let g:airline_theme='one'
        "let g:airline_extensions = ['branch', 'fugitiveline', 'quickfix', 'tabline'] ",'syntastic']
        let g:airline_powerline_fonts = 1
        let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
        "let g:airline#extensions#syntastic#enabled = 1
        "let g:airline#extensions#ycm#enabled = 1
        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tagbar#enabled = 1
        let g:airline#extensions#branch#enabled = 1 
        "let airline#extensions#ale#error_symbol = 'E:'
        "let airline#extensions#ale#warning_symbol = 'W:'
        let g:airline#extensions#branch#vcs_priority = ["git"]
        let g:airline#extensions#branch#empty_message = 'branch:empty'
        let g:airline#extensions#nrrwrgn#enabled = 1
        "let g:airline_left_sep = "\uE0C0"
        let g:airline_left_sep = ""
        let g:airline_right_sep = ""
    "}
    
    "gutentags {
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
    
    "leaderf {
        map <Leader>f :Leaderf self<CR>
        map <C-p> :LeaderfMruCwd<CR>
        map <C-f> :LeaderfRgInteractive<CR>
        map <C-t> :Leaderf function<CR>
        map <C-b> :Leaderf buffer<CR>
    "}

    "HTML {
        autocmd FileType html,css,vue let g:user_emmet_expandabbr_key = '<C-e>'
    "}
    
    "ultisnips {
        let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
        let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
        let g:SuperTabDefaultCompletionType = '<C-n>'
        let g:UltiSnipsExpandTrigger = "<tab>"
        let g:UltiSnipsJumpForwardTrigger = "<tab>"
        let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
    "}
    
    "Haskell {
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
    
    "vim-go {
        let g:go_auto_type_info = 1
        let g:go_fmt_autosave = 0
        let g:go_def_reuse_buffer = 1
        let g:go_def_mapping_enabled = 0
        let g:go_def_mapping_enabled = 0
        let g:go_def_mapping_enabled = 0
        "let g:go_code_completion_enabled = 1
        let g:go_doc_keywordprg_enabled = 0
        let g:go_fmt_command = "goimports"
        let go_highlight_functions = 1
        let g:go_highlight_types = 1
        let go_highlight_structs = 1
        let go_highlight_operators = 1
        let go_highlight_build_constraints = 1
        au FileType go set nofoldenable
        au FileType go nmap <leader>2 :GoFmt<CR>
        au FileType go nmap <leader>3 :GoTestFunc<CR>
        au FileType go nmap <leader>4 :GoTest<CR>
        au FileType go nmap <leader>5 :GoRun<CR>
        au FileType go nmap <leader>jr :GoReferrers<CR>
        au FileType go nnoremap <silent> K :call <SID>show_documentation()<CR>
    "}

    "Rust {
        autocmd FileType rust nmap <leader>2 :RustFmt<CR> 
        autocmd FileType rust nmap <leader>3 :RustTest<CR> 
        autocmd FileType rust nmap <leader>4 :RustTest!<CR> 
        autocmd FileType rust nmap <leader>5 :Cargo run<CR> 
    "}

    "Cpp/C {
        autocmd FileType c,cpp nmap <leader>4 :CMake<CR> 
        autocmd FileType c,cpp nmap <leader>5 :make<CR> 
        autocmd FileType c,cpp,rust packadd termdebug
    "}    
"}
