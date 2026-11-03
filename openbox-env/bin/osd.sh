#!/bin/sh
# osd.sh — volume et luminosité, avec indicateur visuel (dunst)
# Usage : osd.sh {volume-up|volume-down|volume-mute|brightness-up|brightness-down}

SINK='@DEFAULT_AUDIO_SINK@'
STEP=5

# $1 = étiquette (volume et brightness)
# $2 = icône, $3 = valeur 0-100, $4 = texte
osd() {
    dunstify -a osd \
        -h "string:x-dunst-stack-tag:$1" \
        -h "int:value:$3" \
        -i "$2" "$4"
}

volume_osd() {
    state=$(wpctl get-volume "$SINK")
    vol=$(printf '%s\n' "$state" | awk '{ printf "%d", $2 * 100 + 0.5 }')
    case "$state" in
        *MUTED*)
            osd volume audio-volume-muted 0 "Volume coupé"
            ;;
        *)
            if   [ "$vol" -ge 66 ]; then icon=audio-volume-high
            elif [ "$vol" -ge 33 ]; then icon=audio-volume-medium
            else                         icon=audio-volume-low
            fi
            osd volume "$icon" "$vol" "Volume : ${vol} %"
            ;;
    esac
}

brightness_osd() {
    pct=$(brightnessctl -m | cut -d, -f4 | tr -d '%')
    osd brightness display-brightness "$pct" "Luminosité : ${pct} %"
}

case "$1" in
    volume-up)       wpctl set-volume -l 1.0 "$SINK" "${STEP}%+"; volume_osd ;;
    volume-down)     wpctl set-volume "$SINK" "${STEP}%-";        volume_osd ;;
    volume-mute)     wpctl set-mute "$SINK" toggle;               volume_osd ;;
    brightness-up)   brightnessctl -q set "${STEP}%+";            brightness_osd ;;
    brightness-down) brightnessctl -q -n set "${STEP}%-";         brightness_osd ;;
    *) echo "Usage : $0 {volume-up|volume-down|volume-mute|brightness-up|brightness-down}" >&2
       exit 1 ;;
esac
