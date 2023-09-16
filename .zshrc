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
    /home/shuchi/.zi/polaris/sbin /home/shuchi/.zi/polaris/bin
    /usr/local/sbin /usr/local/bin /usr/bin /usr/bin/site_perl 
    /usr/bin/vendor_perl /usr/bin/core_perl "$HOME/.local/bin"
    "$HOME/.local/share/gem/ruby/3.0.0/bin"
)

for zscript in ~/.zdir/*.zsh; do
    source "$zscript"
done

# start nvim config
export NVIMDIR="/home/shuchi/.config/nvim"
export NVIMLUA="/home/shuchi/.config/nvim/lua"
export NVIMAFTERLUA="/home/shuchi/.config/nvim/after_lua"
# end nvim config

command -v starship >/dev/null && eval "$(starship init zsh)"
