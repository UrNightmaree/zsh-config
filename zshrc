~/.bin/pfetch; echo
fpath+=( ~/.zfunctions )

SECONDS=0
export ZPLUG_HOME="$HOME/.zplug"
[[ -d ~/.zplug ]] || git clone https://github.com/zplug/zplug "$ZPLUG_HOME"

source ~/.zplug/init.zsh

###<===[  loading up funs  ]===>###

zplug 'z-shell/f-sy-h'

zplug 'zsh-users/zsh-autosuggestions'

zplug 'zsh-users/zsh-history-substring-search'

zplug 'jeffreytse/zsh-vi-mode'

zplug 'hlissner/zsh-autopair', defer:2

zplug 'davidde/git'

alias x=z
AUTOCD=1
zplug 'z-shell/zsh-eza', if:'command -v eza'

zplug 'z-shell/zsh-zoxide', if:'command -v zoxide'

zplug 'none9632/zsh-sudo', if:'command -v sudo'

fpath+=( ~/.zplug/repos/asdf-vm/asdf/completions )
zplug 'asdf-vm/asdf', at:v0.14.0, use:asdf.sh

autoload -Uz myecho

if ! zplug check --verbose; then
    printf "%s" "$(myecho "Install? [y/N]: ")"
    read -q
    yn=$((!$?))
    (( yn )) && { echo; zplug install; }
fi

{ (( yn )) && zplug load --verbose; } || zplug load
myecho $'zplug setup took \e[32m'"${SECONDS}s"
unset SECONDS

###<===[ let the fun begin ]===>###

#~ general setup

setopt append_history
setopt share_history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt hist_expire_dups_first
setopt extended_history

path+=( ~/.bin ~/.local/bin )

autoload -Uz has_command

if ! has_command starship; then
    >&2 echo "Starship is required to initialize the prompt."
    return 1
fi

export KORENG_CHRS='🐱😺😸😹😻😼😽🙀😿😾'
export STARSHIP_CONFIG="$HOME/.starship.toml"
source <(starship init zsh)

export LC_ALL=en_US.UTF-8

#~~ additional configs

[[ -d /opt/openresty && "$PATH" != *:/opt/openresty/bin:* ]] && path+=( /opt/openresty/bin )

export BUN_INSTALL="$HOME/.bun"
[[ -d "$BUN_INSTALL" && "$PATH" != *":$BUN_INSTALL/bin:"* ]] && path+=( "$BUN_INSTALL/bin" )

export PARU_CONF="$HOME/.paru.conf"

#~~ bun completion

[[ -s "/home/komothecat/.bun/_bun" ]] && source "/home/komothecat/.bun/_bun"

#~~ direnv setup

has_command direnv && source <(direnv hook zsh)

#~~ pnpm setup

alias pn=pnpm
export PNPM_HOME="/home/komo/.local/share/pnpm"
has_command pnpm && [[ "$PATH" != *":$PNPM_HOME:"* ]] && path+=( "$PNPM_HOME" )

#~~ xmake setup

[[ -d ~/.xmake ]] && source ~/.xmake/profile

#~ set f-sy-h theme

[[ -e ~/.config/f-sy-h/catppuccin.ini ]] || { mkdir -p ~/.config/f-sy-h; curl -Lo ~/.config/f-sy-h/catppuccin.ini "https://github.com/catppuccin/zsh-fsh/blob/main/themes/catppuccin-mocha.ini?raw=true"; }
[[ "$(fast-theme -s)" == *catppuccin* ]] || fast-theme CONFIG:catppuccin

#~ set zsh-autosuggestions config

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#45475a"
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)

#~ set EDITOR and PAGER, only if it exist.

: ${EDITOR:=$(command -v nvim)}
: ${PAGER:=$(command -v most)}
export EDITOR PAGER
export LESSHISTFILE=- # damn you less, you're cluttering your histfile in $HOME!

#~ setup nnn


BLK="03" CHR="03" DIR="04" EXE="02" REG="07" HARDLINK="05" SYMLINK="05" MISSING="08" ORPHAN="01" FIFO="06" SOCK="03" UNKNOWN="01"

export NNN_COLORS="#04020301;4231"

export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$UNKNOWN"

#~ setup nnn plugins

if has_command nnn; then
    sh -c "$(curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs)" >/dev/null 2>&1 || echo "failed to fetch nnn plugins"

    NNN_autojump="x:autojump;"
    NNN_preview='.:-!bat "$nnn";'

    export NNN_PLUG="$NNN_autojump$NNN_preview"
fi

#~ util commands

autoload -Uz \
    up

alias ..=up

#~ options (must always in the end of the rc file)

setopt autocd
setopt no_beep
