# use autocd
setopt autocd

# fix HOME-END key
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

# fix LD_LIBRARY_PATH
[[ "$LD_LIBRARY_PATH" =~ /usr/local/lib ]] ||
    export LD_LIBRARY_PATH="${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}/usr/local/lib"

# fix locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# add glamour style
export GLAMOUR_STYLE="$HOME/.config/glow/mocha.json"

# start nvim config
export NVIMDIR="$HOME/.config/nvim"
export NVIMLUA="$HOME/.config/nvim/lua"
export NVIMAFTERLUA="$HOME/.config/nvim/after_lua"
# end nvim config

# enable direnv
command -v direnv >/dev/null && eval "$(direnv hook zsh)"

# set git user.{name,email}
if command -v git >/dev/null &&
 ! git config --global user.email >/dev/null &&
 ! git config --global user.name >/dev/null; then
    echo "Setup git"
    printf "Name: "
    read -r gitname
    printf "Email: "
    read -r gitemail
    git config --global user.name "$gitname"
    git config --global user.email "$gitemail"
fi

which asdf >/dev/null && . ~/.asdf/plugins/golang/set-env.zsh

# vim: set tw=4 sw=4 expandtab :
