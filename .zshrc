# Filename: .zshrc
# Last Change: 3-April-2011
# Maintainer: furu

# Japanese
export LANG=ja_JP.UTF-8

# Prompt
PROMPT="
%~
%n@%M%# "

# Title
case "${TERM}" in
kterm*|xterm)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
  }
  ;;
esac

# History
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt hist_ignore_dups

# Completion
autoload -U compinit; compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#bindkey -v

setopt prompt_subst
setopt nobeep
setopt auto_list
setopt auto_menu
setopt auto_param_slash
setopt auto_cd
setopt list_types
#setopt correct
setopt list_packed

# Alias
alias ls='ls -F --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias vi='vim'

# This loads RVM into a shell session.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 