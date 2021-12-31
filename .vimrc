scriptencoding utf-8 "マルチバイト文字を使えるようにする
set encoding=utf-8 "文字読込をutf-8で行う

set number "行数を表示
set incsearch "インクリメンタルサーチの有効化
set wildmenu wildmode=list:full "コマンドモードの補完機能
set laststatus=2 "ファイル名を最後の行に常時表示
set statusline=%F%r%h%=

colorscheme default
syntax enable

" 挿入モードでクリップボードからペーストする時に自動でインデントさせないようにする
if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" use vim-plug
call plug#begin()
"Plug 'tpope/vim-sensible'
Plug 'Yggdroot/indentLine'
Plug 'bronson/vim-trailing-whitespace'
Plug 'reireias/vim-cheatsheet'
call plug#end()

" Path to my vim cheatsheet
let g:cheatsheet#cheat_file = '~/.cheatsheet.md'
