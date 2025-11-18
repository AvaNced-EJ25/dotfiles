# Consistent across bash and zsh
# Exports
if type nvim &> /dev/null; then
    export EDITOR='nvim'
else
    export EDITOR='vim'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml,$HOME/.config/lazygit/pink.yml"

if [[ "$TERM" == xterm-256color* ]] || [[ "$TERM" == xterm-kitty ]] || [[ "$TERM" == foot ]]; then
    export OH_MY_POSH_CONFIG="$HOME/.config/oh-my-posh/catppuccin.omp.toml"
else
    export OH_MY_POSH_CONFIG="$HOME/.config/oh-my-posh/tty.omp.toml"
    export EDITOR='vim'
fi

if [[ "$TERM" == xterm-kitty ]]; then
    alias icat="kitten icat"
fi

# Aliases
alias vi="$EDITOR"
alias fzfvim="fzf --preview='bat --color=always {}' --bind 'enter:become(nvim {})'"
alias fzfbat="fzf --preview='bat --color=always {}' --bind 'enter:become(bat {})'"

alias sreload="exec '$SHELL'"
alias cz="chezmoi"
alias zz="cd -"
alias dl="cd ~/Downloads"

alias lg="lazygit"

if type fdfind &>/dev/null; then
    alias fd=fdfind
fi

if type batcat &>/dev/null; then
    alias bat=batcat
fi

alias binbat="bat --nonprintable-notation caret --show-all"

if type kitten &> /dev/null; then
    alias pbcopy="kitten clipboard --"
    alias pbpaste="kitten clipboard --get-clipboard --"
elif type xclip &> /dev/null; then
    alias pbcopy="xclip -selection c"
    alias pbpaste="xclip -selection c -o"
fi

alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}
