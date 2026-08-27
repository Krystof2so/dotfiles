###########################
# MISE À JOUR DE ZINIT    #
###########################

# --- Vérification que Zinit est installé (sinon, rien à mettre à jour) ---
if [[ ! -f "$HOME/.local/share/zinit/zinit.git/zinit.zsh" ]]; then
  return 0  # Zinit n'est pas installé, on ne fait rien
fi

# --- Mise à jour de Zinit et des plugins ---
echo "\n--- 🛠️ MISE A JOUR DE ZINIT ET DES PLUGINS ZSH ---"
zinit self-update 2>/dev/null && echo "    ✅ Zinit à jour."
zinit update --all 2>/dev/null && echo "    ✅ Plugins à jour."
