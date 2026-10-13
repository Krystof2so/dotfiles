###########################
# GESTION DES OUTILS RUST #
###########################

# --- Initialisation de Rust (PATH, etc.) ---
export PATH="$HOME/.cargo/bin:$PATH"

# --- Vérification de rustup --- #
if ! is_installed rustup; then
  echo "⚠️  rustup n'est pas installé. Installation recommandée :"
  echo "    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
  return 1
fi

# --- Mise à jour automatique de Rust --- #
echo "\n--- 🦀 MISE A JOUR DE RUST ET SES OUTILS ---"
rustup self update && echo "✅ rustup à jour."
rustup update && echo "✅ Toolchains à jour."

