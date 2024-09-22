scriptencoding utf-8
set encoding=utf-8

let mapleader = "\<Space>"
"generals
inoremap <silent> <Leader>jj <Esc>
nnoremap <silent> <Leader>wq :wq<CR>
nnoremap <silent> <Leader>q :q<CR>
noremap <silent> <Leader>a myggVG$
inoremap <silent> <Leader>a <Esc>myggVG$
nnoremap <silent> <Leader>vr :new ~/.vimrc<CR>
nnoremap <silent> <Leader>r :source ~/.vimrc<CR>
noremap <silent> <Leader><Leader> <C-w>w
map <silent> <leader>n :call RenameFile()<CR>
map <silent> <leader>? :Cheat<CR>

function! RenameCurrentFile()
  let old = expand('%')
  let new = input('新規ファイル名: ', old , 'file')
  if new != '' && new != old
    exec ':saveas ' . new
    exec ':silent !rm ' . old
    redraw!
  endif
endfunction

"vim-fugitive
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gc :Gcommit<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>gb :Gblame<CR>



"jp -> en in normal mode
nnoremap あ a
nnoremap い i
nnoremap う u
nnoremap お o
nnoremap ｄｄ dd
nnoremap ｙｙ yy

set colorcolumn=80
highlight ColorColumn guibg=#202020 ctermbg=lightgray
set autoindent
set ambiwidth=double
set background=dark
set expandtab
set history=5000
set hlsearch
set ignorecase
set incsearch
set noswapfile
set number
set smartcase
set statusline=%F%r%h%=d
set belloff=all
set whichwrap=b,s,h,l,<,>,[,],~
set wildmenu wildmode=list:full

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz


nnoremap j gj
nnoremap k gk

" complementation
inoremap [ []<left>
inoremap ( ()<left>
inoremap { {}<left>
inoremap " ""<left>
inoremap ' ''<left>

" move window
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


colorscheme default
"colorscheme pyceberg
syntax enable

" ハイライトグループを知るコマンド:SyntaxInfoを実装
function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction
function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()

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
Plug 'airblade/vim-gitgutter'
Plug 'bronson/vim-trailing-whitespace'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-peekaboo'
Plug 'Shougo/neosnippet.vim'
Plug 'reireias/vim-cheatsheet'
Plug 'scrooloose/syntastic'
Plug 'simeji/winresizer'
Plug 'thinca/vim-quickrun'
Plug 'Townk/vim-autoclose'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'
call plug#end()

let g:cheatsheet#cheat_file = '~/.cheatsheet.md'
let g:indentLine_setColors = 0
let g:syntastic_enable_signs = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_python_checkers = ['flake8']
