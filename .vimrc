scriptencoding utf-8
set encoding=utf-8

let mapleader = "\<Space>"
"vim-fugitive
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gc :Gcommit<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>gb :Gblame<CR>

set number
set expandtab
set incsearch
set wildmenu wildmode=list:full
set statusline=%F%r%h%=
set ignorecase
set smartcase

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
Plug 'vim-airline/vim-airline'
Plug 'Townk/vim-autoclose'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
"jPlug ''
"jPlug ''
"jPlug ''
"jPlug ''
call plug#end()

" Path to my vim cheatsheet
let g:cheatsheet#cheat_file = '~/.cheatsheet.md'
