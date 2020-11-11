if [[ $DISPLAY ]]; then
    # If not running interactively, do not do anything
    [[ $- != *i* ]] && return
    [[ -z "$TMUX" ]] && exec tmux
fi
alias grep='grep --color=auto'
alias ls="ls --color"
alias clip="xclip -sel cli"
set -o vi
PS1='${debian_chroot:+\[\033[01;33m\]($debian_chroot)}\
\[\033[01;36m\]\u\
\[\033[01;31m\]@\
\[\033[01;32m\]\h\
\[\033[33m\]:\
\[\033[01;34m\]\w\
\[\033[00m\]\$ '
