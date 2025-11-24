# Inspired by https://github.com/Kallahan23/zsh-motd
# Bash / Ubuntu MOTD for Zsh, but cooler
# This script is partly based on the default /etc/profile.d/update-motd.sh found in Ubuntu 20.04.

MOTD_STAMP="$HOME/.motd_shown"

hyfetch_cycle() {
    if ! command -v hyfetch > /dev/null 2>&1; then
        return 0
    fi

    emulate sh
    local ret=0
    local i=0
    local flags=( "rainbow" "transgender" "lesbian" "transbian" "demigirl" "transfeminine" "sapphic" "progress" "interprogress" )
    local count=${#flags[@]}
    if [ -r $MOTD_STAMP ]; then
        i=$(cat $MOTD_STAMP)
    fi

    [ "$i" -gt "$count" ] && i=0

    local flag=${flags[$i]}
    if [[ -v ZSH_MOTD_HYFETCH ]]; then
        hyfetch -C "${HOME}/.config/hyfetch.json" -p "$flag"
        ret=$?
    fi

    if [ "$ret" = 0 ]; then
        i=$(((i+1) % $count))
        echo "$i" > $MOTD_STAMP
    fi

    emulate zsh
    return $ret
}

# Linux MOTD - once a day
if [ -d /etc/update-motd.d ] && [ ! -e "$HOME/.hushlogin" ] && [ -z "$MOTD_SHOWN" ] && ! find $MOTD_STAMP -newermt 'today 0:00' 2> /dev/null | grep -q -m 1 '.'; then
    if command -v update-motd > /dev/null 2>&1; then
        update-motd --show-only
        echo ""
    fi

    hyfetch_cycle
    ret=$?

    if [ $ret -eq 0 ]; then
        export MOTD_SHOWN=update-motd
    fi
# ZSH MOTD - once every 3 hours
elif [ ! -z ${ZSH_MOTD_ALWAYS+x} ] || ! find $MOTD_STAMP -mmin -179 2> /dev/null | grep -q -m 1 '.'; then
    hyfetch_cycle
fi
