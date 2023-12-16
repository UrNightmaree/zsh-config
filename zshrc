if ! command -v git curl starship >/dev/null {
    echo "requires git, curl, and starship"
    exit 1
}

[[ -d ~/.zplug ]] && source <(curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh)

autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

fpath+=(
    "$Z
