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
colorscheme japanesque
highlight Conceal NONE
highlight Conceal guifg=#828282
highlight Cursor NONE
highlight Cursor guibg=#268bd2 guifg=#ffffff
"}}}

" Mouse:"{{{
" Show popup menu if right click.
set mousemodel=popup
" Don't focus the window when the mouse pointer is moved.
set nomousefocus
" Hide mouse pointer on insert mode.
set mousehide
"}}}
