#!/bin/bash

log_error() {
    if [ -t 1 ]; then
        echo "$@"
    elif hash logger 2>/dev/null; then
        logger "$@"
    fi
}

if [ -z "${DOTFILES+1}" ]; then
    if [ -d "${HOME}/.dotfiles" ]; then
        DOTFILES="${HOME}/.dotfiles"
    fi
else
    log_error "Dotfiles error: couldn't find source. To fix: ln -s <dotfiles-repo-location>/source ${HOME}/.dotfiles"
fi

# Paths
export LOCAL_PATH="${HOME}/.local"
mkdir --parents                  \
      "${LOCAL_PATH}"            \
      "${LOCAL_PATH}/lib"        \
      "${LOCAL_PATH}/bin"        \
      "${LOCAL_PATH}/share"      \
      "${LOCAL_PATH}/share/man"  \
      "${LOCAL_PATH}/share/info"

# Features
DOTFILES_FEATURES=""
export LOCAL_BIN="${LOCAL_PATH}/bin"

setup_haskell() {
    if hash stack 2>/dev/null; then
        if [ ! -f "${HOME}/.ghci" ]; then
            ln -s "${DOTFILES}/config/ghci" "${HOME}/.ghci"
        fi
        DOTFILES_FEATURES="haskell ${DOTFILES_FEATURES}"
    else
        log_error "Haskell toolset error: reinstall stack and try again."
    fi
}

setup_git() {
    if hash git 2>/dev/null; then
        if [ ! -f "${HOME}/.gitignore" ]; then
            ln -s "${DOTFILES}/config/gitignore" "${HOME}/.gitignore"
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

setup_go() {
    GOENV_ROOT="${HOME}/.goenv"
    GOENV_PATH="${GOENV_ROOT}/bin"
    GOPATH="${HOME}/go"
    GOPATH_BIN="${GOPATH}/bin"
    if [ -d "${GOENV_PATH}" ]; then
        export GOENV_ROOT="${GOENV_ROOT}"
        export GOENV_PATH="${GOENV_PATH}"
        if [ ! -d "${GOPATH}" ]; then
            mkdir "${GOPATH}"
            export GOPATH="${GOPATH}"
        fi
        DOTFILES_FEATURES="go ${DOTFILES_FEATURES}"
    else
        log_error "Go toolset error: \"${GOENV_PATH}\" does not exist. Install from https://github.com/syndbg/goenv."
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

setup_javascript() {
    NVM_DIR="${HOME}/.nvm"
    if [ -d "${NVM_DIR}" ]; then
        export NVM_DIR="${NVM_DIR}"
        DOTFILES_FEATURES="javascript ${DOTFILES_FEATURES}"
    else
        log_error "Javascript toolset error: \"${NVM_DIR}\" does not exist. Reinstall nvm and try again."
    fi
}

setup_keychain() {
    if hash keychain 2>/dev/null; then
        KEYCHAIN_KEYS="$(ls -x --hide config --hide known_hosts --hide *.pub ${HOME}/.ssh)"
        DOTFILES_FEATURES="keychain ${DOTFILES_FEATURES}"
    else
        log_error "SSH keychain error: \"keychain\" executable not found. Install and try again."
    fi
}

# Paths
setup_git
setup_haskell
setup_rust
setup_python
setup_go
setup_ruby
setup_javascript
setup_keychain
export PATH=${LOCAL_BIN}:${RUST_PATH}:${PYENV_PATH}:${GOENV_PATH}:${GOPATH_BIN}:${RBENV_PATH}:${PATH}

# Activate features
has_feature() {
    echo "${DOTFILES_FEATURES}" | grep "$1" > /dev/null 2>&1
}
if has_feature rust; then
    # shellcheck source=/dev/null
    . "${CARGO_PATH}/env" 1&>- 2>&1
    unset CARGO_PATH
fi
if has_feature python; then
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
if has_feature go; then
    eval "$(goenv init -)"
fi
if has_feature ruby; then
    eval "$(rbenv init -)"
fi
if has_feature javascript; then
    # shellcheck source=/dev/null
    [ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh"
fi
if has_feature keychain; then
    eval "$(keychain --eval --quick --quiet ${KEYCHAIN_KEYS})"
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
    # shellcheck source=/scripts/source/text_editor.sh
    . "${DOTFILES}/text_editor.sh"
    export EDITOR && EDITOR=$(text_editor)
    export VISUAL && VISUAL=$(text_editor)

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
    # shellcheck source=/scripts/source/directory-navigation.sh
    . "${DOTFILES}/directory-navigation.sh"
    # shellcheck source=/scripts/source/keyboard-shortcuts.sh
    . "${DOTFILES}/keyboard-shortcuts.sh"
    if [ ! -f "${HOME}/.inputrc" ]; then
        ln -s "${DOTFILES}/config/inputrc" "${HOME}/.inputrc"
    fi
    export INPUTRC=${HOME}/.inputrc
    
    # Prompt
    # shellcheck source=/scripts/source/prompt.sh
    . "${DOTFILES}/prompt.sh"

    # Completions
    if ! shopt -oq posix; then
        if [ -f /usr/share/bash-completion/bash_completion ]; then
            # shellcheck source=/dev/null
            . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
            # shellcheck source=/dev/null
            . /etc/bash_completion
        fi
    fi
fi
