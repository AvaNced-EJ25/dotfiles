#!/usr/bin/env zsh

ICON_PADDING_RIGHT=5

case $INFO in

"Code")
    ICON_PADDING_RIGHT=4
    ICON=󰨞
    ;;
"Calendar")
    ICON_PADDING_RIGHT=3
    ICON=
    ;;
"Finder")
    ICON=󰀶
    ;;
"Firefox")
    ICON=
    ;;
"Google Chrome" | "Prisma Browser")
    ICON_PADDING_RIGHT=7
    ICON=
    ;;
"kitty")
    ICON=󰄛
    ;;
"Messages")
    ICON=
    ;;
"Microsoft Word")
    ICON=󱎒
    ;;
"Microsoft Excel")
    ICON=󱎏
    ;;
"Microsoft PowerPoint")
    ICON=󱎐
    ;;
"Microsoft Teams")
    ICON=󰊻
    ;;
"Microsoft OneNote")
    ICON=󰝇
    ;;
"Microsoft Outlook")
    ICON=󰴢
    ;;
"Preview")
    ICON_PADDING_RIGHT=3
    ICON=
    ;;
"Spotify")
    ICON_PADDING_RIGHT=2
    ICON=
    ;;
"TextEdit")
    ICON_PADDING_RIGHT=4
    ICON=
    ;;
*)
    ICON_PADDING_RIGHT=2
    ICON=
    ;;

esac

sketchybar --set $NAME icon=$ICON icon.padding_right=$ICON_PADDING_RIGHT
sketchybar --set $NAME.name label="$INFO"
