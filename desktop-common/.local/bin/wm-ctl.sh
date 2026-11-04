#!/bin/sh
# wm-ctl — quit | reload, quel que soit le gestionnaire de fenêtres actif
if   pgrep -x labwc   >/dev/null; then wm=labwc
elif pgrep -x openbox >/dev/null; then wm=openbox
else echo "Gestionnaire de fenêtres inconnu" >&2; exit 1
fi
case "$1" in
    quit)   "$wm" --exit ;;
    reload) "$wm" --reconfigure ;;
    *) echo "Usage : $0 {quit|reload}" >&2; exit 1 ;;
esac
