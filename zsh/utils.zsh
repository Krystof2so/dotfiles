###################################
# FONCTIONS UTILITAIRES PARTAGÉES #
###################################

# =============================================================================
# FONCTIONS UTILITAIRES PARTAGÉES - Version simplifiée
# =============================================================================

# --- Fonction pour vérifier si une mise à jour globale est nécessaire ---
needs_global_update() {
  local update_file="$HOME/.zinit-auto-update"  # Fichier central pour TOUTES les mises à jour
  local last_update=$([[ -f "$update_file" ]] && cat "$update_file" || echo 0)
  local now=$(date +%s)
  local interval=604800  # 7 jours

  (( now - last_update > interval ))
}

# --- Fonction utilitaire pour PATH ---
path_prepend() {
  [[ ":$PATH:" != *":$1:"* ]] && export PATH="$1:$PATH"
}
