###########################
# GESTION DES OUTILS RUST #
###########################

# --- Vérification de rustup --- #
if ! command -v rustup >/dev/null 2>&1; then
  echo "⚠️  rustup n'est pas installé. Installation recommandée :"
  echo "    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
  return 1
fi

# --- Mise à jour automatique de Rust --- #
rust_update() {
  echo "--- 🦀 MISE A JOURS DE RUST ET SES OUTILS ---"
  echo "🦀 Mise à jour de Rust..."
  rustup self update && echo "✅ rustup à jour."
  rustup update && echo "✅ Toolchains à jour."
  echo "\n"
}

auto_update "rust" "rust_update"
