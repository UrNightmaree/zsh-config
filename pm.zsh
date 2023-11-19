command -v starship >/dev/null || zi load "agkozak/agkozak-zsh-prompt"
. ~/.zdir/config/prompt.zsh

zi light "z-shell/f-sy-h"

zi ice pick"zsh-autosuggestions.zsh"
zi light "zsh-users/zsh-autosuggestions"  
. ~/.zdir/config/autosuggestions.zsh

zi ice pick"zsh-history-substring-search.zsh"
zi light "zsh-users/zsh-history-substring-search"  
. ~/.zdir/config/history-substring-search.zsh

zi light "davidde/git"  

zi light "jeffreytse/zsh-vi-mode"  

zi ice has'sudo'
zi light "hcgraf/zsh-sudo"  

zi ice has'doas'
zi light "anatolykopyl/doas-zsh-plugin"  

zi ice has'zoxide'
zi light "z-shell/zsh-zoxide"  

zi ice has'git' has'curl' pick'asdf.sh' cloneopts'--branch v0.13.1'
zi light "asdf-vm/asdf"

# vim: set ts=4 sw=4 expandtab:
