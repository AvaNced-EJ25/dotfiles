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
    chezmoi upgrade
    kprintf 'Done.'

    kprintf 'Updating dotfiles...'
    chezmoi update

    kprintf 'Done.'
fi

# keepass.sh is not in chezmoi
if type keepassxc-cli > /dev/null 2>&1 && [ -x ~/.local/lib/keepass.sh ]; then
    kprintf "Syncing keepass database..."
    mounted=false
    nc -z "steve.koman" 445 > /dev/null 2>&1
    ret=$?
    if [ -z "$(/bin/ls -A '/mnt/home')" ] && [ "$ret" -eq 0 ]; then
        eval ~/.local/bin/mount.sh
        mounted=$?
    fi

    eval "~/.local/lib/keepass.sh"

    ret=$?

    if [ "$ret" -eq 0 ]; then
        kprintf "Done."
    else
        kprinterr "Keepass database sync failed."
    fi

    if [ "$mounted" == 0 ]; then
        eval ~/.local/bin/mount.sh
    fi
fi

if [[ $os_name == "Linux" ]]; then
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

    rustup completions zsh > "$(chezmoi source-path)/private_dot_config/zsh/dot_zsh_functions/executable__rustup"
    rustup completions zsh cargo > "$(chezmoi source-path)/private_dot_config/zsh/dot_zsh_functions/executable__cargo"

    # if the file changes, then push an update to chezmoi
    if ! chezmoi git -- diff-index --quiet HEAD > /dev/null 2>&1; then
        kprintf "Updating completions in chezmoi"
        chezmoi git -- add "private_dot_config/zsh/zsh_functions/executable__rustup"
        chezmoi git -- add "private_dot_config/zsh/zsh_functions/executable__cargo"
        chezmoi git -- commit -m "<K: AUTO> Update rust completions"
        chezmoi git -- push
        kprintf "Done."
    fi

    competions_dir="${HOME}/.local/share/bash-completion/completions"
    [ ! -d $competions_dir ] && mkdir -p $competions_dir
    rustup completions bash > $competions_dir/rustup
    rustup completions bash cargo > $competions_dir/cargo

    unset competions_dir
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

if [ -d "${HOME}/.local/lib/alacritty" ]; then
    kprintf 'Updating local build of alacritty...'
    pushd "${HOME}/.local/lib/alacritty"
    git pull
    cargo build --release

    # Update completions
    if type chezmoi > /dev/null 2>&1; then
        cp "extra/completions/_alacritty" "$(chezmoi source-path)/private_dot_config/zsh/dot_zsh_functions/executable__alacritty"

        # if the file changes, then push an update to chezmoi
        if ! chezmoi git -- diff-index --quiet HEAD > /dev/null 2>&1; then
            kprintf "Updating completions in chezmoi"
            chezmoi git -- add "private_dot_config/zsh/zsh_functions/executable__alacritty"
            chezmoi git -- commit -m "<K: AUTO> Update alacritty completions"
            chezmoi git -- push
            kprintf "Done."
        fi
    else
        cp "extra/completions/_alacritty" "$HOME/.config/zsh/.zsh_functions/_alacritty"
    fi
    popd
    kprintf 'Done.'
fi

if [ -d "${HOME}/.local/lib/neovim" ]; then
    kprintf 'Updating local build of neovim...'
    pushd "${HOME}/.local/lib/neovim"
    git fetch
    git checkout stable
    make -j $(nproc) CMAKE_BUILD_TYPE=Release
    sudo make -j $(nproc) install
    popd
    kprintf 'Done.'
fi

kprintf "Updating Catppuccin Files"

wget --output-document="$(chezmoi source-path)/private_dot_config/zsh/executable_catppuccin_macchiato-zsh-syntax-highlighting.zsh" "https://github.com/catppuccin/zsh-syntax-highlighting/raw/refs/heads/main/themes/catppuccin_macchiato-zsh-syntax-highlighting.zsh"
# if the file changes, then push an update to chezmoi
if ! chezmoi git -- diff-index --quiet HEAD > /dev/null 2>&1; then
    kprintf "Making a commit"
    chezmoi git -- add "private_dot_config/zsh/executable_catppuccin_macchiato-zsh-syntax-highlighting.zsh"
    chezmoi git -- commit -m "<K: AUTO> Update Catppuccin Files"
    chezmoi git -- push
    kprintf "Done."
fi

