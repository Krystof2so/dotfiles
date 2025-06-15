# zsh_functions/devtools.zsh

update-devtools() {
  echo "🔧 Démarrage de la mise à jour des outils de développement..."

  # PYENV
  if [ -d "$HOME/.pyenv" ]; then
    echo "🔄 Mise à jour de pyenv..."
    git -C "$HOME/.pyenv" pull --quiet && echo "✅ pyenv à jour."

    for plugin in pyenv-doctor pyenv-update pyenv-virtualenv ; do
      plugin_path="$HOME/.pyenv/plugins/$plugin"
      if [ -d "$plugin_path" ]; then
        echo "  ↪️  Mise à jour du plugin $plugin..."
        git -C "$plugin_path" pull --quiet && echo "    ✅ $plugin à jour."
      else
        echo "  ⚠️  Plugin $plugin non installé."
      fi
    done
  else
    echo "❌ pyenv n’est pas installé dans ~/.pyenv"
  fi

  # POETRY
  if command -v poetry >/dev/null 2>&1; then
    echo "🔄 Mise à jour de poetry..."
    poetry self update && echo "✅ poetry à jour."
  else
    echo "❌ poetry n’est pas installé ou non trouvé dans \$PATH"
  fi

  # UV
  if command -v uv >/dev/null 2>&1; then
    echo "🔄 Mise à jour de uv..."
    curl -Ls https://astral.sh/uv/install.sh | bash && echo "✅ uv à jour." || echo "❌ Échec de la mise à jour de uv."
  else
    echo "⚠️ uv n’est pas installé ou non trouvé dans \$PATH"
  fi

  echo "✅ Mise à jour terminée."
}

