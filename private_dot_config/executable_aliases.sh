# Assume 2 processors by default
num_proc=2
if type nproc &> /dev/null; then
    # Try with nproc (Linux)
    num_proc=$(nproc)
elif type sysctl &> /dev/null; then
    # Try with sysctl (MacOS)
    num_proc="$(sysctl -n hw.ncpu)"
fi

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

if [[ "$TERM" != xterm-256color* ]] && [[ "$TERM" != xterm-ghostty ]]; then
    export OH_MY_POSH_CONFIG="$HOME/.config/oh-my-posh/tty.omp.toml"
    export EDITOR='vim'
else
    export OH_MY_POSH_CONFIG="$HOME/.config/oh-my-posh/catppuccin.omp.toml"
fi

# Aliases
alias vi="$EDITOR"
alias fn="fzf --preview='bat -color=always {}' --bind 'enter:become(neovide {} &)'"
alias fvim="fzf --preview='bat --color=always {}' --bind 'enter:become(nvim {})'"
alias fbat="fzf --preview='bat --color=always {}' --bind 'enter:become(bat {})'"

alias sreload="exec '$SHELL'"
alias cz="chezmoi"
alias zz="cd -"
alias dl="cd ~/Downloads"

alias ls="eza --icons=auto --classify=auto --hyperlink"
alias ll="eza --long --header --icons=auto --classify=auto --git --smart-group --hyperlink"
alias la="eza --long --all --header --icons=auto --classify=auto --git --smart-group --hyperlink"
alias ltree="eza --tree --long --header --icons=auto --classify=auto --hyperlink"
alias tree="eza --tree --icons=auto --classify=auto --hyperlink"

alias lg="lazygit"

alias binbat="bat --nonprintable-notation caret --show-all"

if type xclip &> /dev/null; then
    alias clip-set="xclip -selection c"
    alias clip-get="xclip -selection c -o"
elif type pbcopy &> /dev/null; then
    alias clip-set="pbcopy"
    alias clip-get="pbpaste"
fi

alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

alias makej="make -j $num_proc"
alias make-iwuy="make -k CC=include-what-you-use IWUYFLAGS=\"-Xiwyu --error_always\""
alias iwyu-fix="make-iwuy 2> /tmp/iwyu.out; /usr/bin/env fix_includes.py < /tmp/iwyu.out"

alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}
