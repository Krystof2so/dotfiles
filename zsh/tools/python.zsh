#############################
# GESTION DES OUTILS PYTHON #
# (pyenv, poetry, uv)       #
#############################

echo "\n--- 🐍 MISE A JOUR DES OUTILS POUR PYTHON ---"
# --- Vérification et initialisation de pyenv ---
if [[ -d "$HOME/.pyenv" ]]; then
  # --- Initialisation de pyenv ---
  export PYENV_ROOT="$HOME/.pyenv"
  path_prepend "$PYENV_ROOT/bin"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"

  # --- Mise à jour de pyenv (exécutée uniquement si needs_global_update est vrai) ---
  echo "  → Mise à jour de pyenv..."
  git -C "$HOME/.pyenv" pull --quiet 2>/dev/null && echo "    ✅ pyenv à jour."
else
  echo "⚠️ pyenv n'est pas installé. Installation : curl https://pyenv.run | bash"
fi

# --- Vérification et mise à jour de uv ---
path_prepend "$HOME/.local/bin"
path_prepend "$HOME/.cargo/bin"
if is_installed uv; then
  echo "  → Mise à jour de uv..."
  uv self update && echo "    ✅ uv à jour."
else
  echo "⚠️ uv n'est pas installé. Installation : curl -Ls https://astral.sh/uv/install.sh | sh"
fi
