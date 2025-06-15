# Fonction utilitaire pour ajouter un chemin à $PATH en tête,
# uniquement s'il n'est pas déjà présent.

path_prepend() {
  [[ ":$PATH:" != *":$1:"* ]] && export PATH="$1:$PATH"
}

