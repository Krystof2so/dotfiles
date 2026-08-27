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

# --- 4. Outils Python (pyenv) --- #
source "$HOME/dotfiles/zsh/python.zsh"

# --- 5. Plugins Zsh --- #
source "$HOME/dotfiles/zsh/plugins.zsh"

# --- 6. Outils Rust --- #
source "$HOME/dotfiles/zsh/rust.zsh"

# --- 7. Prompt personnalisé --- #
source "$HOME/dotfiles/zsh/prompt.zsh"

# --- 8. Alias --- #
source "$HOME/dotfiles/zsh/aliases.zsh"

# --- 9. Intégration WezTerm --- #
source "$HOME/dotfiles/wezterm/wezterm.sh"

