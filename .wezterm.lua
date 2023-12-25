-- Pull in the wezterm API
local wezterm = require 'wezterm'
local keys = require 'key'

-- This table will hold the configuration.
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_background_opacity = 0.8
config.win32_system_backdrop = 'Tabbed'
config.color_scheme = 'Gruvbox Material (Gogh)'
config.font = wezterm.font('JetBrains Mono')
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.default_prog = { 'pwsh.exe' }
config.keys = keys.keys
local launch_menu = {}
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  for _, vsvers in
  ipairs(
    wezterm.glob('Microsoft Visual Studio/20*', 'C:/Program Files (x86)')
  )
  do
    local year = vsvers:gsub('Microsoft Visual Studio/', '')
    table.insert(launch_menu, {
      label = 'x64 Native Tools VS ' .. year,
      args = {
        'cmd.exe',
        '/k',
        'C:/Program Files (x86)/'
        .. vsvers
        .. '/BuildTools/VC/Auxiliary/Build/vcvars64.bat',
      },
    })
  end
end
config.launch_menu = launch_menu
return config
