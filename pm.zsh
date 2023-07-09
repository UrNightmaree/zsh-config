{# OMZ plugins
    zi snippet OMZ::plugins/git/git.plugin.zsh
}

{# plugins
    zi load "agkozak/agkozak-zsh-prompt"; {
        AGKOZAK_CMD_EXEC_TIME=3

        AGKOZAK_COLORS_CMD_EXEC_TIME=117
        AGKOZAK_COLORS_EXIT_STATUS=196
        AGKOZAK_COLORS_PATH=69
        AGKOZAK_COLORS_BRANCH_STATUS=76
        AGKOZAKTIDE_COLORS_PROMPT_NORMAL=76
        AGKOZAKTIDE_COLORS_PROMPT_VI=45
        AGKOZAKTIDE_COLORS_PROMPT_NONZERO=196
        AGKOZAKTIDE_COLORS_CLOCK=default

        AGKOZAK_CUSTOM_PROMPT=$'\n'
        # Directory
        AGKOZAK_CUSTOM_PROMPT+=$'%B%F{$AGKOZAK_COLORS_PATH}%2v%f%b'
        # Exec time
        AGKOZAK_CUSTOM_PROMPT+=$'  %(9V.%F{$AGKOZAK_COLORS_CMD_EXEC_TIME}:: %9v%f.)\n'
        # Exit code & Job
        AGKOZAK_CUSTOM_PROMPT+=$'%(?..[%F{$AGKOZAK_COLORS_EXIT_STATUS}:%?%f%(1j..]\n))%(1j.%(?.[. )%F{$AGKOZAK_COLORS_BG_STRING}*%j%f]\n.)'
        # Prompt
        AGKOZAK_CUSTOM_PROMPT+="%(?.%(4V.%F{$AGKOZAKTIDE_COLORS_PROMPT_VI}≈>%f.%F{$AGKOZAKTIDE_COLORS_PROMPT_NORMAL}=>%f).%F{$AGKOZAKTIDE_COLORS_PROMPT_NONZERO}=>%f) "

        AGKOZAK_CUSTOM_RPROMPT=""
        # Git status
        AGKOZAK_CUSTOM_RPROMPT+=$'%(3V.%F{${AGKOZAK_COLORS_BRANCH_STATUS}}%6v%(7V. %7v.)%f.) '
        # Clock
        AGKOZAK_CUSTOM_RPROMPT+="%F{$AGKOZAKTIDE_COLORS_CLOCK}%*%f"
    }

    zi ice pick"themes/catppuccin_mocha-zsh-syntax-highlighting.zsh"
    zi load "catppuccin/zsh-syntax-highlighting"

    zi ice pick"zsh-syntax-highlighting.zsh"
    zi load "zsh-users/zsh-syntax-highlighting"

    zi ice pick"zsh-history-substring-search.zsh"
    zi load "zsh-users/zsh-history-substring-search"; {
        bindkey '^[[A' history-substring-search-up
        bindkey '^[[B' history-substring-search-down

        HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="underline,bold"
        HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="fg=1,underline,bold"
    }
}

# vim: set ts=4 sw=4 expandtab:
