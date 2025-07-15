-- colors.lua
local M = {}

function M.theme_config(config)
	config.color_scheme = "Nord" -- Théme de couleur (à choisir parmi ceux proposés)

	config.colors = {
		scrollbar_thumb = "#81a1c1", -- Couleur du curseur de la scrollbar
	}
	return config
end

return M
