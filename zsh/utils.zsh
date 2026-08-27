###################################
# FONCTIONS UTILITAIRES PARTAGÉES #
###################################

# --- Fonction générique pour les mises à jour automatiques (tous les 7 jours) ---
auto_update() {
  local tool_name="$1"
  local update_command="$2"
  local update_file="$HOME/.${tool_name}-auto-update"
  local last_update=$([[ -f "$update_file" ]] && cat "$update_file" || echo 0)
  local now=$(date +%s)
  local interval=604800  # 7 jours en secondes

  if (( now - last_update > interval )); then
    echo "🔄 Mise à jour automatique : $tool_name"
    eval "$update_command"
    date +%s >| "$update_file"
  fi
}

# --- Fonction utilitaire pour PATH ---
path_prepend() {
  [[ ":$PATH:" != *":$1:"* ]] && export PATH="$1:$PATH"
}
