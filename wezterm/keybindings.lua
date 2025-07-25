-- keybindings.lua
local wezterm = require "wezterm"

return {
  { -- Bascule entre le thème 'nord' persnnalisé et le thème 'Atelierseaside (light) (terminal.sexy)'
    key = "M",
    mods = "CTRL|SHIFT", -- modificateurs
    action = wezterm.action.EmitEvent "toggle-theme", -- déclenche l’événement
  },
}
