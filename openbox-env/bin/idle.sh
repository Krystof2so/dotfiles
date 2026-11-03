#!/bin/sh
# Gestion de l'inactivité : verrouillage, extinction de l'écran, mise en veille

# Permet de relancer ce script sans se déconnecter
pkill -x xss-lock
pkill -x xidlehook

# On remplace l'économiseur X et les minuteries DPMS automatiques par xidlehook
xset s off
xset +dpms
xset dpms 0 0 0

# Verrouilleur : répond à « loginctl lock-session » et à la mise en veille
xss-lock --transfer-sleep-lock -- "$HOME/.local/bin/lock.sh" &

# Les délais s'additionnent : 15 min, puis +10 min, puis +20 min (= 45 min)
exec "$HOME/.cargo/bin/xidlehook" \
  --not-when-fullscreen \
  --timer 900  'loginctl lock-session' '' \
  --timer 600  'xset dpms force off'   '' \
  --timer 1200 'systemctl suspend'     ''
