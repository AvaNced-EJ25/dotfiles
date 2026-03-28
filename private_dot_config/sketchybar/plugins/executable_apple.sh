#!/bin/bash

POPUP_OFF="sketchybar --set apple.logo popup.drawing=off"
POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

apple_logo=(
  icon=
  icon.color=0xFFF5BDE6
  icon.font="$FONT_FACE:Bold:20.0"
  icon.padding_right=10
  icon.color=0xFFA6DA95
  background.color=0x00000000
  label.drawing=off
  click_script="$POPUP_CLICK_SCRIPT"
)

apple_prefs=(
  width=200
  icon=󰒔
  icon.color=0xFFF5BDE6
  icon.padding_left=5
  icon.padding_right=5
  label="Preferences"
  label.color=$FONT_COLOR
  click_script="open -a 'System Preferences'; $POPUP_OFF"
)

apple_activity=(
  width=200
  icon=
  icon.color=0xFFF5BDE6
  icon.padding_left=5
  icon.padding_right=5
  label="Activity"
  label.color=$FONT_COLOR
  click_script="open -a 'Activity Monitor'; $POPUP_OFF"
)

apple_lock=(
  width=200
  icon=󰌾
  icon.color=0xFFF5BDE6
  icon.padding_left=5
  icon.padding_right=5
  label="Lock Screen"
  label.color=$FONT_COLOR
  click_script="pmset displaysleepnow; $POPUP_OFF"
)

sketchybar --add item apple.logo left                  \
           --set apple.logo "${apple_logo[@]}"         \
                                                       \
           --add item apple.prefs popup.apple.logo     \
           --set apple.prefs "${apple_prefs[@]}"       \
           background.color=$ITEM_SURFACE              \
                                                       \
           --add item apple.activity popup.apple.logo  \
           --set apple.activity "${apple_activity[@]}" \
           background.color=$ITEM_SURFACE              \
                                                       \
           --add item apple.lock popup.apple.logo      \
           --set apple.lock "${apple_lock[@]}"         \
           background.color=$ITEM_SURFACE
