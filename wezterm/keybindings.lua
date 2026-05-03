-- keybindings.lua
local wezterm = require("wezterm")

return {
	{ -- Bascule entre les variantes du thème 'RosePine'
		key = "M",
		mods = "CTRL|SHIFT", -- modificateurs
		action = wezterm.action.EmitEvent("toggle-theme"), -- déclenche l’événement
	},
	{ -- Ouvre un nouveau panneau à droite avec focus
		key = "Enter",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitPane({
			direction = "Right",
			size = { Percent = 30 },
			top_level = false,
		}),
	},
}
