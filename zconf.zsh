# use autocd
setopt autocd

# fix HOME-END key
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

# fix LD_LIBRARY_PATH
[[ "$LD_LIBRARY_PATH" =~ /usr/local/lib ]] ||
    export LD_LIBRARY_PATH="${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}/usr/local/lib"
