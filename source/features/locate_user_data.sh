#!/bin/bash

setup_locate_user_data() {
    if [ -z "${LOCAL_PATH}" ]; then
        log_error 'Ensure "${LOCAL_PATH}" exists and is set'
    else
        if hash locate 2>/dev/null; then
            LOCATE_BASE_PATH="${LOCAL_PATH}/share/locate-db"
            LOCATE_PATH="${LOCATE_BASE_PATH}/locate.db"
            if [ ! -d "${LOCATE_BASE_PATH}" ]; then
                mkdir -p "${LOCATE_BASE_PATH}"
                printf "%s\n%s\n" \
                    "\`locate\` user db: you need to add the following to your crontab:" \
                    "12 0 * * * updatedb -l 0 -o ${LOCATE_PATH} -U ${HOME}"
            fi
            export LOCATE_PATH="${LOCATE_PATH}"
            DOTFILES_FEATURES="locate_user_data ${DOTFILES_FEATURES}"
        else
            log_error "Locate DB error: You don’t have \`locate\` on your PATH."
        fi
    fi
}

setup_locate_user_data
