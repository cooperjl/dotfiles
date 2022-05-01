#!/bin/sh

# broke but i fix :)

get_mic_default() {
    pactl info | awk -F : '/Default Source:/{print $2}'
}

is_mic_muted() {
    pactl list sources | grep -A 15 'Name:'"$(get_mic_default)" | awk -F : '/Mute/ {print $2; exit}' | xargs
}

get_mic_status() {
    is_muted="$(is_mic_muted)"
    if [ "${is_muted}" = "yes" ]; then
        printf "%s\n" ""
    else
        printf "%s\n" ""
    fi
}

listen() {
    get_mic_status

    LANG=EN; pactl subscribe | while read -r event; do
        if printf "%s\n" "${event}" | grep --quiet "source" || printf "%s\n" "${event}" | grep --quiet "server"; then
            get_mic_status
        fi
    done
}

toggle() {
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
}

case "$1" in
    --toggle)
        toggle
        ;;
    *)
        listen
        ;;
esac

