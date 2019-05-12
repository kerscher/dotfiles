log() {
    show_usage()(
        echo "$(error 'log { info | warn | error } message')"
    ) >&2
    is_valid_arg()( test "$(type -t "${1}")" = 'function' )

    put_log()(
        cmd="${1}"; shift
        echo "[${cmd}]" ${@}
    )
    info() ( put_log 'INFO' ${@} )
    warn() ( put_log 'WARN' ${@} ) >&2
    error() ( put_log 'ERROR' ${@} ) >&2

    if is_valid_arg "${1}"
    then
        cmd="${1}"; shift
        "${cmd}" ${@}
    else show_usage
    fi
}
