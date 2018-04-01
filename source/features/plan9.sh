#!/bin/bash

setup_plan9() {
    PLAN9='/usr/local/plan9'
    if [[ -d "${PLAN9}" ]]; then
        export PLAN9
        export PATH=${PATH}:${PLAN9}/bin
    else
        log_error "Plan 9 from User Space error: ${PLAN9} does not exist."
    fi
}

setup_plan9
