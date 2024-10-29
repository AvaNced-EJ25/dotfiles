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

kprintf 'Requesting root privilages...'
# Get sudo privileges at the start
sudo -v > /dev/null 2>&1 || exit 1
kprintf 'Done.'

if type oh-my-posh > /dev/null 2>&1; then
    kprintf 'Updating Oh-My-Posh...'
    oh-my-posh upgrade
    ret=$?
    if [ $ret -ne 0 ]; then
        kprinterr 'Oh My Posh could not upgrade, retrying with root permissions...'
        sudo oh-my-posh upgrade
    fi
    kprintf 'Done.'
fi

if type chezmoi > /dev/null 2>&1; then
    kprintf 'Ugrading chezmoi...'
    chezmoi upgrade
    kprintf 'Done.'

    kprintf 'Updating dotfiles...'
    chezmoi update
    kprintf 'Done.'
fi

if type apt > /dev/null 2>&1; then
    kprintf 'Updating system repositories...'
    sudo apt update
    kprintf 'Done.'
    kprintf 'Updating system packages...'
    sudo apt upgrade -y
    kprintf 'Done.'
fi

if type flatpak > /dev/null 2>&1; then
    kprintf 'Updating flatpak applications...'
    sudo flatpak update -y || flatpak update -y
    kprintf 'Done.'
fi

if type snap > /dev/null 2>&1; then
    kprintf 'Updating snap applications...'
    snap refresh || sudo snap refresh
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
