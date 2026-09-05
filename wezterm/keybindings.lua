-- keybindings.lua
local wezterm = require("wezterm")

return {

	{
		key = "Enter",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitPane({
			direction = "Right",
			size = { Percent = 30 },
			top_level = false,
		}),
	},
	{
		key = "M",
		mods = "CTRL|SHIFT",
		action = wezterm.action.EmitEvent("toggle-theme"),
	},
}
