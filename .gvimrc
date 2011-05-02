" Filename: .gvimrc
" Last Changed: 29-April-2011
" Maintainer: furu

scriptencoding utf-8

set guicursor=a:blinkon0

" Font
if has('win32') || has ('win64')
  set guifont=Osaka－等幅:h12:cSHIFTJIS
  set guifontwide=VL_ゴシック:h12:cSHIFTJIS
elseif has('mac')
  set guifont=Osaka－等幅:h12
else
  " set guifont=Monospace\ 12
  set guifont=Inconsolata\ 12
  set guifontwide=TakaoExゴシック\ 12
endif

set guioptions& guioptions-=T

" Window
if has('win32') || has('win64')
  gui 
  set transparency=248
else
  set columns=80
  set lines=22
endif

colorscheme wombat
