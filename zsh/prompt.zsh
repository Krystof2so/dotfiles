###########################
# PROMPT ZSH PERSONNALISÉ #
###########################

# --- Fonctions pour Git --- #
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

# --- Fonction pour le prompt --- #
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

# --- Activation du prompt --- #
precmd() { custom_prompt }
