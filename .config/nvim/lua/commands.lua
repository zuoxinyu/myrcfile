vim.cmd [[
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
    command! -range=% -nargs=0 RemoveTrailingSpaces :%s/\s\+$//
    command! -range=% -nargs=0 RenameSnakeCaseToCamel :<line1>,<line2>s#_\(\l\)#\u\1#g
    command! -range=% -nargs=0 RenameSnakeCaseToPascal :<line1>,<line2>s#\(\%(\<\l\+\)\%(_\)\@=\)\|_\(\l\)#\u\1\2#g
]]

