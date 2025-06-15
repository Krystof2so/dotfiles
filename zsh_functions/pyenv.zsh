# Nécessite que path_prepend soit chargé

activate-pyenv() {
  export PYENV_ROOT="$HOME/.pyenv"
  path_prepend "$PYENV_ROOT/bin"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
}

deactivate-pyenv() {
  export PATH=$(echo "$PATH" | tr ':' '\n' | grep -v "$HOME/.pyenv" | paste -sd:)
  unset PYENV_ROOT
}

