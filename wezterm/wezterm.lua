-- ##########################################
-- # Configuration personnalisée de WezTerm #
-- ##########################################
-- Import de l'API WezTerm (pour accéder aux fonctions et constantes de WezTerm) :
local wezterm = require "wezterm"
-- Création d'une table qui contiendra les options de configuration.
-- 'config_builder' : accès à l'autocomplétion.
local config = wezterm.config_builder()
-- Charger les raccourcis clavier
config.keys = require "keybindings"
-- Charger la configuration de l'environnement
local env = require "environment"

-- ####################
-- # Gestion du thème #
-- ####################
-- Enregistre l'événement "toggle-theme"
require "themes.toggle_themes"
-- Déclarer le thème perso comme un color_scheme
local nord_theme = require "themes.theme_nord"
config.color_schemes = {
  [nord_theme.name] = nord_theme.colors,
}
-- Appliquer ce thème par défaut
config.color_scheme = nord_theme.name

-- ##################
-- # Configurations #
-- ##################

-- Programme shell utilisé par défaut
config.default_prog = env.shell

-- Variables d'environnement passées au shell
config.set_environment_variables = {
  LANG = env.locale,
  EDITOR = env.editor,
  ZDOTDIR = env.zsh_config_dir,
  WEZTERM_CONFIG_DIR = env.wezterm_config_dir,
  NVIM_CONFIG_DIR = env.nvim_config_dir,
}

-- Personnalisation de la barre d'onglets :
config.window_frame = {
  font_size = 15.0,
}

-- Aspect du volet inactif :
config.inactive_pane_hsb = {
  saturation = 0.5,
  brightness = 0.4,
}

-- Définition de la taille initiale des fenêtres du terminal à l'ouverture :
config.initial_cols = 120 -- 120 caractères de largeur
config.initial_rows = 28 -- 28 lignes de heuteur

-- Personnalisation de l'apparence :
config.font_size = 14 -- Taille de la police

-- Scrolling :
config.scrollback_lines = 3500 -- Nombre de lignes conservées
config.enable_scroll_bar = true -- Active la scroolbar

-- Supprime temporairement le style du texte, pour des résultats plus lisibles en mode QuickSelect
config.quick_select_remove_styling = true

-- Démarrage de Wezterm en plein écran
wezterm.on("gui-startup", function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  local gui_win = window:gui_window() -- Fenêtre GUI
  local overrides = gui_win:get_config_overrides() or {}
  -- Active la transparence à 0.65 dès le démarrage
  overrides.window_background_opacity = 0.65
  gui_win:set_config_overrides(overrides)
  -- Plein écran
  window:gui_window():toggle_fullscreen()
end)

-- Obligatoire : retourne l'objet de configuration pour que WezTerm puisse l'appliquer :
return config
