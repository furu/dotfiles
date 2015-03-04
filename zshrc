# Emacs keybind
bindkey -e

setopt share_history
setopt auto_pushd
setopt pushd_ignore_dups
setopt hist_ignore_dups
setopt inc_append_history
setopt auto_cd
setopt beep
setopt extended_glob
setopt nomatch
setopt no_complete_aliases
unsetopt append_history
unsetopt notify

# Remove duplicated path.
typeset -U path PATH

HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

# Completion

fpath=(${HOME}/.zsh/git-issue-zsh-completion $fpath)
fpath=(${HOME}/.zsh.local/site-functions $fpath)

zstyle :compinstall filename '/Users/furu/.zshrc'
autoload -Uz compinit promptinit
compinit
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}'

# Prompt
autoload -Uz colors
colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd() {
  psvar=()
  vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

autoload -Uz zmv
alias zmv='noglob zmv -W'

PROMPT="
%{$fg[cyan]%}%~ %1(v|%F{green}%1v%f|)
%{$fg_bold[red]%}➜  %{$reset_color%}"

# Pretty print PATH
p() {
  echo ${PATH} | tr : \\n
}

# Last emerge --sync
last_synced() {
  genlop --rsync | tail -n 2
}

# \ ramen timer !!! / ﾃｰﾚｯﾃﾚｰ ( thx id:nkgt_chkonk )
ramen() {
  sleep 180 && say -v Zarvox ramen de ki ta yo
}

# everyone say 'hi'. ( thx @eielh )
hi() {
  for voice in `say -v '?' | cut -f1 -d ' '`; do echo $voice; say -v $voice hi; done
}

# https://github.com/peco/peco/wiki/Sample-Usage#pecoghq--ghq--peco-miyagawa
peco-ghq() {
  cd $(ghq list --full-path | perl -nlpe 's[.*src/(.*)][$1\0$_]' | peco --null)
}

# Global Aliases
alias -g L='| less'
alias -g G='| grep'

# Aliases
# http://qiita.com/items/a7807e3bac5a30791566
alias reload='exec zsh --login'
alias udon='emerge --ask --update --deep --newuse --tree world'
alias be='bundle exec'
alias ls='ls --color=auto -F'
alias l='ls --color=auto -F'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias grep='grep --color=auto'
alias cp='cp -irp'
alias chou='echo "Execute \"sudo pacman -Syu\""; sudo pacman -Syu'
alias g='git'
alias gl='peco-ghq'

# For R Programming Language
disable r

WORDCHARS=${WORDCHARS/\//}

[ -e ${HOME}/.zsh/z/z.sh ] && source ${HOME}/.zsh/z/z.sh

# Source local zshrc
[ -e ~/.zshrc.local ] && source ~/.zshrc.local

# Replacement of zsh bck-i-search
if type peco > /dev/null; then
  peco-select-history() {
    local tac
    if type tac > /dev/null; then
      tac="tac"
    else
      tac="tail -r"
    fi
    BUFFER=$(history -n 1 | eval $tac | peco --query "$LBUFFER")
    CUSOR=$#BUFFER
    zle -R -c
  }

  zle -N peco-select-history
  bindkey '^r' peco-select-history
fi

# Start tmux
if type tmux > /dev/null 2>&1 && [ -z "${TMUX}" ]; then
    if tmux has-session > /dev/null 2>&1; then
        tmux -2 attach
    elif; then
        tmux -2
    fi
fi
