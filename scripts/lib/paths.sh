paths() {
    show_usage()(
        echo "[ERROR] paths { get_default get_current }"
    ) >&2
    is_valid_arg()( test "$(type -t "${1}")" = 'function' )

    local _local_path="${HOME}/.local"
    local _local_bin_path="${_local_path}/bin"
    local -a _bin_paths=(
        "${_local_bin_path}"
        "usr/local/sbin"
        "/usr/local/bin"
        "/usr/sbin"
        "/usr/bin"
        "/sbin"
        "/bin"
    )
    local -a _paths_dirs=(
        "${_local_bin_path}"
        "${_local_path}"
        "${_local_path}/lib"
        "${_local_path}/share"
        "${_local_path}/share/man"
        "${_local_path}/share/info"
    )
    get_current() ( echo "${PATH}" )
    get_default() (
        _bin_path=''
        for d in "${_bin_paths[@]}"
        do _bin_path+=":${d}"
        done
        echo "${_bin_path:1}"
    )

    if is_valid_arg "${1}"
    then "${1}"
    else show_usage
    fi
}
