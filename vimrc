scriptencoding utf-8

"-------------------------------------------
" neobundle.vim
"-------------------------------------------
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/tabpagebuffer.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/junkfile.vim'
NeoBundle 'Shougo/neoyank.vim'
NeoBundle 'thinca/vim-singleton'
NeoBundle 'thinca/vim-localrc'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'kana/vim-tabpagecd'
NeoBundle 'kana/vim-submode'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-lastpat'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'tyru/eskk.vim'
NeoBundle 'junegunn/vim-easy-align'

" Haskell
NeoBundle 'itchyny/vim-haskell-indent'

" Color Scheme
NeoBundle 'tomasr/molokai'

NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'mac' : 'make',
      \     'unix' : 'make',
      \    },
      \ }

call neobundle#end()

filetype plugin indent on

NeoBundleCheck


"-------------------------------------------
" macros
"-------------------------------------------
if has('vim_starting')
  runtime macros/matchit.vim
  if !has('kaoriya')
    runtime macros/encode.vim
  endif
endif


"-------------------------------------------
" singleton
"-------------------------------------------
if has('clientserver')
  call singleton#enable()
endif


"-------------------------------------------
" autocmd
"-------------------------------------------
augroup MyAutoCmd
  autocmd!
augroup END

function! s:set_indent(n)
  let &l:shiftwidth  = a:n
  let &l:softtabstop = a:n
  setlocal expandtab
endfunction
augroup MyTab
  autocmd!
  autocmd FileType ruby       call s:set_indent(2)
  autocmd FileType vim        call s:set_indent(2)
  autocmd FileType html       call s:set_indent(2)
  autocmd FileType haml       call s:set_indent(2)
  autocmd FileType css        call s:set_indent(2)
  autocmd FileType scss       call s:set_indent(2)
  autocmd FileType eruby      call s:set_indent(2)
  autocmd FileType javascript call s:set_indent(2)
  autocmd FileType php        call s:set_indent(4)
  autocmd FileType haskell    call s:set_indent(2)
  autocmd FileType go         setlocal noexpandtab tabstop=4 shiftwidth=4
  autocmd FileType go         autocmd BufWritePre <buffer> Fmt
augroup END

" Move cursor to last edit position.
autocmd MyAutoCmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

autocmd MyAutoCmd FileType gitcommit setlocal spell


"-------------------------------------------
" Basic
"-------------------------------------------
syntax enable
set nobackup
set swapfile
" Remove indent, eol and start by <BS>.
set backspace=indent,eol,start
set title
set ruler
set wrap
set showmatch
set matchtime=2
set wildmenu
set wildignorecase
set wildmode=longest:full,full
set whichwrap=b,s,h,l,<,>,[,]
set autoread
set cmdheight=2
set laststatus=2
set statusline=%<%f\ %r%h%w%m[%{&fenc!=''?&fenc:&enc}][%{&ff=='unix'?'LF':&ff=='dos'?'CRLF':'CR'}]\ %y\ %=[0x%B]\ %c,%l/%L
set list
set listchars=tab:>-,eol:$
set display=lastline
set ambiwidth=double
set splitright
set textwidth=0

" default tab & indent settings
set softtabstop=4
set shiftwidth=4
set expandtab

" Line feed code
set fileformat=unix
set fileformats=unix,dos,mac

if !exists('g:colors_name') && !has('gui_running')
  " Use 256 colors in terminal.
  set t_Co=256
  colorscheme molokai
endif

set helplang=en,ja
set formatoptions+=mM

if has('persistent_undo')
  let $UNDODIR = expand('~/.vim/undo')
  if !isdirectory($UNDODIR)
    call mkdir($UNDODIR)
  endif
  set undofile
  set undodir=$UNDODIR
endif

let $TMPDIR = expand('~/.vim/tmp')
if !isdirectory($TMPDIR)
  call mkdir($TMPDIR)
endif
set directory=$TMPDIR

" Use English interface.
language message C


"-------------------------------------------
" Searching
"-------------------------------------------
set wrapscan
set ignorecase
set smartcase
set incsearch
set hlsearch


"-------------------------------------------
" commands
"-------------------------------------------
" Reload with specified encoding.
command! -bang -bar -complete=file -nargs=? Cp932 edit ++enc=cp932 <args>
command! -bang -bar -complete=file -nargs=? EucJp edit ++enc=euc-jp <args>
command! -bang -bar -complete=file -nargs=? Iso2022jp edit ++enc=iso-2022-jp <args>
command! -bang -bar -complete=file -nargs=? Utf8 edit ++enc=utf-8 <args>
" Aliases
command! -bang -bar -complete=file -nargs=? Jis Iso2022jp <args>
command! -bang -bar -complete=file -nargs=? Sjis Cp932 <args>


"-------------------------------------------
" key mappings
"-------------------------------------------
" Move cursor by display lines.
noremap j gj
noremap k gk
noremap <Down> gj
noremap <Up> gk

" For US Keybord.
noremap ; :
noremap : ;

" :help under cursor keyword.
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><CR>

" Select last modified text.
nnoremap gc '[v']
vnoremap gc :<C-u>normal gc<CR>
onoremap gc :<C-u>normal gc<CR>

nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h') . '/' : '%%'

nnoremap <C-]> g<C-]>


"-------------------------------------------
" NERDCommenter
"-------------------------------------------
" Off default key-mappings.
let g:NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1
let g:NERDCustomDelimiters = {
     \ 'haskell': {'left': '--', 'leftAlt': '{-', 'rightAlt': '-}'}
     \ }
" Define my key-mappings.
nmap <Leader>cc <Plug>NERDCommenterToggle
vmap <Leader>cc <Plug>NERDCommenterToggle


"-------------------------------------------
" unite
"-------------------------------------------
nnoremap <silent> ,b :<C-u>Unite -buffer-name=files buffer_tab<CR>
nnoremap <silent> ,f :<C-u>Unite -buffer-name=files file<CR>
nnoremap <silent> ,r :<C-u>Unite -buffer-name=files file_rec/async<CR>
nnoremap <silent> ,t :<C-u>Unite tab:no-current<CR>
nnoremap <silent> ,y :<C-u>Unite history/yank<CR>
nnoremap <silent> ,g :<C-u>Unite -buffer-name=search grep<CR>
nnoremap <silent> ,o :<C-u>Unite outline<CR>
nnoremap <silent> ,a :<C-u>Unite file_rec/git:--cached:--others:--exclude-standard<CR>
nnoremap <silent> ,l :<C-u>UniteResume<CR>


"-------------------------------------------
" eskk
"-------------------------------------------
" Please put configuraion file to ~/.local.vimrc for each environment.


"-------------------------------------------
" submode
"-------------------------------------------
" resize window mode
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '-', '<C-w>-')
call submode#map('winsize', 'n', '', '+', '<C-w>+')

" switch tab mode
call submode#enter_with('switchtab', 'n', '', 'gt', 'gt')
call submode#enter_with('switchtab', 'n', '', 'gT', 'gT')
call submode#map('switchtab', 'n', '', 't', 'gt')
call submode#map('switchtab', 'n', '', 'T', 'gT')

let g:submode_keep_leaving_key = 1


"-------------------------------------------
" vim-easy-align
"-------------------------------------------
vmap <Enter> <Plug>(EasyAlign)
