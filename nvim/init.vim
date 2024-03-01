language message C

noremap ; :
noremap : ;

nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>

set statusline=%<%f\ %r%h%w%m[%{&fenc!=''?&fenc:&enc}][%{&ff=='unix'?'LF':&ff=='dos'?'CRLF':'CR'}]\ %y\ %=[0x%B]\ %c,%l/%L
set termguicolors

" https://neovim.io/doc/user/vim_diff.html#nvim-defaults
if !('nvim')
	filetype plugin indent on
	syntax enable

	set autoread
	set backspace=indent,eol,start
	set hlsearch
	set incsearch
	set laststatus=2
	set ruler
	set wildmenu
endif
