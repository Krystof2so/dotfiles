###########################
# MISE À JOUR DE ZIMFW    #
###########################

# Rien à faire si zimfw n'est pas installé
[[ -e ${ZIM_HOME} ]] || return 0

echo "\n--- 🛠️ MISE A JOUR DE ZIMFW ET DES PLUGINS ZSH ---"
zimfw update -q  && echo "    ✅ Modules à jour."
