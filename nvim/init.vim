call plug#begin()

Plug 'vim-denops/denops.vim'
Plug 'vim-skk/skkeleton'
Plug 'folke/tokyonight.nvim'
Plug 'catppuccin/nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'cocopon/iceberg.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.6' }
Plug 'nvim-treesitter/nvim-treesitter'

call plug#end()

language message C

let mapleader = "\<Space>"

noremap ; :
noremap : ;

nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
nnoremap <silent> <Leader>, :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Leader>s :<C-u>source $MYVIMRC<CR>

set statusline=%<%f\ %r%h%w%m[%{&fenc!=''?&fenc:&enc}][%{&ff=='unix'?'LF':&ff=='dos'?'CRLF':'CR'}]\ %y\ %=[0x%B]\ %c,%l/%L
set termguicolors

" skkeleton
call skkeleton#config({ 'globalDictionaries': ['/Users/furukido/.nix-profile/share/SKK-JISYO.L'] })
call skkeleton#register_keymap('input', ';', 'henkanPoint')
imap <C-j> <Plug>(skkeleton-enable)
cmap <C-j> <Plug>(skkeleton-enable)
tmap <C-j> <Plug>(skkeleton-enable)

" nvim-treesitter
lua << LUA
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  }
}
LUA

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
