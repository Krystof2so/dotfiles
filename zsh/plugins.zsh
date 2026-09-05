###################################
# GESTION DES PLUGINS ZSH (ZINIT) #
###################################

# --- Installation et chargement de Zinit --- #
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
  print -P "%F{33} %F{220}Installation de Zinit...%f"
  mkdir -p "$HOME/.local/share/zinit"
  git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# --- Annexes Zinit --- #
zinit light-mode for \
  zdharma-continuum/zinit-annex-as-monitor \
  zdharma-continuum/zinit-annex-bin-gem-node \
  zdharma-continuum/zinit-annex-patch-dl \
  zdharma-continuum/zinit-annex-rust

# --- Plugins Zsh --- #
zinit ice blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions
autoload -Uz compinit && compinit
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# --- Complétions d'outils externes (après compinit) --- #
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# --- Configuration des plugins --- #
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#8c8c8c'
ZSH_HIGHLIGHT_STYLES[path]='fg=#ebcb8b'

