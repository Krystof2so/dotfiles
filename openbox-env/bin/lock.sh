#!/bin/sh
# Verrouillage de l'écran (appelé par xss-lock)
dunstctl set-paused true
i3lock --nofork --ignore-empty-password --show-failed-attempts -c 191724
dunstctl set-paused false
