~/.bin/pfetch; echo
fpath+=( ~/.zfunctions )

SECONDS=0
mkdir -p ~/.cache
[[ -f ~/.cache/zii ]] || curl -fSsLo ~/.cache/zii init.zshell.dev
source ~/.cache/zii
zzinit

###<===[  loading up funs  ]===>###
+(){ zi ice "$@"; }
load(){ zi light "$@"; }
snippet(){ zi snippet "$@"; }

load 'z-shell/z-a-default-ice'

zi default-ice lucid >/dev/null 2>&1

load 'z-shell/f-sy-h'

+ atload'bindkey -v'
load 'jeffreytse/zsh-vi-mode'

+ wait
load 'z-shell/zsh-fancy-completions'

load 'zsh-users/zsh-autosuggestions'

+ wait \
  atload"bindkey '^[[A' history-substring-search-up
         bindkey '^[[B' history-substring-search-down" \
  atinit'HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="underline"
         HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="underline fg=red"'
load 'zsh-users/zsh-history-substring-search'

+ wait'2'
load 'hlissner/zsh-autopair'

load 'davidde/git'

MYPATCH="--branch patch-1"

+ wait has'eza' atinit'AUTOCD=1' cloneopts"$MYPATCH"
load 'cattokomo/zsh-eza'

+ wait has'zoxide' cloneopts"$MYPATCH"
load 'cattokomo/zsh-zoxide'

+ has'sudo'
load 'none9632/zsh-sudo'

+ pick'asdf.sh' cloneopts'--branch v0.14.0'
load 'asdf-vm/asdf'

+ atclone'dircolors -b LS_COLORS > clrs.zsh' \
  atpull'%atclone' pick"clrs.zsh" nocompile'!' \
  atload'zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}'
load trapd00r/LS_COLORS

+ pick'git-sync' as'program'
snippet 'https://github.com/simonthum/git-sync/raw/master/git-sync'

unfunction + load

autoload -Uz myecho
myecho $'load setup took \e[32m'"${SECONDS}s"
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

autoload -Uz compinit; compinit -C
(autoload -Uz compinit; compinit &)

zstyle ':completion:*' menu-select

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
if [[ "$PATH" != *":$PNPM_HOME:"* ]]; then
    path+=( "$PNPM_HOME" )
fi

#~~ xmake setup

[[ -d ~/.xmake ]] && source ~/.xmake/profile

#~~ cargo setup

[[ -d ~/.cargo ]] && path+=( ~/.cargo/bin )

#!! wait

wait

#~ set f-sy-h theme

[[ "$FAST_THEME_NAME" == safari ]] || fast-theme safari

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

#~ sigi alias

if has_command sigi; then
  alias \
    todo="sigi -t todo" \
    ideas="sigi -t ideas"
fi

#~ util commands

autoload -Uz \
    up

alias ..=up

#~ options (must always in the end of the rc file)

setopt autocd
setopt no_beep
