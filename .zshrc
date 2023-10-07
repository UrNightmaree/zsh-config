source <(curl -sL init.zshell.dev); zzinit

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/shuchi/.zshrc'

autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
    compinit
done
compinit -C

export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

export TZ='Asia/Makassar'

export STARSHIP_CONFIG="$HOME/.zdir/starship.toml"
export KORENG_CHRS='🐱😺😸😹😻😼😽🙀😿😾'

typeset -A ZI
ZI[BIN_DIR]="${HOME}/.zi/bin"
source "${ZI[BIN_DIR]}/zi.zsh"

path=(
    "$HOME/.zi/polaris/sbin" "$HOME/.zi/polaris/bin"
    "$HOME/.local/bin" /usr/local/sbin /usr/local/bin /usr/bin 
)

# make sure we don't populate path with non-existent path
command -v ruby >/dev/null &&
    path+=("$HOME/.local/share/gem/ruby/3.0.0/bin")
command -v perl >/dev/null &&
    path+=(/usr/bin/site_perl /usr/bin/vendor_perl /usr/bin/core_perl)
[[ -d /opt/openresty ]] &&
    path+=(/opt/openresty/bin)
[[ -d ~/.bun ]] && {
    path+=("$HOME/.bun/bin")
}

for zscript in ~/.zdir/*.zsh; do
    source "$zscript"
done

command -v starship >/dev/null && eval "$(starship init zsh)"
