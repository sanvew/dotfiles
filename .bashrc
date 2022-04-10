#    _               _
#   | |             | |
#   | |__   __ _ ___| |__  _ __ ___
#   | '_ \ / _` / __| '_ \| '__/ __|
#  _| |_) | (_| \__ \ | | | | | (__
# (_)_.__/ \__,_|___/_| |_|_|  \___|

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# history preferences
HISTCONTROL=ignoreboth
HISTSIZE=-1
HISTFILESIZE=-1
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    RS="\[\033[0m\]"    # reset
    HC="\[\033[1m\]"    # hicolor
    FGRN="\[\033[32m\]" # foreground green
    FYEL="\[\033[33m\]" # foreground yellow
    FBLE="\[\033[34m\]" # foreground blue
    PS1="$HC$FYEL[$RS${debian_chroot:+($debian_chroot)}$HC$FGRN\u@\h $HC$FBLE\w$HC$FYEL]$RS\$ "
else
    PS1='[${debian_chroot:+($debian_chroot)}\u@\h \w]\$ '
fi
unset color_prompt force_color_prompt

GPG_TTY=$(tty)
export GPG_TTY

# aliases
[ -e $HOME/.bash_aliases ] && source $HOME/.bash_aliases

# completions
[ -e /usr/share/bash-completion/bash_completion ] \
    && source /usr/share/bash-completion/bash_completion
if [ -e /usr/share/bash-complete-alias/complete_alias ]; then
    source /usr/share/bash-complete-alias/complete_alias
    complete -F __start_kubectl k
    complete -F _complete_alias d
    complete -F _complete_alias dco
fi

# git bash prompt
function source_git-bash-prompt() {
    GIT_PROMPT_ONLY_IN_REPO=1
    GIT_PROMPT_THEME=Single_line
    source $HOME/.local/src/bash-git-prompt/gitprompt.sh
}
function clone_git-bash-prompt() {
    git clone https://github.com/magicmonty/bash-git-prompt.git $HOME/.local/src/bash-git-prompt --depth=1
}
[ -f "$HOME/.local/src/bash-git-prompt/gitprompt.sh" ] && source_git-bash-prompt \
    || { clone_git-bash-prompt && clone_git-bash-prompt ; }

# environment files
[ -e $HOME/.env ] && source $HOME/.env

# lf settings
LFCD=$HOME/.config/lf/lfcd.sh
if [ -f "$LFCD" ]; then
    source "$LFCD"
fi
bind '"\C-o":"lfcd\C-m"'

export EDITOR=/usr/bin/nvim

PATH=$PATH:~/go/bin:~/.scripts
