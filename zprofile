#!/usr/bin/env zsh
: ${ZDOTDIR:=~/.config/zsh}
declare -xm ZDOTDIR

: ${EDITOR:=nvim}
declare -xm EDITOR

declare -xm LESSHIST=-

autoload -Uz zkbd; zkbd

bindkey "${key[Home]}"
