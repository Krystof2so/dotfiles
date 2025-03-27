################################################
# Section ZINIT                                #
# -------------------------------------------- #
# - Installation                               #
# - Chargement                                 #
# - Mise à jour automatique                    #
# - Chargement et configuration des plugins    #
# - Configurations supplémentaires des plugins #
# ##############################################

# Installation et chargement de 'Zinit' (Code généré par 'Zinit' lui-même)
# ------------------------------------------------------------------------
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh" # Charger Zinit
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Chargement d'annexes importantes :
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# Fonction de mise à jour de Zinit et des plugins, appelable depuis l'invite de commande à l'aide de l'alias 'zinitup'
# -------------------------------------------------------------------------------------------------------------------
zinit_update() {
    echo "🔄 Vérification des mises à jour pour Zinit et ses plugins..."    
    zinit self-update && echo "✅ Zinit est à jour." 
    zinit update --all && echo "✅ Tous les plugins sont à jour."
    echo "🔔 Mises à jour terminées. Votre environnement ZSH est maintenant à jour."
}

# Mise à jour de zinit et des plugins une fois par semaine 
# --------------------------------------------------------
zinit_auto_update() {
  local update_file="$HOME/.zinit-auto-update"
  local last_update=$([[ -f "$update_file" ]] && cat "$update_file" || echo 0)
  local now=$(date +%s)  # Heure actuelle
  # Si l'intervalle est dépassé, effectuer les mises à jour :
  if (( now - last_update > 604800 )); then   # 604800 = intervalle en secondes pour une semaine
    zinit_update  # Appel de la fonction
    date +%s >| "$update_file"  # Mise à jour l'horodatage
  fi
}

zinit_auto_update  # Appel de la fonction de mise à jour automatique

# Chargement et configuration des plugins 
# ---------------------------------------
zinit ice depth=1; zinit light zsh-users/zsh-autosuggestions      # Suggestions de commandes, fonction de l'historique
zinit ice depth=1; zinit light zsh-users/zsh-syntax-highlighting  # Coloration syntaxique des commandes
zinit ice depth=1; zinit light zsh-users/zsh-completions          # Améliore l'autocomplétion

# Configurations supplémentaires des plugins 
# ------------------------------------------
# autosuggestions :
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#8c8c8c'  # Couleur des suggestions (gris)
# highlights :
ZSH_HIGHLIGHT_STYLES[path]='fg=#ebcb8b'  # Style pour les chemins


###########################################
# Section GIT                             #
# --------------------------------------- #
# - Fonctions de gestion des informations #
###########################################
# Fonction pour obtenir le nom de la branche sur laquelle on se situe 
# -------------------------------------------------------------------
__git_branch() {
    git rev-parse --abbrev-ref HEAD 2>/dev/null
}

# Fonction pour vérifier si le dépôt est propre ou modifié
# --------------------------------------------------------
get_git_status() {
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        # Vérifier si des changements non committés sont présents (fichiers modifiés ou non stagés)
        if git diff --quiet && git diff --cached --quiet; then
            echo "%F{#a3be8c}🌿 $(__git_branch) ✓%f"  # Dépôt propre : branche en vert
        else
            echo "%F{#d08770}🌿 $(__git_branch) ✗%f"  # Dépôt modifié : branche en orange
        fi
    fi
}


#############################
# Section PROMPT            #
# ------------------------- #
# - Customisation du prompt #
# - Mise à jour             #
#############################

# Prompt personnalisé 
# -------------------
custom_prompt() {
    # Vérification si environnement virtuel Python :
    if [[ -n "$VIRTUAL_ENV" ]]; then
        local venv_name="%F{#b48ead}($(basename $VIRTUAL_ENV))%f "
    else
        local venv_name=""
    fi
    # Les diverses parties du prompt avec les couleurs et le format souhaités :
    local day="$(date +'%a %d %b %Y' | sed 's/^\(.\)/\U\1/')"
    local hour="%F{#a3be8c}  %F{#81a1c1}$(date +'%H:%M')"
    local first_part="%K{#000000}%F{#a3be8c}┌──%F{#5e81ac} ${day} ${hour} %k%f%K{#282828}%F{#000000}◗%f"
    local second_part="🐧%F{#5e81ac}%~/% %K{#3c3c3c}%F{#282828}◗%f"
    local third_part="... $(get_git_status) %k%F{#3c3c3c}◗%f"
    local second_line="%F{#a3be8c}└── ${venv_name}%F{#81a1c1}%n %F{#d08770}🖉  "
    #local git_info=$(get_git_status)
    PROMPT="${first_part} ${second_part} ${third_part}
${second_line}%f"
}

# Appeler custom_prompt avant chaque commande
# -------------------------------------------
precmd() { custom_prompt }


##############################
# Section CONFIGURATION ZSH  #
# -------------------------- #
# - Gestion des sons         #
# - Autocomplétion           #
# - Historique des commandes #
# - Couleurs de sortie       #
##############################
setopt NO_BEEP  # Supprime les sons (beep des erreurs de frappe, etc.)

# Autocomplétion 
# --------------
autoload -Uz compinit && compinit  # Active l'autocomplétion de ZSH
setopt AUTO_LIST              # Liste les options de complétion après une tabulation
setopt COMPLETE_IN_WORD       # Complète même si le curseur est au milieu du mot
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}  # Applique les couleurs de ls à la liste
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'    # Ignore la casse lors de la complétion
CDPATH=.:~:/path/to/other/directory  # Améliore autocompletion sur les chemins

# Gestion de l'historique des commandes
# -------------------------------------
HISTFILE=~/.zsh_history     # Fichier de stockage de l'historique
SAVEHIST=10000              # Nombre de commandes à sauvegarder
HISTSIZE=10000              # Taille de l'historique en mémoire
# Options supplémentaires :
setopt INC_APPEND_HISTORY   # Sauvegarde de la commande immédiatement
setopt SHARE_HISTORY        # Partage l'historique entre plusieurs sessions (utile si plusieurs terminaux sont ouverts)
setopt HIST_REDUCE_BLANKS   # Supprime les espaces superflus dans les commandes
setopt HIST_SAVE_NO_DUPS    # Ne pas sauvegarder les doublons dans le fichier d'historique
setopt HIST_IGNORE_ALL_DUPS # Ignore tous les doublons dans l'historique
setopt HIST_IGNORE_SPACE    # Ignore les commandes commençant par un espace

# Activation des couleurs de sortie (selon définitions au niveau du terminal) pour diverses commandes
# ---------------------------------------------------------------------------------------------------
alias ls='ls --color=auto'
alias grep='grep --color=auto'

######################
# Section ALIAS      #
# ------------------ #
# - aptitude         #
# - extinction du PC #
# - Python           #
# - kittens          #
######################

# zinit
# -----
alias zinitup='zinit_update'

# aptitude
# --------
# Fonction de mise à jour des dépôts avec 'aptitude' :
aptiup() {
    # Mets à jour la liste des paquets en demandant le mot de passe de l'utilisateur :
    sudo aptitude update
    # Compte les paquets à mettre à jour et les nouveaux paquets :
    updates=$(aptitude search "~U" | wc -l)
    new_packages=$(aptitude search "~N" | wc -l)
    # Ouverture de l'interface d'aptitude si paquets à mettre à jour ou si nouveaux paquets :
    # Vérifie et affiche un message en conséquence
    if (( updates > 0 || new_packages > 0 )); then
        echo "\033[33mPaquets disponibles pour mise à jour : $updates à mettre à jour, $new_packages nouveaux.\033[0m"
        sudo aptitude  # Ouverture d'aptitude
    else
        echo "\033[32mAucun paquet à mettre à jour et aucun nouveau paquet disponible.\033[0m"
    fi
}
# Alias
alias apti='sudo aptitude'
alias cleanapt='su -c "aptitude autoclean; aptitude clean"'
alias dotfiles='cd ~/dotfiles/ && nvim'

# Gestion de l'extinction du PC
# -----------------------------
alias adios='systemctl poweroff'
alias reboot='systemctl reboot'


# Alias pour Python
# -----------------
alias pyt13='python3.13'
alias pyt12='python3.12'
alias pyt='python3'

# kittens
# -------
alias icat='kitten icat '


# Created by `pipx` on 2025-02-05 20:45:12
export PATH="$PATH:/home/krystof/.local/bin"
