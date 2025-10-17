#!/bin/bash

# ────────────────────────────────────
# ▸ Configuration
# ────────────────────────────────────

FONT="Hack Nerd Font Propo"

SPOTIFY_EVENT="com.spotify.client.PlaybackStateChanged"

# Dynamic values based on toggle
IMAGE_SCALE=0.05

# ────────────────────────────────────
# ▸ Items
# ────────────────────────────────────

spotify_icon=(
  script="$PLUGIN_DIR/spotify.sh"
  click_script="osascript -e 'tell application \"Spotify\" to playpause'"
  icon=
  icon.font="$FONT:Regular:25.0"
  label.drawing=off
  drawing=off
)

spotify_cover=(
  click_script="open -a 'Spotify'"
  label.drawing=off
  icon.drawing=off
  padding_left=0
  padding_right=0
  background.image.scale=$IMAGE_SCALE
  background.image.drawing=on
  background.drawing=on
)

spotify_title=(
  icon.drawing=off
  padding_left=0
  padding_right=0
  width=0
  y_offset=8
  label.font="$FONT:Bold:15.0"
)

spotify_artist_album=(
  icon.drawing=off
  padding_left=0
  padding_right=0
  width=0
  y_offset=-8
  label.font="$FONT:Regular:10.0"
  label.color=0xffb8c0e0
)

# ────────────────────────────────────
# ▸ SketchyBar Setup
# ────────────────────────────────────

sketchybar --add event spotify_change $SPOTIFY_EVENT                \
           --add item spotify.icon right                            \
           --set spotify.icon "${spotify_icon[@]}"                  \
           --subscribe spotify.icon spotify_change                  \
                                                                    \
           --add item spotify.cover right                           \
           --set spotify.cover "${spotify_cover[@]}"                \
           --subscribe spotify.cover spotify_change                 \
                                                                    \
           --add item spotify.title right                           \
           --set spotify.title "${spotify_title[@]}"                \
           --subscribe spotify.title spotify_change                 \
                                                                    \
           --add item spotify.artist_album right                    \
           --set spotify.artist_album "${spotify_artist_album[@]}"  \
           --subscribe spotify.artist_album spotify_change          \
                                                                    \

# ────────────────────────────────────
# ▸ Trigger Initial Update
# ────────────────────────────────────

sketchybar --trigger spotify_change
