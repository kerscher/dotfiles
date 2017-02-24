log_error() {
    if [ -t 1 ]; then
        echo $@
    elif hash logger 2>/dev/null; then
        logger $@
    fi
}

if [ -z ${DOTFILES+1} ]; then
    if [ -d "${HOME}/.dotfiles" ]; then
        DOTFILES="${HOME}/.dotfiles"
    fi
else
    log_error "Dotfiles error: couldn't find source. To fix: ln -s <dotfiles-repo-location>/source ${HOME}/.dotfiles"
fi

# Paths
export LOCAL_PATH="${HOME}/.local"
mkdir --parents                \
      ${LOCAL_PATH}            \
      ${LOCAL_PATH}/lib        \
      ${LOCAL_PATH}/bin        \
      ${LOCAL_PATH}/share      \
      ${LOCAL_PATH}/share/man  \
      ${LOCAL_PATH}/share/info

# Features
DOTFILES_FEATURES=""
export LOCAL_BIN="${LOCAL_PATH}/bin"

setup_haskell() {
    if [ -x "${LOCAL_BIN}/stack" ]; then
        if [ ! -f "${HOME}/.ghci" ]; then
            ln -s ${DOTFILES}/config/ghci ${HOME}/.ghci
        fi
        DOTFILES_FEATURES="haskell ${DOTFILES_FEATURES}"
    else
        log_error "Haskell toolset error: reinstall stack and try again."
    fi
}

setup_git() {
    if hash git 2>/dev/null; then
        if [ ! -f "${HOME}/.gitignore" ]; then
            ln -s ${DOTFILES}/config/gitignore ${HOME}/.gitignore
            git config --global core.excludesfile "${HOME}/.gitignore"
        fi
        DOTFILES_FEATURES="git ${DOTFILES_FEATURES}"
    else
        log_error "Git error: no git executable found. Install and try again."
    fi
}

setup_rust() {
    CARGO_PATH="${HOME}/.cargo"
    RUST_PATH="${CARGO_PATH}/bin"
    if [ -d "${RUST_PATH}" ]; then
        export RUST_PATH=${RUST_PATH}
        export CARGO_PATH=${CARGO_PATH}
        DOTFILES_FEATURES="rust ${DOTFILES_FEATURES}"
    else
        log_error "Rust toolset error: \"${RUST_PATH}\" does not exist. Reinstall rustup and try again."
    fi
}

setup_python() {
    PYENV_PATH="${HOME}/.pyenv/bin"
    if [ -d "${PYENV_PATH}" ]; then
        export PYENV_PATH="${PYENV_PATH}"
        DOTFILES_FEATURES="python ${DOTFILES_FEATURES}"
    else
        log_error "Python toolset error: \"${PYENV_PATH}\" does not exist. Reinstall pyenv and try again."
    fi
}

setup_ruby() {
    RBENV_PATH="${HOME}/.rbenv/bin"
    if [ -d "${RBENV_PATH}" ]; then
        export RBENV_PATH="${RBENV_PATH}"
        DOTFILES_FEATURES="ruby ${DOTFILES_FEATURES}"
    else
        log_error "Ruby toolset error: \"${RBENV_PATH}\" does not exist. Reinstall rbenv and try again."
    fi
}

# Paths
setup_git
setup_haskell
setup_rust
setup_python
setup_ruby
export PATH=${LOCAL_BIN}:${RUST_PATH}:${PYENV_PATH}:${RBENV_PATH}:${PATH}

# Activate features
has_feature() {
    echo ${DOTFILES_FEATURES} | grep $1 > /dev/null 2>&1
}
if has_feature rust; then
    source ${CARGO_PATH}/env 1&>- 2>&1
    unset CARGO_PATH
fi
if has_feature python; then
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
if has_feature ruby; then
    eval "$(rbenv init -)"
fi

# Is this a terminal?
if [ -t 1 ]; then
    # Update terminal size after each command
    shopt -s checkwinsize
    
    # History
    export HISTCONTROL="ignoreboth:erasedups"
    shopt -s histappend
    shopt -s extglob
    HISTSIZE=1000
    HISTFILESIZE=2000
    alias history_fix='history -n && history -w && history -c && history -r'
    PROMPT_COMMAND="history_fix; $PROMPT_COMMAND"

    # Pager preprocessor
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
    
    # Text editor
    source ${DOTFILES}/text_editor.sh
    export EDITOR=$(text_editor)
    export VISUAL=$(text_editor)

    # Documentation
    if hash man 2>/dev/null; then
        export LOCAL_MAN="${LOCAL_PATH}/share/man"
        export MANPATH=$LOCAL_MAN:$MANPATH
    fi
    if hash info 2>/dev/null; then
        export LOCAL_INFO="${LOCAL_PATH}/share/info"
        export INFOPATH=$LOCAL_INFO:$INFOPATH
    fi

    # Keyboard navigation
    source ${DOTFILES}/directory-navigation.sh
    source ${DOTFILES}/keyboard-shortcuts.sh
    export INPUTRC=${DOTFILES}/inputrc
   
    # Prompt
    source ${DOTFILES}/prompt.sh

    # Completions
    if ! shopt -oq posix; then
        if [ -f /usr/share/bash-completion/bash_completion ]; then
            . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
        fi
    fi
fi
