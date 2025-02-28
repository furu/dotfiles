function fzf-select-repository
  set -l fzf_query (commandline | string escape)

  set -lx FZF_DEFAULT_OPTS (__fzf_defaults '--wrap-sign="\t↳ " --highlight-line --no-multi --tac')
  set -lx FZF_DEFAULT_OPTS_FILE
  set -lx FZF_DEFAULT_COMMAND

  set FZF_DEFAULT_COMMAND 'command ghq list'

  set -l result (eval $FZF_DEFAULT_COMMAND \| (__fzfcmd) --query=$fzf_query)
  and cd (command ghq root)/"$result"

  commandline -f repaint
end
