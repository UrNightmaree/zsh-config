alias ls="exa --icons"
alias dog="bat -P"
alias mdl='"$(command -v markdownlint-cli || command -v markdownlint-cli2)"'

_rm() {
    for p in "$@"; do
        if [[ -d "$p" ]]; then
            rm "$p"
            \rm -i "$p"
        else
            \rm -i "$p"
        fi
    done
}
alias rm="_rm"
