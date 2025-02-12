# Common setup (needs to be done after compinit in zsh)

# If batpipe is installed, use that instead of lesspipe
if type batpipe &> /dev/null; then
    eval "$(batpipe)"
else
    # make less more friendly for non-text input files, see lesspipe(1)
    type lesspipe &> /dev/null && eval "$(SHELL=/bin/sh lesspipe)"
fi

if type eza &> /dev/null; then
    lib_dir="${HOME}/.local/lib"

    [ ! -d "$lib_dir/eza" ] && git clone https://github.com/eza-community/eza.git "$lib_dir/eza"

    comp_path="$lib_dir/eza/completions/$SHELL_NAME"
    [ ! -d $comp_path ] && export FPATH="$comp_path:$FPATH"

    unset lib_dir
    unset lib_dir
fi
if type fzf &> /dev/null; then
    if [[ ! "$PATH" == */home/linuxbrew/.linuxbrew/opt/fzf/bin* ]]; then
        PATH="${PATH:+${PATH}:}/home/linuxbrew/.linuxbrew/opt/fzf/bin"
    fi

    case "$SHELL_NAME" in
        "zsh")
            source <(fzf --zsh);;
        "bash")
            eval "$(fzf --bash)";;
        *)
            ;;
    esac

    export FZF_DEFAULT_OPTS=" \
        --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
        --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
        --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
        --height 40% --layout=reverse --border --info=inline"

    export FZF_COMPLETION_TRIGGER='``'
fi

# Add zoxide on cd
if type zoxide &>/dev/null; then
    eval "$(zoxide init $SHELL_NAME --cmd cd)"
fi

# Add oh-my-posh
if type oh-my-posh &>/dev/null; then
    eval "$(oh-my-posh init $SHELL_NAME --config "${OH_MY_POSH_CONFIG}")"
    eval "$(oh-my-posh completion $SHELL_NAME)"
fi

# Add pyenv
if [ -d "${HOME}/.pyenv" ]; then
    export PYENV_ROOT="${HOME}/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# Add pip
if type pip &>/dev/null; then
    eval "$(pip completion --$SHELL_NAME)"
fi

# Add chezmoi
if type chezmoi &>/dev/null; then
    alias cz="chezmoi"
    eval "$(chezmoi completion $SHELL_NAME)"
fi

# Add docker
if type docker &>/dev/null; then
    eval "$(docker completion $SHELL_NAME)"
fi

# Add nvm
if [ -d "${HOME}/.nvm" ]; then
    export NVM_DIR="${HOME}/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi


