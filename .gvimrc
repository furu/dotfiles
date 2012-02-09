" Filename: .gvimrc
" Last Change: 10-Feb-2012.
" Maintainer: furu

scriptencoding utf-8

" Fonts:"{{{
if has('win32') || has ('win64')
  " set guifont=Osaka－等幅:h12:cSHIFTJIS
  " set guifont=Ricty:h12:cSHIFTJIS
  set guifont=Inconsolata:h12:cSHIFTJIS
elseif has('mac')
  " set guifont=Osaka－等幅:h12
else
  set guifont=Ricty\ 12
  " set guifont=Osaka－等幅\ Bold\ 12,Ricty\ 12,Inconsolata\ 12,Monospace\ 12
  " set guifont=Osaka－等幅\ 12,Ricty\ 12,Inconsolata\ 12,Monospace\ 12
endif
"}}}


" Window:"{{{
if has('vim_starting')
  if has('win32') || has('win64')
    gui 
    set transparency=248
  else
    set columns=80
    set lines=27
  endif
endif

set guioptions& guioptions-=T

" Switch off cursor blinking.
set guicursor& guicursor+=a:blinkon0

" Setting of colorscheme.
" Don't override colorscheme.
colorscheme wombat
" if !exists('g:colors_name')
  " colorscheme wombat
" endif
"}}}
