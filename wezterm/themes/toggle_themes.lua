-- themes/toggle_themes.lua
local wezterm = require("wezterm")

wezterm.on("toggle-theme", function(window)
	local overrides = window:get_config_overrides() or {}

	if overrides.color_scheme == "Atelierseaside (light) (terminal.sexy)" then
		-- Revenir à ton thème personnalisé
		overrides.color_scheme = nil -- remet le thème de base (thème Nord appliqué au démarrage)
	else
		-- Appliquer un thème clair intégré
		overrides.color_scheme = "Atelierseaside (light) (terminal.sexy)"
	end

	window:set_config_overrides(overrides)
end)
