alias ls="eza --icons"
alias dog="bat -P"
command -v doas >/dev/null && {
    alias sudo="doas"
    alias sudoedit='doas $EDITOR'
}
alias lg="\\gl"
