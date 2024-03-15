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

function ToggleQuickFix()
    local qf_open = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win["quickfix"] == 1 then
            qf_open = true
        end
    end
    if qf_open == true then
        vim.cmd("cclose")
        return
    end
    if not vim.tbl_isempty(vim.fn.getqflist()) then
        vim.cmd("copen")
    end
end

function AsyncRun(cmd, args, cwd, env)
    local Job = require 'plenary.job'
    Job:new({
        command = cmd,
        args = args,
        env = env,
        on_exit = function (j, ret)
            print(ret)
            print(j:result())
        end
    })
end

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
