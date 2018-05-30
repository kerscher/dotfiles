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

export last_timestamp_file
last_timestamp_file="$(mktemp)"
date +'%s' > "${last_timestamp_file}"

seconds_to_timestamp () {
    i=${1}
    ((sec=i%60, i/=60, min=i%60, hrs=i/60))
    timestamp=$(printf "%d:%02d:%02d" $hrs $min $sec)
    echo "${timestamp}"
    unset sec min hrs
}

seconds_since_last_command () {
    last_timestamp="$(cat "${last_timestamp_file}")"
    current_timestamp="$(date +'%s')"
    diff_timestamp=$((current_timestamp - last_timestamp))
    seconds_to_timestamp "${diff_timestamp}"
    echo "${current_timestamp}" > "${last_timestamp_file}"
    unset last_timestamp current_timestamp diff_timestamp
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
        #BL=$(tput setaf 0) # Black
        #R=$(tput setaf 1) # Red
        #G=$(tput setaf 2) # Green
        #Y=$(tput setaf 3) # Yellow
        #B=$(tput setaf 4) # Blue
        #M=$(tput setaf 5) # Magenta
        #C=$(tput setaf 6) # Cyan
        W=$(tput setaf 7) # White

        export PS1
        PS1="\\n\\[${N}${B}\\]\\t \\[${N}${B}\\]+\`seconds_since_last_command\`s \\[${H}${W}\\]\\w\\n\$ \\[${N}${W}\\]"
        #unset B
        unset BL
        #unset R
        #unset G
        #unset Y
        #unset B
        unset M
        #unset C
        unset W
    else
        #export PS1="\n\t \u @ \h \`parse_os\`\`parse_virtualenv\`\w\n\$ "
        export PS1="\\n\\t\`parse_virtualenv\`\\w\\n\$ "
    fi
fi
