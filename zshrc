##############################################
# SECTION : ENVIRONNEMENT DE BASE & OPTIONS  #
##############################################

setopt NO_BEEP                # Supprime les sons
setopt AUTO_LIST              # Liste les options de complétion après tab
setopt COMPLETE_IN_WORD       # Complète au milieu d’un mot
setopt INC_APPEND_HISTORY     # Sauvegarde immédiate
setopt SHARE_HISTORY          # Partage entre terminaux
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

export LANG=fr_FR.UTF-8
export LC_TIME=fr_FR.UTF-8

export PATH="$HOME/.local/bin:$PATH"
CDPATH=.:~:/path/to/other/directory

# Fichier d'historique Zsh
HISTFILE=~/.zsh_history
SAVEHIST=10000
HISTSIZE=10000

# Initialisation de l'autocomplétion
fpath+=~/dotfiles/zsh_functions
fpath+=~/.zfunc
autoload -Uz compinit && compinit

###############################################
# SECTION : FONCTIONS PERSONNALISÉES & OUTILS #
###############################################

# Chargement des fonctions personnalisées
source "$HOME/dotfiles/zsh_functions/path.zsh"
source "$HOME/dotfiles/zsh_functions/devtools.zsh"
source "$HOME/dotfiles/zsh_functions/pyenv.zsh"

# Mise à jour hebdomadaire automatique des outils de dev
devtools_auto_update() {
  local update_file="$HOME/.devtools-auto-update"
  local last_update=$([[ -f "$update_file" ]] && cat "$update_file" || echo 0)
  local now=$(date +%s)
  if (( now - last_update > 604800 )); then
    update-devtools
    date +%s >| "$update_file"
  fi
}
devtools_auto_update

#####################################
# SECTION : GESTIONNAIRE DE PLUGINS #
#####################################

# Chargement de Zinit (plugin manager)
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
  print -P "%F{33} %F{220}Installation de Zinit...%f"
  mkdir -p "$HOME/.local/share/zinit"
  git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git"
fi
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Annexes Zinit
zinit light-mode for \
  zdharma-continuum/zinit-annex-as-monitor \
  zdharma-continuum/zinit-annex-bin-gem-node \
  zdharma-continuum/zinit-annex-patch-dl \
  zdharma-continuum/zinit-annex-rust

# Mise à jour automatique hebdomadaire de Zinit
zinit_update() {
  echo "🔄 Mise à jour de Zinit et plugins..."
  zinit self-update && echo "✅ Zinit à jour."
  zinit update --all && echo "✅ Plugins à jour."
}
zinit_auto_update() {
  local update_file="$HOME/.zinit-auto-update"
  local last_update=$([[ -f "$update_file" ]] && cat "$update_file" || echo 0)
  local now=$(date +%s)
  if (( now - last_update > 604800 )); then
    zinit_update
    date +%s >| "$update_file"
  fi
}
zinit_auto_update

# Plugins Zsh via Zinit
zinit ice depth=1; zinit light zsh-users/zsh-autosuggestions
zinit ice depth=1; zinit light zsh-users/zsh-syntax-highlighting
zinit ice depth=1; zinit light zsh-users/zsh-completions

# Configuration des plugins
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#8c8c8c'
ZSH_HIGHLIGHT_STYLES[path]='fg=#ebcb8b'

# Intégration shell pour WezTerm
~/dotfiles/wezterm/wezterm.sh

#########################
# SECTION : PROMPT ZSH  #
#########################

# Infos Git
__git_branch() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null
}
get_git_status() {
  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    if git diff --quiet && git diff --cached --quiet; then
      echo "%F{#a3be8c}🌿 $(__git_branch) ✓%f"
    else
      echo "%F{#d08770}🌿 $(__git_branch) ✗%f"
    fi
  fi
}

# Prompt personnalisé
custom_prompt() {
  local day="$(date +'%a %d %b %Y' | sed 's/^\(.\)/\U\1/')"
  local hour="%F{#a3be8c}  %F{#81a1c1}$(date +'%H:%M')"
  local venv_name=""
  [[ -n "$VIRTUAL_ENV" ]] && venv_name="%F{#b48ead}($(basename $VIRTUAL_ENV))%f "
  local first_part="%F{#a3be8c}┌──%F{#5e81ac} ${day} ${hour} %f%F{#b48ead}>%f"
  local second_part="🐧%F{#5e81ac}%~/% %F{#b48ead} >%f"
  local third_part="... $(get_git_status) %F{#b48ead}>%f"
  local second_line="%F{#a3be8c}└── ${venv_name}%F{#81a1c1}%n %F{#d08770}🖉  "
  PROMPT="${first_part} ${second_part} ${third_part}
${second_line}%f"
}
precmd() { custom_prompt }

###################
# SECTION : ALIAS #
###################

# Outils CLI 
#----------- 
#
# ls & eza
alias lsa='eza --icons -la --git --group-directories-first --color-scale --header --total-size --binary --smart-group --blocksize --git-repos-no-status --time-style=+%Y-%m-%d-%H:%M'
alias tree='eza --tree --icons'
alias ls='ls --color=auto'
# Rosé Pine — bascule eza dark/light
alias ezadark='ln -sf ~/dotfiles/eza/themes/rose-pine.yml ~/dotfiles/eza/theme.yml && echo "🌙 Rosé Pine Main"'
alias ezalight='ln -sf ~/dotfiles/eza/themes/rose-pine-dawn.yml ~/dotfiles/eza/theme.yml && echo "☀️Rosé Pine Dawn"'

# Zinit
alias zinitup='zinit_update'

# Aptitude
alias apti='sudo aptitude'
alias cleanapt='su -c "aptitude autoclean; aptitude clean"'

# Mise à jour des paquets avec interface
aptiup() {
  sudo aptitude update
  updates=$(aptitude search "~U" | wc -l)
  new_packages=$(aptitude search "~N" | wc -l)
  if (( updates > 0 || new_packages > 0 )); then
    echo "\033[33m$updates mises à jour, $new_packages nouveaux paquets.\033[0m"
    sudo aptitude
  else
    echo "\033[32mAucune mise à jour disponible.\033[0m"
  fi
}

# Divers
alias dotfiles='cd ~/dotfiles && nvim'
alias lua='lua5.5'
alias grep='grep --color=auto'
alias adios='systemctl poweroff'
alias reboot='systemctl reboot'
alias pyt='python3.14'

# Complétions UV
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# npm
export PATH="$HOME/.npm-global/bin:$PATH"
