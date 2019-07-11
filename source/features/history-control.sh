#!/bin/bash

history_fix() {
    history -n && history -w && history -c && history -r    
}

setup_history_control() {
    shopt -s histappend
    shopt -s extglob

    HISTCONTROL="ignoreboth:erasedups"
    HISTSIZE=1000
    HISTFILESIZE=2000
    export HISTCONTROL HISTSIZE HISTFILESIZE
    
    PROMPT_COMMAND="history_fix; $PROMPT_COMMAND"
}

setup_history_control
