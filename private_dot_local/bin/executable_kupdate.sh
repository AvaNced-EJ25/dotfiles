#!/usr/bin/env bash

BLUE="\033[0;34m"
RED="\033[0;31m"
PURPLE="\033[0;35m"
NC="\033[0m" # No Color

function kprinterr {
    printf "${RED}<E> ${@}${NC}\n" 1>&2
}

function kprintf {
    printf "${PURPLE}󰰉 ${BLUE}${@}${NC}\n"
}

case "$(uname -s)" in
    Linux*)     os_name=Linux;;
    Darwin*)    os_name=Mac;;
    CYGWIN*)    os_name=Cygwin;;
    MINGW*)     os_name=MinGw;;
    MSYS_NT*)   os_name=MSys;;
    *)          os_name="UNKNOWN:${unameOut}"
esac

kprintf 'Requesting root privilages...'
# Get sudo privileges at the start
sudo -v > /dev/null 2>&1 || exit 1
kprintf 'Done.'

if type chezmoi > /dev/null 2>&1; then
    kprintf 'Ugrading chezmoi...'
    chezmoi upgrade --dry-run --progress true
    SCRIPTNAME=$(realpath $0)

    echo $(chezmoi diff $SCRIPTNAME)

    if [ ! -z $(chezmoi diff $SCRIPTNAME) ]; then
        kprintf "kupdate.sh has changed, restarting..."
        chezmoi apply --apply
        bash $SCRIPTNAME
        exit $?
    fi

    chezmoi apply --progress true
    kprintf 'Done.'

    kprintf 'Updating dotfiles...'
    chezmoi update
    kprintf 'Done.'
fi

if type oh-my-posh > /dev/null 2>&1; then
    kprintf 'Updating Oh-My-Posh...'
    oh-my-posh upgrade
    ret=$?
    if [ "$ret" -ne 0 ]; then
        kprinterr 'Oh My Posh could not upgrade, retrying with root permissions...'
        sudo oh-my-posh upgrade
    fi
    kprintf 'Done.'
fi

# keepass.sh is not in chezmoi
if type keepassxc-cli > /dev/null 2>&1 && [ -x ~/.local/lib/keepass.sh ]; then
    kprintf "Syncing keepass database..."
    mounted=false
    server_name=""
    read -r server_name < ~/.local/lib/server

    if [ ! -z $server_name ]; then
        nc -z "${server_name}" 445 > /dev/null 2>&1
        ret=$?
        if [ -z "$(/bin/ls -A '/mnt/home')" ] && [ "$ret" -eq 0 ]; then
            eval ~/.local/bin/mount.sh 'andrew' "${server_name}" 'home' '/mnt/home'
            mounted=$?
        fi
    fi

    eval "~/.local/lib/keepass.sh"

    ret=$?

    if [ "$ret" -eq 0 ]; then
        kprintf "Done."
    else
        kprinterr "Keepass database sync failed."
    fi

    if [ "$mounted" == 0 ]; then
        eval ~/.local/bin/mount.sh 'andrew' "${server_name}" 'home' '/mnt/home'
    fi
fi

if [[ $os_name == "Linux" ]]; then
    if type fwupdmgr > /dev/null 2>&1; then
        kprintf 'Updating BIOS and Device FW'
        sudo fwupdmgr get-updates
        kprintf 'Done.'
    fi

    if type apt > /dev/null 2>&1; then
        kprintf 'Updating system repositories...'

        i=0
        tput sc
        while fuser /var/lib/dpkg/lock >/dev/null 2>&1 ; do
            case $(($i % 4)) in
                0 ) j="-" ;;
                1 ) j="\\" ;;
                2 ) j="|" ;;
                3 ) j="/" ;;
            esac
            tput rc
            echo -en "\r[$j] Waiting for other software managers to finish..." 
            sudo -nv
            sleep 0.5
            ((i=i+1))
        done

        sudo apt update
        kprintf 'Done.'
        kprintf 'Updating system packages...'
        sudo apt upgrade -y
        kprintf 'Done.'
    fi

    if type flatpak > /dev/null 2>&1; then
        kprintf 'Updating flatpak applications...'
        flatpak update -y
        sudo flatpak update -y
        kprintf 'Done.'
    fi

    if type snap > /dev/null 2>&1; then
        kprintf 'Updating snap applications...'
        snap refresh || sudo snap refresh
        kprintf 'Done.'
    fi
fi

if type spicetify > /dev/null 2>&1; then
    kprintf 'Updating Spicetify...'
    spicetify update
    kprintf 'Done.'
fi

if type brew > /dev/null 2>&1; then
    kprintf 'Updating brew bottles...'
    brew update
    brew upgrade
    kprintf 'Done.'
fi

if type pyenv > /dev/null 2>&1; then
    kprintf 'Updating pyenv...'
    pyenv update
    kprintf 'Done.'
fi

if type rustup > /dev/null 2>&1; then
    kprintf 'Updating rust...'
    rustup update
    kprintf 'Done.'
fi

if type cargo > /dev/null 2>&1; then
    if [ ! -z "$(cargo install --list | grep 'alacritty')" ]; then
        kprintf 'Updating alacritty...'
        cargo install 'alacritty'
        kprintf 'Done.'
    fi

    if [ ! -z "$(cargo install --list | grep 'neovide')" ]; then
        kprintf 'Updating neovide...'
        cargo install --git https://github.com/neovide/neovide
        kprintf 'Done.'
    fi
fi

if [ -d "${HOME}/.local/lib/alacritty" ]; then
    kprintf 'Updating local build of alacritty...'
    cd "${HOME}/.local/lib/alacritty"
    git pull
    cargo build --release

    # Update completions
    # TODO: Update all completions
    if type chezmoi > /dev/null 2>&1; then
        cz_file="private_dot_config/zsh/dot_zsh_completions/executable__alacritty"
        cp "extra/completions/_alacritty" "$(chezmoi source-path)/${cz_file}"

        # if the file changes, then push an update to chezmoi
        if [ ! -z $(chezmoi git -- diff-index HEAD | grep "${cz_file}" &> /dev/null) ]; then
            kprintf "Updating completions"
            chezmoi git -- add "${cz_file}"
            chezmoi git -- commit -m "<K: AUTO> Update alacritty completions"
            kprintf "Done."
        else
            kprintf "No changes to completions"
        fi
    else
        cp "extra/completions/_alacritty" "$HOME/.config/zsh/.zsh_completions/_alacritty"
    fi
    cd -
    kprintf 'Done.'
fi

if [ -d "${HOME}/.local/lib/neovim" ]; then
    kprintf 'Updating local build of neovim...'
    cd "${HOME}/.local/lib/neovim"
    git fetch
    git checkout stable
    make -j $(nproc) CMAKE_BUILD_TYPE=Release
    sudo make -j $(nproc) install
    cd -
    kprintf 'Done.'
fi

chezmoi apply

exit 0
