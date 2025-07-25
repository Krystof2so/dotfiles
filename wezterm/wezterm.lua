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

-- Obligatoire : retourne l'objet de configuration pour que WezTerm puisse l'appliquer :
return config
