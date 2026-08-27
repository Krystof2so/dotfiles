###################################
# GESTION DES PLUGINS ZSH (ZINIT) #
###################################

# --- Fonction générique pour les mises à jour automatiques --- #
auto_update() {
  local tool_name="$1"
  local update_command="$2"
  local update_file="$HOME/.${tool_name}-auto-update"
  local last_update=$([[ -f "$update_file" ]] && cat "$update_file" || echo 0)
  local now=$(date +%s)
  local interval=604800  # 7 jours en secondes
  
  if (( now - last_update > interval )); then
    echo "--- 🛠️ MISE A JOUR DES PLUGINS ZSH ---"
    echo "🔄 Mise à jour automatique : $tool_name"
    eval "$update_command"
    date +%s >| "$update_file"
  fi
}

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
zinit ice depth=1; zinit light zsh-users/zsh-autosuggestions
zinit ice depth=1; zinit light zsh-users/zsh-syntax-highlighting
zinit ice depth=1; zinit light zsh-users/zsh-completions

# --- Configuration des plugins --- #
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#8c8c8c'
ZSH_HIGHLIGHT_STYLES[path]='fg=#ebcb8b'

# --- Mise à jour automatique de Zinit et des plugins --- #
zinit_update() {
  echo "🔄 Mise à jour de Zinit..."
  zinit self-update && echo "✅ Zinit à jour."
  zinit update --all && echo "✅ Plugins à jour."
  echo "\n"
}

auto_update "zinit" "zinit_update"
