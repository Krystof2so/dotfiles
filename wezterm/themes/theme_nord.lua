-- theme_nord.lua
local nord = require "themes.nord_colors"

local nord_theme = {
  foreground = nord.nord4, -- Couleur du texte
  background = nord.nord0, -- Couleur de l'arrière plan
  cursor_bg = nord.nord15, -- Arrière plan du curseur
  cursor_fg = nord.nord0, -- Couleur du texte sous le curseur
  cursor_border = nord.nord13, -- Bordure du curseur
  selection_fg = nord.nord12, -- Couleur du texte sélectionné
  selection_bg = nord.nord3, -- Couleur de l'arrière plan de la selection
  scrollbar_thumb = nord.nord10, -- Couleur de la barre de défilement
  split = nord.nord14, -- Couleur de séparation entre les volets
  -- Définition des 16 couleurs de base :
  ansi = { -- Les 8 couleurs de base
    -- Pour tester ces couleurs, lancer la commande shell suivante dans le terminal :
    -- "for i in {0..15}; do printf "\033[48;5;${i}m %3d " $i; done; echo"
    nord.nord0,
    nord.nord11,
    nord.nord14,
    nord.nord13,
    nord.nord10,
    nord.nord15,
    nord.nord8,
    nord.nord5,
  },
  brights = { -- Les 8 couleurs "vives"
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
  quick_select_label_bg = { Color = nord.nord0 },
  quick_select_label_fg = { Color = nord.nord12 },
  quick_select_match_bg = { Color = nord.nord0 },
  quick_select_match_fg = { Color = nord.nord14 },
}

return {
  name = "NordPerso",
  colors = nord_theme,
}
