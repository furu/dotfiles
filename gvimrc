scriptencoding utf-8

" Fonts:"{{{
if has('win32') || has ('win64')
  " set guifont=Osaka－等幅:h12:cSHIFTJIS
  " set guifont=Ricty:h12:cSHIFTJIS
  " set guifont=Inconsolata:h12:cSHIFTJIS
  set guifont=Migu_1M:h11
elseif has('mac')
  " set guifont=Osaka－等幅:h12
  set guifont=Osaka-Mono:h14
else
  set guifont=Ricty\ 12
  " set guifont=Ricty\ Bold\ 12
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

" Don't show toolbar & menubar
set guioptions& guioptions-=T guioptions-=m

" Switch off cursor blinking.
set guicursor& guicursor+=a:blinkon0

" Setting of colorscheme.
" Don't override colorscheme.
set background=dark
colorscheme molokai
highlight Cursor guibg=#268bd2 guifg=#ffffff
" For 'landscape' colorscheme.
" highlight NonText guifg=#424242
" highlight Search term=reverse ctermfg=0 ctermbg=14 guifg=#000000 guibg=#ffff33
" if !exists('g:colors_name')
  " colorscheme wombat
" endif
"}}}
