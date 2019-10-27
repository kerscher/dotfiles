#!/bin/bash

setup_macOS() {
    if type sw_vers &> /dev/null
    then
        export BASH_SILENCE_DEPRECATION_WARNING=1
    fi
}

setup_macOS
