#!/bin/bash

: "${DOTFILES?}"

set -B

change_directory() {
    if hash cdargs 2>/dev/null; then
        cdargs "$1" && pushd "$(cat "$HOME/.cdargsresult")" || exit
    else
        log_error "Error: cdargs is not on PATH. Ensure it's installed and try again."
    fi
}

execute_if_exists() {
    if hash "$1" 2>/dev/null; then
        "$@"
    fi
}

monitor_processes() {
    if hash htop 2>/dev/null; then
        htop
    elif hash top 2>/dev/null; then
        top
    fi
}

list_tree() {
    if hash tree 2>/dev/null; then
        tree --dirsfirst -C -L 2 "$@"
    elif hash exa 2>/dev/null; then
        exa --tree --group-directories-first --level 2  "$@"
    else
        ls                   \
            --recursive      \
            --color          \
            --classify       \
            --human-readable \
            --group-directories-first
    fi
}

list_detailed_tree() {
    if hash tree 2>/dev/null; then
        tree --dirsfirst -a -C -L 2 -h -D -p -g "$@"
    elif hash exa 2>/dev/null; then
        exa --all --tree --group-directories-first --level 2 "$@"
    else
        ls                   \
            --all            \
            --recursive      \
            --color          \
            --classify       \
            --human-readable \
            --group-directories-first
    fi
}

list_files() {
    if hash exa 2>/dev/null; then
        exa \
            --header \
            --long \
            --git \
            --group-directories-first \
            --colour=never "$@"
    else
        ls                   \
            --classify       \
            --human-readable \
            --group-directories-first "$@"
    fi
}

list_all_files() {
    if hash exa 2>/dev/null; then
        exa \
            --header \
            --long \
            --git \
            --group-directories-first \
            --all \
            --colour=never "$@"
    else
        ls                   \
            --all            \
            --classify       \
            --human-readable \
            --group-directories-first "$@"
    fi
}

# Shortcuts
## Left hand
alias a='${EDITOR}' # text editor

alias o="monitor_processes"
alias O="execute_if_exists ps ax"

alias e="list_tree"
alias E="list_detailed_tree"

alias u="change_directory -b" # browse current directory
alias U="change_directory"    # browse favorites

alias i="list_files"  # list     files
alias I="list_all_files" # list all files

## Right hand
alias d='pushd ${HOME}' # go to the home directory
alias f='popd ${HOME}'  # go to the home directory deleting the current one from it

alias h="pushd +1" # go to last directory on history
alias g="popd +1"  # go to last directory on history deleting the current one from it.

alias t="pushd"    # go to argument and add it to history
alias c="pushd .." # go to parent directory and add it to history

alias n="pushd -1" # go to first directory on history
alias r="popd -1"  # go to first directory on history deleting the current one from it

alias s="execute_if_exists locate" # search globally for files
alias S="execute_if_exists find"   # search locally  for files

if [ ! -f "${HOME}/.inputrc" ]; then
    ln -s "${DOTFILES}/config/inputrc" "${HOME}/.inputrc"
fi
export INPUTRC=${HOME}/.inputrc
