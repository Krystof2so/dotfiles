#####################################
# GESTION DES OUTILS PYTHON (PYENV) #
#####################################

# --- Vérification que ~/.pyenv existe ---
if [[ ! -d "$HOME/.pyenv" ]]; then
  echo "⚠️ pyenv n'est pas installé dans ~/.pyenv. Installation : curl https://pyenv.run | bash"
  return 1
fi

# --- Configuration de base pour pyenv ---
export PYENV_ROOT="$HOME/.pyenv"

# --- Ajout au PATH (si pas déjà fait) ---
if [[ ":$PATH:" != *":$PYENV_ROOT/bin:"* ]]; then
  export PATH="$PYENV_ROOT/bin:$PATH"
fi

# --- Initialisation de pyenv et pyenv-virtualenv ---
if [[ -f "$PYENV_ROOT/bin/pyenv" ]]; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
else
  echo "⚠️ pyenv est installé mais le binaire est introuvable dans $PYENV_ROOT/bin"
  return 1
fi

# --- Vérification finale ---
if ! command -v pyenv >/dev/null 2>&1; then
  echo "❌ pyenv n'est toujours pas accessible. Vérifiez :"
  echo "   - que ~/.pyenv existe : ls -la ~/.pyenv"
  echo "   - que ~/.pyenv/bin/pyenv existe : ls -la ~/.pyenv/bin/pyenv"
  echo "   - que PATH contient ~/.pyenv/bin : echo \$PATH | grep ~/.pyenv"
  return 1
fi

# --- Mise à jour automatique de pyenv (tous les 7 jours) ---
py_update() {
  echo "--- 🐍 MISE A JOUR DES OUTILS PYTHON ---"
  echo "🐍 Mise à jour de pyenv..."
  git -C "$HOME/.pyenv" pull --quiet && echo "✅ pyenv à jour."
  echo "\n"
}

# Utilise auto_update (définie dans utils.zsh)
auto_update "pyenv" "py_update"
