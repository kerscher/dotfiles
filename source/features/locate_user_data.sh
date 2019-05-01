#!/bin/bash

setup_locate_user_data() {
    # shellcheck disable=SC2153
    if [ -z "${LOCAL_PATH}" ]; then
        # shellcheck disable=SC2016
        log_error 'Ensure "${LOCAL_PATH}" exists and is set'
    else
        if command -v locate >/dev/null 2>&1; then
            LOCATE_BASE_PATH="${LOCAL_PATH}/share/locate-db"
            LOCATE_PATH="${LOCATE_BASE_PATH}/locate.db"
            if [ ! -d "${LOCATE_BASE_PATH}" ]; then
                mkdir -p "${LOCATE_BASE_PATH}"
                printf "%s\\n%s\\n" \
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
