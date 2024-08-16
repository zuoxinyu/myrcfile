local loop = vim.loop
local api = vim.api

vim.cmd [[
    function! CopyMatches(reg)
        let hits = []
        %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
        let reg = empty(a:reg) ? '+' : a:reg
        execute 'let @'.reg.' = join(hits, "\n") . "\n"'
    endfunction

    function! ToggleQuickfix()
        if empty(filter(getwininfo(), 'v:val.quickfix'))
            botright copen
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
    command! -nargs=+ -complete=dir -bar Grep lua AsyncGrep(<q-args>)
]]

function ToggleQuickFix()
    local qf_open = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win['quickfix'] == 1 then
            qf_open = true
        end
    end
    if qf_open == true then
        vim.cmd 'cclose'
        return
    end
    if not vim.tbl_isempty(vim.fn.getqflist()) then
        vim.cmd 'botright copen'
    end
end

function AsyncRun(cmd, args)
    local stdout = loop.new_pipe(false)
    local stderr = loop.new_pipe(false)

    local results = {}
    local function onread(err, data)
        if err then
            print('ERROR: ', err)
            -- TODO handle err
        end
        if data then
            local vals = vim.split(data, '\n')
            for _, d in pairs(vals) do
                if d == '' then
                    goto continue
                end
                table.insert(results, d)
                ::continue::
            end
        end
    end

    local function setQF()
        vim.fn.setqflist({}, 'r', { title = 'Async Run Command ' .. cmd, lines = results })
        api.nvim_command 'cwindow'
        local count = #results
        for i = 0, count do
            results[i] = nil
        end -- clear the table for the next search
    end

    local handle
    handle = vim.loop.spawn(
        cmd,
        {
            args = args,
            stdio = { nil, stdout, stderr },
        },
        vim.schedule_wrap(function()
            stdout:read_stop()
            stderr:read_stop()
            stdout:close()
            stderr:close()
            handle:close()
            setQF()
        end)
    )
    vim.loop.read_start(stdout, onread)
    vim.loop.read_start(stderr, onread)
end

function AsyncGrep(term)
    local stdout = vim.loop.new_pipe(false)
    local stderr = vim.loop.new_pipe(false)

    local results = {}
    local function onread(err, data)
        if err then
            print('ERROR: ', err)
            -- TODO handle err
        end
        if data then
            local vals = vim.split(data, '\n')
            for _, d in pairs(vals) do
                if d == '' then
                    goto continue
                end
                table.insert(results, d)
                ::continue::
            end
        end
    end

    local function setQF()
        vim.fn.setqflist({}, 'r', { title = 'Search Results', lines = results })
        api.nvim_command 'cwindow'
        local count = #results
        for i = 0, count do
            results[i] = nil
        end -- clear the table for the next search
    end

    local handle
    handle = vim.loop.spawn(
        'rg',
        {
            args = { term, '--vimgrep', '--smart-case' },
            stdio = { nil, stdout, stderr },
        },
        vim.schedule_wrap(function()
            stdout:read_stop()
            stderr:read_stop()
            stdout:close()
            stderr:close()
            handle:close()
            setQF()
        end)
    )
    vim.loop.read_start(stdout, onread)
    vim.loop.read_start(stderr, onread)
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
