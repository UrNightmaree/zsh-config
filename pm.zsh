{# OMZ plugins
}

{# plugins
    command -v starship >/dev/null || {
        zi load "agkozak/agkozak-zsh-prompt"
        bindkey -v

        AGKOZAK_CMD_EXEC_TIME=3

        AGKOZAK_COLORS_CMD_EXEC_TIME=117
        AGKOZAK_COLORS_EXIT_STATUS=196
        AGKOZAK_COLORS_PATH=69
        AGKOZAK_COLORS_BRANCH_STATUS=76
        AGKOZAKTIDE_COLORS_PROMPT_NORMAL=76
        AGKOZAKTIDE_COLORS_PROMPT_VI=45
        AGKOZAKTIDE_COLORS_PROMPT_NONZERO=196
        AGKOZAKTIDE_COLORS_CLOCK=gray

        AGKOZAK_CUSTOM_PROMPT=$'\n'
        # Directory
        AGKOZAK_CUSTOM_PROMPT+=$'%B%F{$AGKOZAK_COLORS_PATH}%2v%f%b'
        # Exec time
        AGKOZAK_CUSTOM_PROMPT+=$'%(9V.\n%F{$AGKOZAK_COLORS_CMD_EXEC_TIME}%9v :: %f.)'
        # Exit code & Job
        AGKOZAK_CUSTOM_PROMPT+=$'%(?..%(9V..\n)[%F{$AGKOZAK_COLORS_EXIT_STATUS}:%?%f%(1j..]))%(1j.%(?.\n[. )%F{$AGKOZAK_COLORS_BG_STRING}*%j%f].)'
        # Prompt
        AGKOZAK_CUSTOM_PROMPT+=$'\n%(?.%(4V.%F{$AGKOZAKTIDE_COLORS_PROMPT_VI}≈>%f.%F{$AGKOZAKTIDE_COLORS_PROMPT_NORMAL}=>%f).%F{$AGKOZAKTIDE_COLORS_PROMPT_NONZERO}=>%f) '

        AGKOZAK_CUSTOM_RPROMPT=""
        # Git status
        AGKOZAK_CUSTOM_RPROMPT+=$'%(3V.%F{${AGKOZAK_COLORS_BRANCH_STATUS}}%6v%(7V. %7v.)%f.) '
        # Clock
        AGKOZAK_CUSTOM_RPROMPT+="%F{$AGKOZAKTIDE_COLORS_CLOCK}%*%f"
    }

    zi light "zdharma-continuum/fast-syntax-highlighting"

    zi ice pick"zsh-autosuggestions.zsh"
    zi light "zsh-users/zsh-autosuggestions" && {
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#9399b2"
    }

    zi ice pick"zsh-history-substring-search.zsh"
    zi light "zsh-users/zsh-history-substring-search" && {
        bindkey '^[[A' history-substring-search-up
        bindkey '^[[B' history-substring-search-down

        HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="underline,bold"
        HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="fg=1,underline,bold"
    }

    zi light "davidde/git" && {}

    zi light "jeffreytse/zsh-vi-mode" && {}

    zi ice has'sudo'
    zi light "hcgraf/zsh-sudo" && {}

    zi ice has'doas'
    zi light "anatolykopyl/doas-zsh-plugin" && {}

    zi ice has'zoxide'
    zi light "z-shell/zsh-zoxide" && {}

    zi ice has'git' has'curl' pick'asdf.sh' cloneopts'--branch v0.13.1'
    zi light "asdf-vm/asdf"
}

# vim: set ts=4 sw=4 expandtab:
