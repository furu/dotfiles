" Filename: _vimrc
" Last Change: 30-March-2011
" Maintainer: furu

"-------------------------------------------
" pathogenの設定
"-------------------------------------------
" pathogenでftdetectなどをloadさせるために一度ファイルタイプ判定をoff
filetype off
" pathogen.vimによってbundle配下のpluginをpathに加える
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
set helpfile=$VIMRUNTIME/doc/help.txt
" ファイルタイプ判定をon
filetype plugin indent on

"-------------------------------------------
" Set augroup.
"-------------------------------------------
augroup MyAutoCmd
  autocmd!
augroup END

"-------------------------------------------
" 基本設定
"-------------------------------------------
" viとの互換性を取らない(vim独自拡張機能を使うため)
set nocompatible
" バックアップを作成しない
set nobackup
" スワップファイルを作成しない
set noswapfile
" 編集中でも他のファイルを開ける
set hidden
" バックスペースでなんでも消せる
set backspace=indent,eol,start
" 改行コードの自動認識優先順位
"if has('win32') || has('win64')
	set fileformats=dos,unix,mac
"else
	set fileformats=unix,dos,mac
"endif
" 行番号の表示
set number
" タイトルバーにファイル名を表示
set title
" クリップボードをWindowsと連携
set clipboard& clipboard+=unnamed
" ルーラーを表示
set ruler
" カレント行をハイライト
set cursorline
" カレントウィンドウにのみ罫線を引く
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

hi clear CursorLine
hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black
" 折り返しを有効
set wrap
" シンタックスカラー(オン)
syntax on
" 開いているファイルのディレクトリに移動
" あまり推奨されないっぽい
" -> 代わりにカレントディレクトリ移動のためのキーマッピングを定義した
"set autochdir
" 閉じ括弧のマッチを表示する時間(1/10秒単位)
set matchtime=2
" コマンド補完を強化
set wildmenu
" カーソルが行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
" スクロール時の余白確保
set scrolloff=5
" 画面最後の行をできる限り表示する
set display=lastline
" ビープを鳴らさない
"set vb t_vb=
" 他で書き換えられたら自動で読みなおす
set autoread
" コマンドラインの高さ
set cmdheight=2
" 常にステータスラインを表示
set laststatus=2
" ステータスラインに文字コード、改行コード、ファイルタイプなどを表示する
"set statusline=%<%f¥ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}¥ %y%=%l,%c%V%8P
" Enable mouse support.
set mouse=a

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

" default tab settings
" タブの表示幅
set tabstop=4
" 
set softtabstop=4
" 自動インデント時の空白の数
set shiftwidth=4
" タブをスペースにする
set expandtab
" default indent settings
set cindent


"-------------------------------------------
" Search
"-------------------------------------------
" 最後まで検索したら先頭へ戻る
set wrapscan
" 大文字小文字無視
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索
set smartcase
" インクリメントサーチ
set incsearch
" 検索文字をハイライト
set hlsearch


"-------------------------------------------
" Key-mappings
"-------------------------------------------
" カーソルを表示行で移動
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

" 1画面ずつページ送り
noremap <Space>j <C-f>
noremap <Space>k <C-b>

" ノーマルモードで挿入モードにならず現在の行の下に空行を挿入する
" その際、インデントやコメントの自動挿入は行われない
" Oを使うので、現在の行の上に空行を挿入することができなくなるけど、あんまり使わないのでOK
nnoremap O :<C-u>call append(expand('.'), '')<Cr>j

" <C-h>: ヘルプを引く
nnoremap <C-h> :<C-u>help<Space>
" <C-h><C-h>: カーソル下のキーワードを:helpで引く
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><CR>

" 最後に選択したテキストの選択
nnoremap gc '[v']
vnoremap gc :<C-u>normal gc<CR>
onoremap gc :<C-u>normal gc<CR>

" バッファ一覧を表示し、番号を入力することでバッファを切り替える
nnoremap <Space>b :ls<Enter>:buffer<Space>

" 自動で挿入されたインデントが、何も入力せずにインサートモードを抜けたり、さらに新しい行を作ったりした場合に削除されないようにする
nnoremap o oX<C-h>
inoremap <CR> <CR>X<C-h>

" <Space>cd: change current directory. 
nnoremap <silent> <Space>cd :<C-u>CD<CR>

" <Esc><Esc>: nohlsearch
nnoremap <Esc><Esc> :nohlsearch<CR>


"-------------------------------------------------------
" _vimrcと_gvimrcの編集と反映のためのKey-mappingの定義
"-------------------------------------------------------
" <Space>ev: Edit _vimrc.
nnoremap <silent> <Space>ev :<C-u>edit $MYVIMRC<CR>
" <Space>eg: Edit _gvimrc.
nnoremap <silent> <Space>eg :<C-u>edit $MYGVIMRC<CR>
" <Space>rv: Load _vimrc.
"            Load _gvimrc after .vimrc edited at Gvim.
"nnoremap <silent> <Space>rv :<C-u>source $MYVIMRC ¥| if has('gui_running') ¥| source $MYGVIMRC ¥| endif <CR>
" <Space>rg: Load _gvimrc.
nnoremap <silent> <Space>rg :<C-u>source $MYGVIMRC<CR>

" 
"if !has('gui_running') && !(has('win32') || has('win64'))
"  autocmd MyAutoCmd BufWritePost $MYVIMRC nested source $MYVIMRC
"else
"  autocmd MyAutoCmd BufWritePost $MYVIMRC source $MYVIMRC |
"        ¥ if has('gui_running') | source $MYGVIMRC
"  autocmd MyAutoCmd BufWritePost $MYGVIMRC if has('gui_running) | source $MYGVIMRC
"endif


"----------------------------------------------------
" Ex command
"----------------------------------------------------
" 文字エンコーディングを指定してファイルを開き直すためのコマンド
command! -bang -bar -complete=file -nargs=? Cp932 edit ++enc=cp932
command! -bang -bar -complete=file -nargs=? EucJp edit ++enc=euc-jp
command! -bang -bar -complete=file -nargs=? Iso2022jp edit ++enc=iso-2022-jp
command! -bang -bar -complete=file -nargs=? Utf8 edit ++enc=utf-8
" Aliases
command! -bang -bar -complete=file -nargs=? Jis Iso2022jp
command! -bang -bar -complete=file -nargs=? Sjis Cp932

" 定義されているマッピングを調べる
command!
      ¥	-nargs=* -complete=mapping
      ¥	AllMaps
      ¥	map <args> | map! <args> | lmap <args>

" Scouter {{{
function! Scouter(file, ...)
  let pat = '^¥s*$¥|^¥s*"'
  let lines = readfile(a:file)
  if !a:0 || !a:1
    let lines = split(substitute(join(lines, "¥n"), '¥n¥s*¥¥', '', 'g'), "¥n")
  endif
  return len(filter(lines, 'v:val !‾ pat'))
endfunction "}}}
" :Scouterで_vimrcの戦闘力を計測
command! -bar -bang -nargs=? -complete=file Scouter
      ¥ echo Scouter(empty(<q-args>) ? $MYVIMRC : expand(<q-args>), <bang>0)
" :GScouterで_gvimrcの戦闘力を計測
command! -bar -bang -nargs=? -complete=file GScouter
      ¥ echo Scouter(empty(<q-args>) ? $MYGVIMRC : expand(<q-args>), <bang>0)

" Open junk file."{{{
command! -nargs=0 JunkFile call s:open_junk_file()
function! s:open_junk_file()
  let l:junk_dir = $HOME . '/.vim_junk' . strftime('/%Y/%m')
  if !isdirectory(l:junk_dir)
    call mkdir(l:junk_dir, 'p')
  endif

  let l:filename = input('Junk Code: ', l:junk_dir . strftime('/%Y-%m-%d-%H%M%S.'))
  if l:filename != ''
    execute 'edit ' . l:filename
  endif
endfunction "}}}

" Change current directory. {{{
command! -nargs=? -complete=dir -bang CD call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang)
  if a:directory == ''
    lcd %:p:h
  else
    execute 'lcd' . a:directory
  endif


  if a:bang == ''
    pwd
  endif
endfunction "}}}


"----------------------------------------------------
" autocmd
"----------------------------------------------------
" ↓をやるとエラーが発生する
" augroup MyAutoCmd
  " autocmd!
  " autocmd MyAutoCmd FileType javascript setlocal fileencoding=utf-8
  " autocmd MyAutoCmd FileType html setlocal fileencoding=utf-8
  " autocmd MyAutoCmd FileType css setlocal fileencoding=utf-8
" augroup END

" autocmd!
" autocmd FileType javascript setlocal fileencoding=utf-8

augroup MyTab
  autocmd!
  autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType vim setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType css setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
augroup END

augroup MySkeleton
  autocmd!
  autocmd BufNewFile *.rb 0r ‾/vimfiles/templates/skeleton.rb
augroup END

" au User Rails* set fenc=utf-8

autocmd FileType ruby setlocal fenc=utf-8

autocmd BufNewFile *.js setlocal fenc=utf-8


"-------------------------------------------
" necomplcacheの設定
"-------------------------------------------
" 起動時に有効にする
let g:neocomplcache_enable_at_startup = 1
" 大文字が入力されるまで大文字小文字の区別を無視
let g:neocomplcache_enable_smart_case = 1
" _区切りの補完を有効化する
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '¥h¥w*'

" タブで補完
inoremap <expr><TAB> pumvisible() ? "¥<C-n>" : "¥<TAB>"
"
inoremap <expr><CR> neocomplcache#smart_close_popup() . "¥<CR>"
" <C-h>、<BS>を押したときに確実にポップアップを削除する
inoremap <expr><C-h> neocomplcache#smart_close_popup() . "¥<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup() . "¥<C-h>"
" <C-e> : 現在選択している候補をキャンセルし、ポップアップを閉じる
inoremap <expr><C-e> neocomplcache#cancel_popup()
" <C-y> : 補完を選択し、ポップアップを閉じる
inoremap <expr><C-y> neocomplcache#close_popup()
" <C-s> : スニペット展開
imap <C-s> <Plug>(neocomplcache_snippets_expand)
smap <C-s> <Plug>(neocomplcache_snippets_expand)


"-------------------------------------------
" quicklaunchの設定
"-------------------------------------------
" 今は必要ないのでOFF
let g:loaded_quicklaunch = 1


"-------------------------------------------
" surroundの設定
"-------------------------------------------
"nmap s <Plug>Ysurround
"nmap ss <Plug>Yssurround


"-------------------------------------------
" NERDCommenterの設定
"-------------------------------------------
" Default key-mappings off.
let g:NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1
" My key-mappings define.
nmap <Leader>cc <Plug>NERDCommenterToggle
vmap <Leader>cc <Plug>NERDCommenterToggle
nmap <Leader>cm <Plug>NERDCommenterMinimal
vmap <Leader>cm <Plug>NERDCommenterMinimal
nmap <Leader>ca <Plug>NERDCommenterAppend
nmap <Leader>c$ <Plug>NERDCommenterToEOL
vmap <Leader>cs <Plug>NERDCommenterSexy


"-------------------------------------------
" vimshellの設定
"-------------------------------------------
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":‾")'
let g:vimshell_enable_auto_slash = 1
let g:vimshell_enable_smart_case = 1

if has('win32') || has('win64')
  let g:vimshell_prompt = "furu" . "@". hostname() . "% "
else
  let g:vimshell_prompt = $USER . "@". hostname() ."% "

  call vimshell#set_execute_file('bmp,jpg,png,gif', 'gexe eog')
  call vimshell#set_execute_file('mp3,m4a,ogg', 'gexe amarok')
  let g:vimshell_execute_file_list['zip'] = 'zipinfo'
  call vimshell#set_execute_file('tgz,gz', 'gzcat')
  call vimshell#set_execute_file('tbz,bz2', 'bzcat')
endif


"-------------------------------------------
" ref-alcの設定
"-------------------------------------------
let g:ref_alc_start_linenumber = 50


