scriptencoding utf-8

" Window:"{{{
if has('vim_starting')
  if has('win32') || has('win64')
    gui 
    set transparency=248
  elseif has('mac')
    set transparency=5
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
"}}}
