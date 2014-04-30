" Use Vim default instead of 100% vi compatibility.
set nocompatible

let s:is_windows = has('win32') || has('win64')
let s:is_mac = has('macunix') || (executable('uname') && system('uname') =~? '^darwin')

if s:is_windows
  let $DOTVIM = expand('~/vimfiles')
  let $TMPDIR = expand('~/vimfiles/tmp')
else
  let $DOTVIM = expand('~/.vim')
  let $TMPDIR = expand('~/.vim/tmp')
endif
if !isdirectory($TMPDIR)
  call mkdir($TMPDIR)
endif

if !exists($MYGVIMRC)
  let $MYGVIMRC = expand('~/.gvimrc')
endif

" Use English interface.
if s:is_windows
  " For Windows.
  language message en
else
  " For Linux and Mac.
  language message C
endif

if s:is_windows
  set shellslash
endif


augroup MyAutoCmd
  autocmd!
augroup END


"-------------------------------------------
" neobundle.vim
"-------------------------------------------
if has('vim_starting')
  set runtimepath+=$DOTVIM/bundle/neobundle.vim
endif
call neobundle#rc(expand('$DOTVIM/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'

" Unite
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'sgur/unite-git_grep'
NeoBundle 'rhysd/unite-codic.vim'
  NeoBundle 'koron/codic-vim'
NeoBundle 'ujihisa/unite-colorscheme'

NeoBundle 'Shougo/junkfile.vim'
NeoBundle 'Shougo/echodoc'

NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/syntastic'

NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-visualstar'
NeoBundle 'thinca/vim-singleton'
NeoBundle 'thinca/vim-scouter'
NeoBundle 'thinca/vim-fontzoom'

NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'

NeoBundle 'kana/vim-smartchr'
NeoBundle 'kana/vim-tabpagecd'
NeoBundle 'kana/vim-submode'

NeoBundle 'tyru/eskk.vim'
NeoBundle 'tyru/restart.vim'

NeoBundle 'heavenshell/vim-quickrun-hook-unittest'

NeoBundle 'osyo-manga/vim-anzu'

" Color Scheme
NeoBundle 'tomasr/molokai'

" Syntax Hightlighting
NeoBundle 'zaiste/tmux.vim'
NeoBundle 'cespare/vim-toml'
NeoBundle 'othree/html5.vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'Keithbsmiley/rspec.vim'
NeoBundle 'tpope/vim-haml'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'evidens/vim-twig'


" Build vimproc.
if !s:is_windows
  NeoBundle 'Shougo/vimproc', {
              \ 'build' : {
              \     'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
              \     'mac' : 'make -f make_mac.mak clean && make -f make_mac.mak',
              \     'unix' : 'make -f make_unix.mak clean && make -f make_unix.mak',
              \    },
              \ }
endif

filetype plugin indent on


if has('vim_starting')
  runtime macros/matchit.vim
  if !has('kaoriya')
    runtime macros/encode.vim
  endif
endif

" Do not work on MacVim :(
" if has('clientserver')
  " call singleton#enable()
" endif

"-------------------------------------------
" Basic
"-------------------------------------------
" Enable syntax color.
syntax enable
" Don't create backup file.
set nobackup
" Create swap file.
set swapfile
set directory=$TMPDIR
" 編集中でも他のファイルを開ける
" set hidden
" Remove indent, eol and start by <BS>.
set backspace=indent,eol,start
" Show line number.
set number
" Show file name on title bar.
set title
" Use clipboard.
" set clipboard& clipboard+=unnamed
" Show cursor position.
set ruler
" Enable wrap.
set wrap
" 開いているファイルのディレクトリに移動
" あまり推奨されないっぽい
" -> 代わりにカレントディレクトリ移動のためのキーマッピングを定義した
" set autochdir
" 
set showmatch
" 閉じ括弧のマッチを表示する時間(1/10秒単位)
set matchtime=2
" コマンド補完を強化
set wildmenu
set wildignorecase
set wildmode=longest:full,full
" カーソルが行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
" スクロール時の余白確保
" set scrolloff=5
" ビープを鳴らさない
" set visualbell t_vb=
" 他で書き換えられたら自動で読みなおす
set autoread
" コマンドラインの高さ
set cmdheight=2
" 常にステータスラインを表示
set laststatus=2
" ステータスラインに文字コード、改行コード、ファイルタイプなどを表示する
set statusline=%<%f\ %r%h%w%m[%{&fenc!=''?&fenc:&enc}][%{&ff=='unix'?'LF':&ff=='dos'?'CRLF':'CR'}]\ %y\ %=[0x%B]\ %c,%l/%L
" 
set list
" 
set listchars=tab:>-,eol:$
" 画面最後の行をできる限り表示する
set display=lastline
" □や◯の文字があってもカーソル位置がずれないようにする
set ambiwidth=double
" new windows is put right
set splitright
set textwidth=0

" Mouse {{{
" Enable mouse support.
" set mouse=a

" For screen.
if &term =~ "^screen"
  augroup MyAutoCmd
    autocmd VimLeave * :set mouse=
  augroup END
  " screenでマウスを使用するとフリーズするのでその対策
  set ttymouse=xterm2
endif

if has('gui_running')
  " Show popup menu if right click.
  set mousemodel=popup
  " Don't focus the window when the mouse pointer is moved.
  set nomousefocus
  " Hide mouse pointer on insert mode.
  set mousehide
endif
" }}}

" default tab & indent settings {{{
" 
set softtabstop=4
" 自動インデント時の空白の数
set shiftwidth=4
" タブをスペースにする
set expandtab
" default indent settings
" set cindent
" }}}

if has('gui_running')
  " カレント行をハイライト
  " set cursorline
  " カレントウィンドウにのみ罫線を引く{{{
  " augroup cch
    " autocmd! cch
    " autocmd WinLeave * set nocursorline
    " autocmd WinEnter,BufRead * set cursorline
  " augroup END

  " hi clear CursorLine
  " hi CursorLine gui=underline
  " highlight CursorLine ctermbg=black guibg=black
  " }}}
endif

" Line feed code
set fileformat=unix
if s:is_windows
  set fileformats=dos,unix,mac
else
  set fileformats=unix,dos,mac
endif

" 全角スペースを強調表示
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermbg=darkgrey gui=underline guifg=darkgrey
  silent! match ZenkakuSpace /　/
endfunction
" if has('syntax')
"   augroup ZenkakuSpace
"     autocmd!
"     autocmd VimEnter,BufEnter * call ZenkakuSpace()
"   augroup END
" endif

if !exists('g:colors_name') && !has('gui_running')
  " Use 256 colors in terminal.
  set t_Co=256
  colorscheme molokai
endif

set helplang=en,ja
set formatoptions+=mM


"-------------------------------------------
" Searching
"-------------------------------------------
" 最後まで検索したら先頭へ戻る
set wrapscan
" 大文字小文字を無視
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索
set smartcase
" Incremental searching.
set incsearch
" Highlight searched words.
set hlsearch


" start of line
" cnoremap <C-A> <Home>
" end of line
" cnoremap <C-E> <End>
" forward one character
" cnoremap <C-F> <Right>
" back one character
" cnoremap <C-B> <Left>
" delete character under cursor
" cnoremap <C-D> <Del>
" recall newer command-line
" cnoremap <C-N> <Down>
" recall previous (older) command-line
" cnoremap <C-P> <Up>
" back one word
" cnoremap <Esc><C-B> <S-Left>
" forward one word
" cnoremap <Esc><C-F> <S-Right>

" カーソルを表示行で移動
noremap j gj
noremap k gk
noremap <Down> gj
noremap <Up> gk

" 1画面ずつページ送り
noremap <Space>j <C-f>
noremap <Space>k <C-b>

" For US Keybord.
noremap ; :
noremap : ;

" ノーマルモードで挿入モードにならず現在の行の下に空行を挿入する
" その際、インデントやコメントの自動挿入は行われない
" Oを使うので、現在の行の上に空行を挿入することができなくなるけど、あんまり使わないのでOK
nnoremap <silent> O :<C-u>call append(expand('.'), '')<CR>j

" :help quickly.
nnoremap <C-h> :<C-u>help<Space>
" :help under cursor keyword.
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><CR>

" 最後に選択したテキストの選択
nnoremap gc '[v']
vnoremap gc :<C-u>normal gc<CR>
onoremap gc :<C-u>normal gc<CR>

" バッファ一覧を表示し、番号を入力することでバッファを切り替える
" nnoremap <Space>b :ls<Enter>:buffer<Space>

" 自動で挿入されたインデントが、何も入力せずにインサートモードを抜けたり、さらに新しい行を作ったりした場合に削除されないようにする
nnoremap o oX<C-h>
" inoremap <CR> <CR>X<C-h>

" key-mapping for nohlsearch
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>

" key-mapping for edit .vimrc/.gvimrc
nnoremap <silent> <Space>ev :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>eg :<C-u>edit $MYGVIMRC<CR>

nnoremap <silent> <Space>rv :<C-u>source $MYVIMRC \| if has('gui_running') \| source $MYGVIMRC \| endif <CR>
nnoremap <silent> <Space>rg :<C-u>source $MYGVIMRC<CR>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h') . '/' : '%%'

nnoremap <C-]> g<C-]>

" auto reload .vimrc and .gvimrc when I edited .vimrc or .gvimrc. {{{
if !has('gui_running') && !(has('win32') || has('win64'))
  autocmd MyAutoCmd BufWritePost $MYVIMRC nested source $MYVIMRC
else
  autocmd MyAutoCmd BufWritePost $MYVIMRC source $MYVIMRC |
        \ if has('gui_running') | source $MYGVIMRC
  autocmd MyAutoCmd BufWritePost $MYGVIMRC if has('gui_running') | source $MYGVIMRC
endif
"}}}


" Reload with encoding.
command! -bang -bar -complete=file -nargs=? Cp932 edit ++enc=cp932
command! -bang -bar -complete=file -nargs=? EucJp edit ++enc=euc-jp
command! -bang -bar -complete=file -nargs=? Iso2022jp edit ++enc=iso-2022-jp
command! -bang -bar -complete=file -nargs=? Utf8 edit ++enc=utf-8
" Aliases
command! -bang -bar -complete=file -nargs=? Jis Iso2022jp
command! -bang -bar -complete=file -nargs=? Sjis Cp932

" Check defined mappings. {{{
command!
      \ -nargs=* -complete=mapping
      \ AllMaps
      \ map <args> | map! <args> | lmap <args>
"}}}

" Change current directory. {{{
function! s:ChangeCurrentDir(directory, bang)
  if a:directory == ''
    lcd %:p:h
  else
    execute 'lcd' . a:directory
  endif

  if a:bang == ''
    pwd
  endif
endfunction

command! -nargs=? -complete=dir -bang CD call s:ChangeCurrentDir('<args>', '<bang>')

nnoremap <silent> <Space>cd :<C-u>CD<CR>
"}}}

" Not work... Fix me!
" mv editing file (from sorah's vimrc) {{{
" function! s:mv_editing_file(new_file_name)
  " call system("mv ".expand('%')." ".a:new_file_name)
  " edit a:new_file_name
" endfunction

" command! -nargs=1 Rename call s:mv_editing_file(<f-args>)
"}}}

function! s:set_two_indent()
  setlocal shiftwidth=2 softtabstop=2 expandtab
endfunction

function! s:set_four_indent()
  setlocal shiftwidth=4 softtabstop=4 expandtab
endfunction


augroup MyTab
  autocmd!
  autocmd FileType ruby call s:set_two_indent()
  autocmd FileType vim call s:set_two_indent()
  autocmd FileType javascript call s:set_four_indent()
  autocmd FileType html call s:set_two_indent()
  autocmd FileType xhtml call s:set_two_indent()
  autocmd FileType haml call s:set_two_indent()
  autocmd FileType css call s:set_two_indent()
  autocmd FileType scss call s:set_two_indent()
  autocmd FileType php call s:set_four_indent()
  autocmd FileType eruby call s:set_two_indent()
  autocmd FileType jsp call s:set_two_indent()
  autocmd FileType cucumber call s:set_two_indent()
augroup END


" Move cursor to last edit position.
autocmd MyAutoCmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

autocmd MyAutoCmd BufRead,BufNewFile *.md setlocal filetype=markdown
autocmd MyAutoCmd BufRead,BufNewFile Guardfile setlocal filetype=ruby


function! s:append_binding_pry()
  call append(line(".") - 1, "binding.pry")
endfunction
command! -nargs=0 AppendBindingPry call s:append_binding_pry()
nnoremap <silent> <Space>p :<C-u>AppendBindingPry<CR>k==


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
nmap <Leader>cm <Plug>NERDCommenterMinimal
vmap <Leader>cm <Plug>NERDCommenterMinimal
nmap <Leader>ca <Plug>NERDCommenterAppend
nmap <Leader>c$ <Plug>NERDCommenterToEOL
vmap <Leader>cs <Plug>NERDCommenterSexy


"-------------------------------------------
" ref
"-------------------------------------------
autocmd FileType ref call s:initialize_ref_viewer()
function! s:initialize_ref_viewer()
  nnoremap <buffer> q <C-w>c
  setlocal nonumber
endfunction
" gem install myrurema
" rurema --init
if executable('rurema')
  let g:ref_refe_cmd = ['rurema', '--no-ask']
  let g:ref_refe_version = 2
endif


"-------------------------------------------
" echodoc
"-------------------------------------------
let g:echodoc_enable_at_startup = 1


"-------------------------------------------
" unite
"-------------------------------------------
let g:unite_source_history_yank_enable = 1
let g:unite_source_git_grep_required_pattern_length = 2
nnoremap <silent> ,b :<C-u>Unite -buffer-name=files buffer_tab<CR>
nnoremap <silent> ,f :<C-u>Unite -buffer-name=files file<CR>
nnoremap <silent> ,r :<C-u>Unite -buffer-name=files file_rec/async<CR>
nnoremap <silent> ,m :<C-u>Unite -buffer-name=files file_mru<CR>
nnoremap <silent> ,t :<C-u>Unite tab:no-current<CR>
nnoremap <silent> ,y :<C-u>Unite history/yank<CR>
nnoremap <silent> ,v :<C-u>Unite -buffer-name=files bookmark<CR>
nnoremap <silent> ,g :<C-u>Unite -buffer-name=search grep<CR>
nnoremap <silent> ,o :<C-u>Unite outline<CR>
nnoremap ,p :Unite -auto-preview<Space>
nnoremap ,h :Unite history/


"-------------------------------------------
" quickrun
"-------------------------------------------
" For RSpec
" reference: https://gist.github.com/2631964
function! BundleExecOrNot()
  if findfile('Gemfile', '.;') ==# ''
    return ''
  else
    return 'bundle exec'
  endif
endfunction

let g:quickrun_config = {}
let g:quickrun_config._ = {
      \ 'runner': 'vimproc',
      \ }
let g:quickrun_config['ruby.rspec'] = {
      \ 'command': 'rspec',
      \ 'cmdopt': '--no-color --format documentation',
      \ 'exec': BundleExecOrNot() . ' %c %o %s',
      \ }

augroup QuickRunUnitTest
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb setlocal filetype=ruby.rspec syntax=rspec
augroup END

nnoremap <silent> <Leader>t :QuickRun -mode n -runner vimproc:updatetime=10 -hook/unittest/enable 1<CR>


"-------------------------------------------
" smartchr
"-------------------------------------------
autocmd MyAutoCmd FileType ruby inoremap <buffer> <expr> { smartchr#loop('{', '#{')


"-------------------------------------------
" eskk
"-------------------------------------------
if s:is_windows
  set imdisable
  " let g:eskk#large_dictionary = {
  " \'path': "C:\Windows\IME\SKK0\DICTS\skkdict.txt",
  " \'sorted': 1,
  " \'encoding': 'euc-jp',
  " \}
  let g:eskk#large_dictionary = {
        \'path': "C:\\skkdic\\SKK-JISYO.L",
        \'sorted': 1,
        \'encoding': 'euc-jp',
        \}
elseif s:is_mac
  let g:eskk#dictionary = {
        \'path': '/Users/furu/Library/Application\ Support/AquaSKK/skk-jisyo.utf8',
        \'sorted': 0,
        \'encoding': 'utf-8',
        \}
  let g:eskk#large_dictionary = {
        \'path': "/Users/furu/Library/Application\ Support/AquaSKK/SKK-JISYO.L",
        \'sorted': 1,
        \'encoding': 'euc-jp',
        \}
else
  set imdisable
  let g:eskk#large_dictionary = {
        \'path': "/usr/share/skk/SKK-JISYO.L",
        \'sorted': 1,
        \'encoding': 'euc-jp',
        \}
endif


"-------------------------------------------
" submode
"-------------------------------------------
" resize window mode {{{
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '-', '<C-w>-')
call submode#map('winsize', 'n', '', '+', '<C-w>+')
"}}}

" switch tab mode {{{
call submode#enter_with('switchtab', 'n', '', 'gt', 'gt')
call submode#enter_with('switchtab', 'n', '', 'gT', 'gT')
call submode#map('switchtab', 'n', '', 't', 'gt')
call submode#map('switchtab', 'n', '', 'T', 'gT')
"}}}

let g:submode_keep_leaving_key = 1


"-------------------------------------------
" anzu
"-------------------------------------------
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)


"-------------------------------------------
" visualstar
"-------------------------------------------
noremap <Plug>N N
map * <Plug>(visualstar-*)<Plug>N
map # <Plug>(visualstar-#)<Plug>N
