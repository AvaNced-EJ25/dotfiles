#!/bin/bash

PLUGIN_DIR="$HOME/.config/sketchybar/plugins"
# Allow override via first arg or env variable
COVER_PATH="/tmp/cover.jpg"
MAX_LABEL_LENGTH=32
truncate_text() {
    local text="$1"
    local max_length=$MAX_LABEL_LENGTH
    if [ ${#text} -le "$max_length" ]; then
        echo "$text"
    else
        echo "${text:0:max_length}" | sed -E 's/\s+[[:alnum:]]*$//' | awk '{$1=$1};1' | sed 's/$/.../'
    fi
}

update() {
    spotify_open=$(osascript -e 'tell application "System Events" to (name of processes) contains "Spotify"')

    if [ "$spotify_open" == "false" ]; then
        sketchybar -m \
            --set spotify.title label.drawing=off \
            --set spotify.artist_album label.drawing=off \
            --set spotify.cover background.image.drawing=off
    else
        local track artist album cover_url
        track=$(osascript -e 'tell application "Spotify" to get name of current track')
        artist=$(osascript -e 'tell application "Spotify" to get artist of current track')
        album=$(osascript -e 'tell application "Spotify" to get album of current track')
        cover_url=$(osascript -e 'tell application "Spotify" to get artwork url of current track')

        # Download cover image with fallback
        if curl -s --max-time 5 "$cover_url" -o "$COVER_PATH"; then
            sketchybar -m --set spotify.cover background.image="$COVER_PATH" background.color=0x00000000
        else
            # fallback if download fails
            sketchybar -m --set spotify.cover background.image="" background.color=0x00000000
        fi

        track=$(truncate_text "$track")
        artist=$(truncate_text "$artist")
        album=$(truncate_text "$album")

        sketchybar -m \
            --set spotify.title label.drawing=on label="$track" \
            --set spotify.artist_album label.drawing=on label="$artist - $album" \
            --set spotify.icon drawing=on \
            --set spotify.cover background.image.drawing=on
    fi
}

case "$SENDER" in
    "routine") update
        ;;
    "forced") exit 0
        ;;
    *) update
        ;;
esac
