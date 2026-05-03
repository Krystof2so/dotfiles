-- ##################################
-- # themes/toggle_themes.lua       #
-- # Pour basculer entre les thèmes #
-- ##################################

-- [[
-- Cycle entre les 3 variantes Rosé Pine :
--   RosePineMain  →  RosePineMoon  →  RosePineDawn  →  RosePineMain  → …
--
-- Chaque variante est identifiée par son nom de color_scheme (string).
-- Le plugin ayant déjà enregistré les palettes dans config.color_schemes
-- (voir wezterm.lua), on peut basculer simplement via overrides.color_scheme.
-- ]]

local wezterm = require("wezterm")

-- Ordre du cycle
local VARIANTS = {
  "RosePineMain",
  "RosePineMoon",
  "RosePineDawn",
}

-- Opacité associée à chaque variante
-- Dawn est un thème clair : on monte l'opacité pour un meilleur contraste.
local OPACITY = {
  RosePineMain = 0.85,
  RosePineMoon = 0.85,
  RosePineDawn = 0.92,
}

-- Retourne l'index du thème actuel dans VARIANTS (1-based), ou 1 par défaut
local function current_index(scheme)
  for i, name in ipairs(VARIANTS) do
    if name == scheme then
      return i
    end
  end
  return 1
end

-- [[
-- Écoute l'événement "toggle-theme" déclenché par un raccourci clavier.
-- 'window' = fenêtre WezTerm dans laquelle l'action est effectuée.
-- ]]
wezterm.on("toggle-theme", function(window)
  local overrides = window:get_config_overrides() or {}

  -- Thème actuellement actif (override ou thème par défaut)
  local current = overrides.color_scheme or "RosePineMain"

  -- Passer au suivant dans le cycle
  local next_index = (current_index(current) % #VARIANTS) + 1
  local next_theme = VARIANTS[next_index]

  overrides.color_scheme             = next_theme
  overrides.window_background_opacity = OPACITY[next_theme]

  -- Mise à jour à chaud, sans redémarrage
  window:set_config_overrides(overrides)

  -- Notification visuelle du thème actif
  window:toast_notification("WezTerm", "Thème : " .. next_theme, nil, 2000)
end)
