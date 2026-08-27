#!/usr/bin/env zsh

###########################################
# FICHIER PRINCIPAL ZSHRC                 #
# Charge les configurations externalisées #
###########################################

# --- 1. Fonctions utilitaires (A CHARGER EN PREMIER) ---
source "$HOME/dotfiles/zsh/utils.zsh"

# --- 2. Autocomplétion --- #
fpath+=~/.zfunc
autoload -Uz compinit && compinit

# --- 3. Environnement de base --- #
source "$HOME/dotfiles/zsh/env.zsh"

# --- 4. Plugins Zsh --- #
source "$HOME/dotfiles/zsh/plugins.zsh"

# --- 5. Prompt personnalisé --- #
source "$HOME/dotfiles/zsh/prompt.zsh"

# --- 6. Alias --- #
source "$HOME/dotfiles/zsh/aliases.zsh"

# --- 7. Outils (chargement conditionnel si mise à jour nécessaire) ---
if needs_global_update; then
  echo "🔄 Mise à jour automatique de tous les outils..."
  source "$HOME/dotfiles/zsh/tools/zinit.zsh"
  source "$HOME/dotfiles/zsh/tools/rust.zsh"
  source "$HOME/dotfiles/zsh/tools/python.zsh"
  date +%s >| "$HOME/.zinit-auto-update"  # Met à jour le fichier central
  echo "\n ✅ Toutes les mises à jour sont terminées."
fi

# --- 8. Intégration WezTerm --- #
source "$HOME/dotfiles/wezterm/wezterm.sh"

