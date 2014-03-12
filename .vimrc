" F1で.vimrcの編集に
nnoremap <F1> :edit ~/.vimrc<CR>
" :ReloadVimrcで設定を反映
command! ReloadVimrc source ~/.vimrc

if has('vim_starting')
	set nocompatible
	set runtimepath+=~/.vim/bundle/neobundle.vim
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" プラグイン
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', { 'build' : {
            \                'mac' : 'make -f make_mac.mak'},}
NeoBundle 'Shougo/unite.vim'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle has('lua') ? 'Shougo/neocomplete.vim' : 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'derekwyatt/vim-scala.git'
NeoBundle 'thinca/vim-quickrun'

NeoBundleLazy 'ujihisa/unite-colorscheme'

filetype plugin indent on
NeoBundleCheck


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Unite
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:unite_enable_split_vertically = 1
nnoremap ,uf :<C-u>Unite<space>file<CR>
nnoremap ,ub :<C-u>Unite<space>buffer<CR>
nnoremap ,ur :<C-u>Unite<space>file_mru<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neocomplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ }
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 全般
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noswapfile
set clipboard=unnamed,unnamedplus

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 表示関連
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256
colorscheme jellybeans
set number
set scrolloff=5
set wrap
set showbreak=+++
set nolist
set cursorline
set cursorcolumn
set ruler
set tabstop=4
syntax on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 検索置換
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase
set smartcase
set nohlsearch
set gdefault

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 入力関係
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backspace=indent,eol,start
set autoindent
set shiftwidth=4
set showmatch
set whichwrap=b,s,h,l,<,>,[,]
set expandtab
set smarttab
autocmd FileType scala set ts=2 sw=2 softtabstop=2

