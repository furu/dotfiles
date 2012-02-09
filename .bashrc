#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias dp='dropbox'
alias dpst='dropbox status'
alias dpls='dropbox ls'
alias grep='grep --color=auto'
# PS1='[\u@\h \W]\$ '

# export LESS=' -R'
# export LESSOPEN='| /usr/bin/src-hilite-lesspipe.sh %s'
export EDITOR="vim"
