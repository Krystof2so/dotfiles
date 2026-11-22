###################################
# GESTION DES PLUGINS ZSH (ZIMFW) #
###################################

ZIM_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zim"
ZIM_CONFIG_FILE="$HOME/dotfiles/zsh/zimrc"

# Script zimfw : paquet Debian si présent, sinon téléchargement via 'curl'
if [[ -r /usr/share/zimfw/zimfw.zsh ]]; then
  ZIMFW_SCRIPT=/usr/share/zimfw/zimfw.zsh
else
  ZIMFW_SCRIPT=${ZIM_HOME}/zimfw.zsh
  [[ -e ${ZIMFW_SCRIPT} ]] || curl -fsSL --create-dirs -o ${ZIMFW_SCRIPT} \
    https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE} ]]; then
  source ${ZIMFW_SCRIPT} init -q
fi

# Réglages des plugins (avant le chargement)
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#8c8c8c'

# Initialise les modules
source ${ZIM_HOME}/init.zsh

# À définir APRÈS le chargement : le tableau est créé par le plugin
ZSH_HIGHLIGHT_STYLES[path]='fg=#ebcb8b'
