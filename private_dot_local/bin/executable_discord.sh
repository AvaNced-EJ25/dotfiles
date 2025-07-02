#!/usr/bin/env bash

ret=0
echoerr() { echo "$@" 1>&2; }

# Kill discord so it can be updated
pkill Discord > /dev/null 2> /dev/null

echo "Requesting root privilages..."
# Get sudo privileges at the start
sudo -v > /dev/null || exit 1
echo "Done."

wget_opts="--quiet --tries=5"

better_url="https://github.com/BetterDiscord/Installer/releases/download/v1.3.0/BetterDiscord-Linux.AppImage"
better_dnld="/tmp/BetterDiscord-Linux.AppImage"

theme_url="https://github.com/refact0r/midnight-discord/raw/refs/heads/master/themes/flavors/midnight-catppuccin-macchiato.theme.css"
theme_dnld="${HOME}/.config/BetterDiscord/themes/midnight-catppuccin-macchiato.theme.css"

discord_pid=0

echo "Downloading Better Discord Installer"

# download the newest betterdiscord installer
wget $wget_opts --output-document="$better_dnld" "$better_url" &
better_dnld_pid=$!

# dowload the newest midnight theme
wget $wget_opts --output-document="$theme_dnld" "$theme_url" &

sudo apt upgrade -y discord

if [ $ret -eq 0 ]; then
    # Start discord so it can install its updates
    discord > /dev/null 2>/dev/null &
    discord_pid=$!

    wait ${better_dnld_pid}
    if ! [ -f "$better_dnld" ]; then
        echoerr "Failed to download update file"
        ret=3
    fi
fi

if [ $ret -eq 0 ]; then
    chmod +x "$better_dnld"

    echo "Waiting for discord to update... (please close Discord when update is complete)"
    wait $discord_pid

    $better_dnld

    # Only remove downloads if it doesn't fail so we don't have to redownload them
    rm -f "$better_dnld" "$discord_dnld"
fi

discord > /dev/null 2>/dev/null &

exit $ret
