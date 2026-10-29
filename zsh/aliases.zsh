#######################
# ALIAS PERSONNALISÉS #
#######################

# --- Outils CLI --- #

## bat
alias batnp='bat --paging=never'

## eza
alias lsa='eza --icons -la --git --group-directories-first --color-scale --header --total-size --binary --smart-group --blocksize --git-repos-no-status --time-style=+%Y-%m-%d-%H:%M'  # Affichage détaillé
alias tree='eza --tree --icons'  # Affichage arborescence
alias ls='eza --icons --group-directories-first'  # Liste simple

# Rosé Pine — bascule eza dark/light
alias ezadark='ln -sf ~/dotfiles/eza/themes/rose-pine.yml ~/dotfiles/eza/theme.yml && echo "🌙 Rosé Pine Main"'
alias ezalight='ln -sf ~/dotfiles/eza/themes/rose-pine-dawn.yml ~/dotfiles/eza/theme.yml && echo "☀️ Rosé Pine Dawn"'

## fd-find (fd)
alias fd='fdfind'
alias fdf='fdfind --type f'  # fichiers seulement
alias fdd='fdfind --type d'  # dossiers seulement

## git
alias gcm='git commit'
alias gdf='git diff'
alias glog='git log'
alias gst='git status'
alias lazyg='lazygit'

## Zinit
alias zinitup='zinit_update'

## Aptitude
alias apti='sudo aptitude'
alias cleanapt='sudo aptitude autoclean && sudo aptitude clean && echo "✅ Nettoyage aptitude terminé"'

# --- Neovim --- #
nvc() {
  XDG_CONFIG_HOME="$HOME/.config/nvim" \
  XDG_DATA_HOME="$HOME/.local/share/nvim" \
  XDG_STATE_HOME="$HOME/.local/state/nvim" \
  XDG_CACHE_HOME="$HOME/.cache/nvim" \
  NVIM_APPNAME=nvcrafted nvim "$@"
}

nvlazy() {
  XDG_CONFIG_HOME="$HOME/.config/nvim" \
  XDG_DATA_HOME="$HOME/.local/share/nvim" \
  XDG_STATE_HOME="$HOME/.local/state/nvim" \
  XDG_CACHE_HOME="$HOME/.cache/nvim" \
  NVIM_APPNAME=lazyvim nvim "$@"
}

nvtest() {
  XDG_CONFIG_HOME="$HOME/.config/nvim" \
  XDG_DATA_HOME="$HOME/.local/share/nvim" \
  XDG_STATE_HOME="$HOME/.local/state/nvim" \
  XDG_CACHE_HOME="$HOME/.cache/nvim" \
  NVIM_APPNAME=nvtest nvim "$@"
}

# --- Divers --- #
alias dotfiles='cd ~/dotfiles && nvc'
alias lua='lua5.5'
alias grep='grep --color=auto'
alias adios='systemctl poweroff'
alias reboot='systemctl reboot'
alias pyt='python3.14'

# --- Mise à jour des paquets avec interface --- #
aptiup() {
  sudo aptitude update
  local updates=$(aptitude search "~U" | wc -l)
  local new_packages=$(aptitude search "~N" | wc -l)
  if (( updates > 0 || new_packages > 0 )); then
    echo "\033[33m$updates mises à jour, $new_packages nouveaux paquets.\033[0m"
    sudo aptitude
  else
    echo "\033[32mAucune mise à jour disponible.\033[0m"
  fi
}

# --- Recherche avec ripgrep --- #
# Usage : rga <type_de_fichier> <motif> [répertoire]
rga() {
    local filetype="$1"
    local pattern="$2"
    local directory="${3:-.}"  # répertoire courant par défaut

    if [[ -z "$filetype" || -z "$pattern" ]]; then
        echo "Usage: rga <type_de_fichier> <motif> [répertoire]"
        return 1
    fi

    rg --only-matching -t "$filetype" "$pattern" "$directory"
}
