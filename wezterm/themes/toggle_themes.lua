-- ##################################
-- # themes/toggle_themes.lua       #
-- # Pour basculer entre les thèmes #
-- ##################################

-- [[
-- Pour un choix de thème intégré :
-- https://wezterm.org/colorschemes/index.html
-- ]]

local wezterm = require "wezterm"

-- [[
-- Enregistrement d'une fonction callback
-- 'wezterm.on(...)' permet d’écouter des événements personnalisés déclenchés
-- via un raccourci clavier.
-- 'window' = objet qui représente la fenêtre WezTerm dans laquelle on agit.
-- ]]
wezterm.on("toggle-theme", function(window)
  -- Récupération des éventuelles surcharges de la fenêtre :
  local overrides = window:get_config_overrides() or {}
  -- Si thème clair actif, revenir au thème personnalisé de base (appliqué au démarrage) :
  if overrides.color_scheme == "Atelierseaside (light) (terminal.sexy)" then
    overrides.color_scheme = nil -- Suppression de la surcharge pour appliquer le thème personnalisé
  else
    -- Sinon, on applique le thème clair intégré :
    overrides.color_scheme = "Atelierseaside (light) (terminal.sexy)"
  end
  -- Appliquer les surcharges pour la fenêtre actuelle.
  -- Pour une nouvelle fenêtre, cela reste le thème par défaut.
  -- Mise à jour automatique, sans redémarrage.
  window:set_config_overrides(overrides)
end)
