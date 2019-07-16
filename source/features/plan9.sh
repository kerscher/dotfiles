#!/bin/bash

install_plan9() {
    sudo git clone https://github.com/9fans/plan9port /usr/local/plan9
    sudo chown -R "${USER}:${USER}" /usr/local/plan9
    pushd /usr/local/plan9 || return
    ./INSTALL
    popd || { log_error 'Can'\''t exit Plan 9 installation folder'; return ; } ;
}

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
