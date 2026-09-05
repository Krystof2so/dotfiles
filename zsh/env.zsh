######################################
# VARIABLES D'ENVIRONNEMENT GLOBALES #
######################################

# --- Options Zsh --- #
setopt NO_BEEP                # Supprime les sons
setopt AUTO_LIST              # Liste les options de complétion après tab
setopt COMPLETE_IN_WORD       # Complète au milieu d’un mot
setopt INC_APPEND_HISTORY     # Sauvegarde immédiate
setopt SHARE_HISTORY          # Partage entre terminaux
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

# --- Variables de locale --- #
export LANG=fr_FR.UTF-8
export LC_TIME=fr_FR.UTF-8

# --- Chemins --- #
export PATH="$HOME/.local/bin:$HOME/.npm-global/bin:$PATH"
CDPATH=.:~:/path/to/other/directory

# --- Historique Zsh --- #
HISTFILE=~/.zsh_history
SAVEHIST=1000
HISTSIZE=1000

# --- Pager et MAN --- #
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
export MANROFFOPT="-c"
export PAGER='batcat'
