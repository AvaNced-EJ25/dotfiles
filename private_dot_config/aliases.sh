# Aliases (consistent across bash and zsh)
alias vi="nvim"
alias n="coproc neovide"
alias fn="fzf --preview='bat -color=always {}' --bind 'enter:become(neovide {} &)'"
alias fvim="fzf --preview='bat --color=always {}' --bind 'enter:become(nvim {})'"
alias fbat="fzf --preview='bat --color=always {}' --bind 'enter:become(bat {})'"

alias sreload="exec '$SHELL'"
alias nvimrc="$EDITOR ${HOME}/.config/nvim"
alias zz="cd -"
alias dl="cd ~/Downloads"
alias fd="fdfind"

alias ls="eza --icons=auto --classify=auto --hyperlink"
alias ll="eza --long --header --icons=auto --classify=auto --git --smart-group --hyperlink"
alias la="eza --long --all --header --icons=auto --classify=auto --git --smart-group --hyperlink"
alias ltree="eza --tree --long --header --icons=auto --classify=auto --hyperlink"
alias tree="eza --tree --icons=auto --classify=auto --hyperlink"

alias binbat="bat --nonprintable-notation caret --show-all"

alias clip-set="xclip -selection c"
alias clip-get="xclip -selection c -o"

alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

alias makej="make -j $(nproc)"

# Exports
export EDITOR='nvim'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [[ "$(tty)" == *tty* ]]; then
    export OH_MY_POSH_CONFIG="${HOME}/.config/oh-my-posh/tty.omp.toml"
else
    export OH_MY_POSH_CONFIG="${HOME}/.config/oh-my-posh/catppuccin.omp.toml"
fi

alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}
