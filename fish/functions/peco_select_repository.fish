function peco_select_repository
  cd (ghq list --full-path | perl -nlpe 's[.*src/(.*)][$1\0$_]' | peco --null)
end
