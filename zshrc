export ZPLUG_HOME="$HOME/.zplug"
[[ -d ~/.zplug ]] || git clone https://github.com/zplug/zplug "$ZPLUG_HOME"
source ~/.zplug/init.zsh

###<===[  loading up funs  ]===>###

zplug 'z-shell/f-sy-h'

zplug 'zsh-users/zsh-autosuggestions'

zplug 'zsh-users/zsh-history-substring-search'

#zplug 'jeffreytse/zsh-vi-mode' # waiting for zsh-autocomplete fix

zstyle '*:compinit' arguments -D -i -u -C -w
zplug 'marlonrichert/zsh-autocomplete' 

zplug 'hlissner/zsh-autopair', defer:2

zplug 'davidde/git'

alias x=z
AUTOCD=1
zplug 'z-shell/zsh-eza', if:'command -v eza'

zplug 'z-shell/zsh-zoxide', if:'command -v zoxide'

zplug 'none9632/zsh-sudo', if:'command -v sudo'

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    read -q
    yn=$((!$?))
    (( yn )) && { echo; zplug install; }
fi

{ (( yn )) && zplug load --verbose; } || zplug load

###<===[ let the fun begin ]===>###

#~ general setup

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

path+=( ~/.bin ~/.local/bin )

fpath+=( ~/.zfunctions )
autoload -Uz has_command

if ! has_command starship; then
    >&2 echo "Starship is required to initialize the prompt."
    return 1
fi

export KORENG_CHRS='🐱😺😸😹😻😼😽🙀😿😾'
export STARSHIP_CONFIG="$HOME/.starship.toml"
source <(starship init zsh)

#~~ additional configs

[[ -d /opt/openresty ]] && path+=( /opt/openresty/bin )

export BUN_INSTALL="$HOME/.bun"
[[ -d "$BUN_INSTALL" ]] && path+=( "$BUN_INSTALL/bin" )

export PARU_CONF="$HOME/.paru.conf"

#~~ bun completion

[[ -s "/home/komothecat/.bun/_bun" ]] && source "/home/komothecat/.bun/_bun"

#~~ direnv setup

has_command direnv && source <(direnv hook zsh)

#~ set f-sy-h theme

[[ -e ~/.config/f-sy-h/catppuccin.ini ]] || { mkdir -p ~/.config/f-sy-h; curl -Lo ~/.config/f-sy-h/catppuccin.ini "https://github.com/catppuccin/zsh-fsh/blob/main/themes/catppuccin-mocha.ini?raw=true"; }
[[ "$(fast-theme -s)" == *catppuccin* ]] || fast-theme CONFIG:catppuccin

#~ set zsh-autosuggestions config

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#45475a"
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)

#~ setup git first, and gh if it's exist.

(){
    local header=1
    if [[ -z "$(git config user.name)" ]]; then
        (( header )) && { echo "## Setting up git..."; header=0; }
	printf "Your git username: "
        read -r gitname
        git config --global user.name "$gitname"
    fi
    if [[ -z "$(git config user.email)" ]]; then
        (( header )) && echo "## Setting up git..."
	printf "Your git email: "
        read -r gitemail
        git config --global user.email "$gitemail"
    fi
}

(){
    ! has_command gh && return 0
    gh auth status >/dev/null 2>&1 && return 0
    
    echo "Detected gh command, setting up gh..."
    gh auth login
}

#~ set EDITOR and PAGER, only if it exist.

: ${EDITOR:=$(command -v nvim)}
: ${PAGER:=$(command -v moar)}
export EDITOR PAGER
export LESSHISTFILE=- # damn you less, you're cluttering your histfile in $HOME!

#~ setup nnn theme

BLK="03" CHR="03" DIR="04" EXE="02" REG="07" HARDLINK="05" SYMLINK="05" MISSING="08" ORPHAN="01" FIFO="06" SOCK="03" UNKNOWN="01"

export NNN_COLORS="#04020301;4231"

export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$UNKNOWN"

#~ setup nnn plugins

sh -c "$(curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs)" >/dev/null 2>&1 || echo "failed to fetch nnn plugins"

NNN_autojump="x:autojump;"
NNN_preview='.:-!bat "$nnn";'

export NNN_PLUG="$NNN_autojump$NNN_preview"

#~ use diff-so-fancy if exist, because we aren't robot.

if has_command diff-so-fancy; then
    git config --global core.pager "diff-so-fancy | moar"
    git config --global interactive.diffFilter "diff-so-fancy --patch"
fi

#~ default diff color looks ugly, use the fancy one.

git config --global color.ui true

git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"

git config --global color.diff.meta       "11"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.func       "146 bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"

#~ options (must always in the end of the rc file)

setopt autocd
