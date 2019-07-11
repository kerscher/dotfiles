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
        export DOTFILES
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
declare -a features=(
    "docker"
    "git"
    "asdf"
    "go"
    "terraform"
    "haskell"
    "rust"
    "ruby"
    "python"
    "javascript"
)
for f in "${features[@]}"; do
    load_feature "${f}"
done

# Is this a terminal?
if [ -t 1 ]; then
    declare -a interactive_features=(
        "history-control"
        "text-editor"
        "documentation"
        "keyboard-navigation"
        "prompt"
        "completions"
    )
    for f in "${interactive_features[@]}"; do
        load_feature "${f}"
    done
fi
