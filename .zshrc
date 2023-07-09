# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/snake_naree/.zshrc'

autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
    compinit
done
compinit -C

export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

TZ='Asia/Makassar'; export TZ

typeset -A ZI
ZI[BIN_DIR]="${HOME}/.zi/bin"
source "${ZI[BIN_DIR]}/zi.zsh"

path+=(
    "$HOME/.local/bin"
)

for zscript in ~/.zdir/*.zsh; do
    source "$zscript"
done

# start nvim config
export NVIMDIR="/home/snake_naree/.config/nvim"
export NVIMLUA="/home/snake_naree/.config/nvim/lua"
export NVIMAFTERLUA="/home/snake_naree/.config/nvim/after_lua"
# end nvim config
