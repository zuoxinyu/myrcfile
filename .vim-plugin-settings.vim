filetype plugin indent on
syntax on
"Plugins Configuration {
    "3rd colorscheme {
        colorscheme gruvbox
        " Fix background color under transparent terminals
        highlight Normal     ctermbg=NONE guibg=NONE
        highlight NonText    ctermbg=NONE guibg=NONE
        highlight LineNr     ctermbg=NONE guibg=NONE
        highlight SignColumn ctermbg=NONE guibg=NONE

        " highlight trailing spaces
        highlight ExtraWhitespace ctermbg=red guibg=red
        match ExtraWhitespace /\s\+$/
        command! -nargs=0 RemoveTrailingSpaces :%s/\s\+$//
    "}

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
        nmap <silent> gs :call CocAction('jumpDefinition', 'split')<CR>
        nmap <silent> gv :call CocAction('jumpDefinition', 'vsplit')<CR>
        nmap <silent> gt :call CocAction('jumpDefinition', 'tabe')<CR>
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
        hi CocHighlightText ctermfg=Yellow guifg=#ffff00 ctermbg=NONE

       augroup mygroup
          autocmd!
          " Setup formatexpr specified filetype(s).
          autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
          " Update signature help on jump placeholder
          autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        augroup end


        " Use `:Format` to format current buffer
        command! -nargs=0 Format :call CocAction('format')

        " Use `:Fold` to fold current buffer
        command! -nargs=? Fold :call CocAction('fold', <f-args>)

        " Split if dest file is not current file
        function! s:smart_jump(line)
          let args = split(a:line, ' ')
          let cursorcmd = args[1]
          let file = args[2]
          let current_file = fnameescape(fnamemodify(expand('%'), ':~:.'))
          if (file != current_file)
            execute 'split +call\ '.cursorcmd.' '.file
          else
            execute 'call '.cursorcmd
          endif
        endfunction

        " Custom jump command
        command! -nargs=? CocSmartJump :call s:smart_jump(<f-args>)
        " auto format and import
        autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

        " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
        nmap <leader>a  :CocAction<CR>
        nmap <leader>c  :CocCommand<CR>
        nmap <leader>s  :CocSearch <C-r><C-w><CR>
        " Remap for do codeAction of current line
        nmap <leader>ac  <Plug>(coc-codeaction)
        " Fix autofix problem of current line
        nmap <leader>qf  <Plug>(coc-fix-current)
        " Remap for rename current word
        nmap <leader>rn <Plug>(coc-rename)
        nmap <F10> :CocCommand explorer<CR>

        nnoremap <expr><C-f> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-f>"
        nnoremap <expr><C-b> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-b>"
        " Remap for format selected region
        "xmap <leader>f  <Plug>(coc-format-selected)
        "nmap <leader>f  <Plug>(coc-format-selected)
    " }

    "TagBar {
        nmap <F9> :TagbarToggle<CR>
        let g:tagbar_type_go = {
                    \ 'ctagstype' : 'go',
                    \ 'kinds'     : [
                        \ 'p:package',
                        \ 'i:imports:1',
                        \ 'c:constants',
                        \ 'v:variables',
                        \ 't:types',
                        \ 'n:interfaces',
                        \ 'w:fields',
                        \ 'e:embedded',
                        \ 'm:methods',
                        \ 'r:constructor',
                        \ 'f:functions'
                    \ ],
                    \ 'sro' : '.',
                    \ 'kind2scope' : {
                        \ 't' : 'ctype',
                        \ 'n' : 'ntype'
                    \ },
                    \ 'scope2kind' : {
                        \ 'ctype' : 't',
                        \ 'ntype' : 'n'
                    \ },
                    \ 'ctagsbin'  : 'gotags',
                    \ 'ctagsargs' : '-sort -silent'
                    \ }
    "}TagBar

    "NerdTree {
        "nmap <F10> :NERDTreeToggle<CR>
        "autocmd vimenter * NERDTree "Auto open at start vim
        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$', '\.ui$', '^\node_modules$']
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
        let g:airline_theme='simple'
        let g:airline_extensions = ['branch', 'coc', 'fugitiveline', 'quickfix', 'tabline',  'tagbar']
        let g:airline_powerline_fonts = 1
        let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
        let g:airline#extensions#coc#enabled = 1
        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tagbar#enabled = 1
        let g:airline#extensions#branch#enabled = 1
        let g:airline#extensions#branch#vcs_priority = ["git"]
        let g:airline#extensions#branch#empty_message = 'branch:empty'
        let g:airline#extensions#nrrwrgn#enabled = 1
        let g:airline_left_sep = ''
        let g:airline_right_sep = ''
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
        let g:Lf_WindowPosition = 'popup'
        let g:Lf_HideHelp = 1
        let g:Lf_PreviewInPopup = 1
        map <Leader>f :Leaderf self<CR>
        "map <C-p> :LeaderfFile<CR>
        map <C-t> :Leaderf function<CR>
        "map <C-b> :Leaderf buffer<CR>
        noremap <C-f> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
        noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
    "}

    "fzf {
        let g:fzf_preview_window = 'right:60%'
        let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
        map <C-p> :GFiles <CR>
        map <C-c> :Commits <CR>
        map <C-q> :Buffers <CR>
    "}

    "asyncrun{
        let g:asyncrun_mode='term'
    "}

    "HTML {
        au BufNewFile,BufRead *.html,*.js,*.vue,*.jsx let g:user_emmet_expandabbr_key = '<C-e>'
        au BufNewFile,BufRead *.html,*.js,*.vue,*.jsx set tabstop=2
        au BufNewFile,BufRead *.html,*.js,*.vue,*.jsx set softtabstop=2
        au BufNewFile,BufRead *.html,*.js,*.vue,*.jsx set shiftwidth=2
        au BufNewFile,BufRead *.html,*.js,*.vue,*.jsx set expandtab
        au BufNewFile,BufRead *.html,*.js,*.vue,*.jsx set autoindent
        au BufNewFile,BufRead *.html,*.js,*.vue,*.jsx set fileformat=unix
        au BufNewFile,BufRead *.vue set filetype=vue
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
        let g:go_code_completion_enabled = 0
        let g:go_def_reuse_buffer = 0
        let g:go_def_mapping_enabled = 0
        let g:go_doc_popup_window = 1
        let g:go_doc_keywordprg_enabled = 0
        let g:go_fmt_autosave = 0
        let g:go_metalinter_command = "golangci-lint"
        let g:go_fmt_command = "goimports"
        let g:go_info_mode = 'gopls'
        let g:go_highlight_functions = 1
        let g:go_highlight_types = 1
        let g:go_highlight_structs = 1
        let g:go_highlight_operators = 1
        let g:go_highlight_format_strings = 1
        let g:go_highlight_build_constraints = 1
        let g:go_highlight_fields = 1
        let g:go_fold_enable = ['block', 'import', 'varconst', 'package_comment']
        "au FileType go set nofoldenable
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
