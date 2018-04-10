#!/bin/bash

parse_virtualenv () {
    if [[ -n "${VIRTUAL_ENV}" ]]; then
        if hash basename 2>/dev/null; then
            VIRTUALENV_NAME=$(basename "$VIRTUAL_ENV")
        else
            VIRTUALENV_NAME="${VIRTUAL_ENV}"
        fi
        echo "${VIRTUALENV_NAME} "
    fi
}

parse_os () {
    OS_REDHAT=$(cat /etc/redhat-release 2> /dev/null)
    OS_DEBIAN=$(lsb_release -a 2> /dev/null | grep 'Description:' | cut -d: -f2 | awk '{ print $1, $2, $3 }')
    if [ ! -z "${OS_REDHAT}" ]; then
        echo "${OS_REDHAT} "
    elif [ ! -z "${OS_DEBIAN}" ]; then
        echo "${OS_DEBIAN} "
    else
        echo ""
    fi
    unset OS_REDHAT
    unset OS_DEBIAN
}

# We only set the prompt on an interactive terminal
if [ -t 1 ]; then
    # How many colors do we have?
    TERM_COLOURS=$(tput colors)

    if [ -n "${TERM_COLOURS}" ] && [ "${TERM_COLOURS}" -ge 8 ]; then
        # Typeface weight
        N="$(tput sgr0)" # Normal, or regular
        #H="$(tput bold)" # Heavy, or bold

        # Typeface colour
        BL=$(tput setaf 0) # Black
        #R=$(tput setaf 1) # Red
        G=$(tput setaf 2) # Green
        #Y=$(tput setaf 3) # Yellow
        B=$(tput setaf 4) # Blue
        M=$(tput setaf 5) # Magenta
        #C=$(tput setaf 6) # Cyan
        W=$(tput setaf 7) # White

        export PS1="\\n\\[${H}${BL}\\]\\t \\[${N}${BL}\\]\`parse_virtualenv\`\\[${H}${W}\\]\\w\\n\$ \\[${N}${W}\\]"
        unset B
        unset BL
        #unset R
        unset G
        #unset Y
        unset B
        unset M
        #unset C
        unset W
    else
        #export PS1="\n\t \u @ \h \`parse_os\`\`parse_virtualenv\`\w\n\$ "
        export PS1="\\n\\t\`parse_virtualenv\`\\w\\n\$ "
    fi
fi
