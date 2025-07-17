-- theme_nord.lua

local M = {}

local nord = { -- https://www.nordtheme.com/docs/colors-and-palettes
	-- Polar Night
	nord0 = "#2e3440",
	nord1 = "#3b4252",
	nord2 = "#434c5e",
	nord3 = "#4c566a",
	-- Snow Storm
	nord4 = "#d8dee9",
	nord5 = "#e5e9f0",
	nord6 = "#eceff4",
	-- Frost
	nord7 = "#8fbcbb",
	nord8 = "#88c0d0",
	nord9 = "#81a1c1",
	nord10 = "#5e81ac",
	-- Aurora
	nord11 = "#bf616a",
	nord12 = "#d08770",
	nord13 = "#ebcb8b",
	nord14 = "#a3be8c",
	nord15 = "#b48ead",
}

function M.apply(config)
	config.colors = {
		foreground = nord.nord4,
		background = nord.nord0,
		cursor_bg = nord.nord4,
		cursor_fg = nord.nord0,
		cursor_border = nord.nord4,
		selection_fg = nord.nord0,
		selection_bg = nord.nord6,
		scrollbar_thumb = nord.nord10,
		split = nord.nord2,

		ansi = {
			nord.nord0,
			nord.nord11,
			nord.nord14,
			nord.nord13,
			nord.nord10,
			nord.nord15,
			nord.nord8,
			nord.nord5,
		},
		brights = {
			nord.nord3,
			nord.nord11,
			nord.nord14,
			nord.nord13,
			nord.nord9,
			nord.nord15,
			nord.nord7,
			nord.nord6,
		},

		-- Couleurs personnalisées pour QuickSelect
		quick_select_label_bg = { Color = nord.nord12 },
		quick_select_label_fg = { Color = nord.nord0 },
		quick_select_match_bg = { Color = nord.nord10 },
		quick_select_match_fg = { Color = nord.nord6 },
	}

	return config
end

return M
