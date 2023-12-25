local M = {}
local wezterm = require 'wezterm'
local act = wezterm.action
local mod = 'ALT'
M.leader = { key = 'a', mods = 'ALT' }
M.keys = {
    { key = 'h',          mods = mod,         action = act.ActivatePaneDirection 'Left', },
    { key = 'l',          mods = mod,         action = act.ActivatePaneDirection 'Right', },
    { key = 'k',          mods = mod,         action = act.ActivatePaneDirection 'Up', },
    { key = 'j',          mods = mod,         action = act.ActivatePaneDirection 'Down', },
    { key = 'LeftArrow',  mods = mod,         action = act.ActivatePaneDirection 'Left', },
    { key = 'RightArrow', mods = mod,         action = act.ActivatePaneDirection 'Right', },
    { key = 'UpArrow',    mods = mod,         action = act.ActivatePaneDirection 'Up', },
    { key = 'DownArrow',  mods = mod,         action = act.ActivatePaneDirection 'Down', },
    { key = 'w',          mods = mod,         action = act.CloseCurrentPane { confirm = false } },
    { key = 'Enter',      mods = mod,         action = act.SplitPane { direction = 'Right', }, },
    { key = 't',          mods = mod,         action = act.SpawnTab 'CurrentPaneDomain' },
    { key = '-',          mods = mod,         action = act.DecreaseFontSize },
    { key = '=',          mods = mod,         action = act.IncreaseFontSize },
    { key = 'v',          mods = mod,         action = act.SplitVertical { args = {}, }, },
    { key = 'H',          mods = 'LEADER',    action = act.AdjustPaneSize { 'Left', 5 }, },
    { key = 'J',          mods = 'LEADER',    action = act.AdjustPaneSize { 'Down', 5 }, },
    { key = 'K',          mods = 'LEADER',    action = act.AdjustPaneSize { 'Up', 5 } },
    { key = 'L',          mods = 'LEADER',    action = act.AdjustPaneSize { 'Right', 5 }, },
    { key = ' ',          mods = 'ALT|SHIFT', action = act.QuickSelect },
}

for i = 1, 8 do
    table.insert(M.keys, { key = tostring(i), mods = 'ALT', action = act.ActivateTab(i - 1) })
end

return M
