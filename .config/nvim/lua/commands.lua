vim.cmd [[
    function! CopyMatches(reg)
        let hits = []
        %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
        let reg = empty(a:reg) ? '+' : a:reg
        execute 'let @'.reg.' = join(hits, "\n") . "\n"'
    endfunction

    function! ToggleQuickfix()
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
    command! -register CopyMatches call CopyMatches(<q-reg>)
    command! -nargs=0 ToggleQuickfix :call ToggleQuickfix()
]]

-- vim.cmd [[
--   augroup config_reload
--     autocmd!
--     autocmd BufWritePost $HOME/.config/nvim/lua/*.lua source <afile> | lua vim.notify('config reloaded')
--   augroup end
-- ]]
--
-- vim.cmd [[
--   augroup packer_reload
--     autocmd!
--     autocmd BufWritePost $HOME/.config/nvim/lua/plugins.lua source <afile> | PackerSync
--   augroup end
-- ]]
