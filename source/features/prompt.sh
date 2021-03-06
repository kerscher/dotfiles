#!/bin/bash

shopt -s checkwinsize

export last_timestamp_file
last_timestamp_file="$(mktemp)"
date +'%s' > "${last_timestamp_file}"

seconds_to_timestamp () {
    i=${1}
    ((sec=i%60, i/=60, min=i%60, hrs=i/60))
    timestamp=$(printf "%d:%02d:%02d" $hrs $min $sec)
    echo "${timestamp}"
    unset sec min hrs i
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
        PS1="\\n\\[${N}${B}\\]\\t \\[${H}${W}\\]\\w\\n\$ \\[${N}${W}\\]"
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
        export PS1="\\n\\t \\w\\n\$ "
    fi
fi
