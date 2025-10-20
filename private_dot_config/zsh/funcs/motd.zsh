# Inspired by https://github.com/Kallahan23/zsh-motd
# Bash / Ubuntu MOTD for Zsh, but cooler
# This script is partly based on the default /etc/profile.d/update-motd.sh found in Ubuntu 20.04.

stamp="$HOME/.motd_shown"

print_header() {
    if [ -r $stamp ]; then
        flag=$(cat $stamp)
    fi
    ret=0

    [ -z "$flag" ] && flag="transgender"

    if [[ -v ZSH_MOTD_HYFETCH ]] && $(command -v hyfetch > /dev/null 2>&1 ); then
        hyfetch -C "${HOME}/.config/hyfetch.json" -p "$flag"
        ret=$?
    fi

    [ "$ret" = 0 ] && [ "$flag" = "transgender" ] && flag="lesbian" || flag="transgender"

    echo "$flag" > $stamp
    return
}

# Linux MOTD - once a day
if [ -d /etc/update-motd.d ] && [ ! -e "$HOME/.hushlogin" ] && [ -z "$MOTD_SHOWN" ] && ! find $stamp -newermt 'today 0:00' 2> /dev/null | grep -q -m 1 '.'; then
    if command -v update-motd > /dev/null 2>&1; then
        update-motd --show-only
        echo ""
    fi

    print_header
    export MOTD_SHOWN=update-motd
# ZSH MOTD - once every 3 hours
elif [ ! -z ${ZSH_MOTD_ALWAYS+x} ] || ! find $stamp -mmin -179 2> /dev/null | grep -q -m 1 '.'; then
    print_header
fi
