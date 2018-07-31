#!/bin/bash

log_error() {
    if [ -t 1 ]; then
        echo "dotfiles: $*"
    elif hash logger 2>/dev/null; then
        logger -t "dotfiles" "$*"
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
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
export LOCAL_PATH="${HOME}/.local"
mkdir --parents                  \
      "${LOCAL_PATH}"            \
      "${LOCAL_PATH}/lib"        \
      "${LOCAL_PATH}/bin"        \
      "${LOCAL_PATH}/share"      \
      "${LOCAL_PATH}/share/man"  \
      "${LOCAL_PATH}/share/info"
export LOCAL_BIN="${LOCAL_PATH}/bin"
export PATH=${LOCAL_BIN}:${PATH}

# Features
load_feature() {
    if [ -f "${DOTFILES}/features/${1}.sh" ]; then
        # shellcheck source=/dev/null
        source "${DOTFILES}/features/${1}.sh"
    else
        log_error "could not activate ${1}. Check if ${DOTFILES}/features/${1}.sh exists"
    fi
}
declare -a features=("python"
                     "plan9"
                     "terraform"
                     "go"
                     "ruby"
                     "rust"
                     "haskell"
                     "git"
                     "keychain"
                     "locate_user_data"
                     "docker"
                     "scala"
                     "nix"
                    )
for f in "${features[@]}"; do
    load_feature "${f}"
done

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
