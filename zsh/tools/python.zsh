#############################
# GESTION DES OUTILS PYTHON #
# (uv)                      #
#############################

echo "\n--- 🐍 MISE A JOUR DES OUTILS POUR PYTHON ---"

# --- Vérification et mise à jour de uv ---
path_prepend "$HOME/.local/bin"
path_prepend "$HOME/.cargo/bin"
if is_installed uv; then
  echo "  → Mise à jour de uv..."
  uv self update && echo "    ✅ uv à jour."
  # --- Complétions zsh (lues via ~/.zfunc, déjà dans le fpath) ---
  echo "  → Génération des complétions de uv..."
  mkdir -p "$HOME/.zfunc"
  uv generate-shell-completion zsh >| "$HOME/.zfunc/_uv"
  is_installed uvx && uvx --generate-shell-completion zsh >| "$HOME/.zfunc/_uvx"
  echo "    ✅ Complétions à jour (actives au prochain terminal)."
else
  echo "⚠️ uv n'est pas installé. Installation : curl -Ls https://astral.sh/uv/install.sh | sh"
fi
