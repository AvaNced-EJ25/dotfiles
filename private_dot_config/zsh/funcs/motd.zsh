# Inspired by https://github.com/Kallahan23/zsh-motd
# Bash / Ubuntu MOTD for Zsh, but cooler
# This script is partly based on the default /etc/profile.d/update-motd.sh found in Ubuntu 20.04.

stamp="$HOME/.motd_shown"

print_header() {
    # Custom message
    if [[ -v ZSH_MOTD_HYFETCH ]] && $(type hyfetch &>/dev/null ); then
        hyfetch -C "${HOME}/.config/hyfetch.json"
    fi
}

# Linux MOTD - once a day
if [ -d /etc/update-motd.d ] && [ ! -e "$HOME/.hushlogin" ] && [ -z "$MOTD_SHOWN" ] && ! find $stamp -newermt 'today 0:00' 2> /dev/null | grep -q -m 1 '.'; then
    [ $(id -u) -eq 0 ] || SHOW="--show-only"
    print_header
    update-motd $SHOW
    touch $stamp
    export MOTD_SHOWN=update-motd
# ZSH MOTD - once every 3 hours
elif [ ! -z ${ZSH_MOTD_ALWAYS+x} ] || ! find $stamp -mmin -179 2> /dev/null | grep -q -m 1 '.'; then
    print_header
    touch $stamp
fi
