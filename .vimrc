if !1 | finish | endif

" F1で.vimrcの編集に
nnoremap <F1> :edit ~/.vimrc<CR>
" :ReloadVimrcで設定を反映
command! ReloadVimrc source ~/.vimrc

if has('vim_starting')
	set nocompatible
	set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'


"""" Plugins

NeoBundle 'Shougo/vimproc.vim', {
			\ 'build' : {
			\	'windows' : 'tools\\update-dll-mingw',
			\	'cygwin' : 'make -f make_cygwin.mak',
			\	'mac' : 'make -f make_mac.mak',
			\	'linux' : 'make',
			\	'unix' : 'gmake',
			\    },
			\ }

"" 必須系
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'scrooloose/syntastic.git'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'tpope/vim-surround'

"" 各言語

" sphinx
NeoBundleLazy 'Rykka/riv.vim',
            \ {"autoload": {"filetypes": ["rst"]}}

" jade
NeoBundleLazy 'digitaltoad/vim-jade',
            \ {"autoload": {"filetypes": ["jade"]}}

" python

NeoBundleLazy 'davidhalter/jedi-vim',
            \ {"autoload": {"filetypes": ["python"]}}
NeoBundleLazy 'nvie/vim-flake8',
            \ {"autoload": {"filetypes": ["python"]}}
NeoBundleLazy 'Yggdroot/indentLine',
            \ {"autoload": {"filetypes": ["python"]}}
NeoBundleLazy 'jmcantrell/vim-virtualenv',
            \ {"autoload": {"filetypes": ["python"]}}

"" color
NeoBundle 'w0ng/vim-hybrid'



call neobundle#end()

filetype plugin indent on

NeoBundleCheck


""" 各プラグインの設定

" unite

let g:unite_enable_split_vertically = 1
nnoremap ,uf :<C-u>Unite<space>file<CR>
nnoremap ,ub :<C-u>Unite<space>buffer<CR>
nnoremap ,um :<C-u>Unite<space>file_mru<CR>

" neocomplete

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


" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif


" quickrun

let g:quickrun_config = {
\   "_" : {
\       "outputter/buffer/split" : ":botright 8sp",
\       "outputter/buffer/close_on_empty": 1,
\       "runner" : "vimproc",
\       "runner/vimproc/updatetime" : 60
\   },
\   "ruby" : {
\       "command": "/Users/nao/.rbenv/shims/ruby"
\   },
\}


" neosnippet

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" jade
autocmd FileType jade setlocal ts=2 shiftwidth=2 softtabstop=2

" python系

autocmd FileType python setlocal omnifunc=jedi#completions
autocmd FileType python setlocal completeopt-=preview

let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0

if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif

let g:jedi#popup_select_first = 0
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^.\t]\.\w*'
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "1"
nnoremap <Leader>l :call Flake8()<CR>
"" indentLine
let g:indentLine_color_term = 238
let g:indentLine_color_gui = '#708090'
let g:indentLine_char = '¦'

let g:syntastic_python_checkers=['flake8']

" ruby系
let g:syntastic_ruby_checkers = ['rubocop']


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 全般
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noswapfile
set nobackup
set clipboard=unnamed,unnamedplus

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 表示関連
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !has('gui_running')
    set t_Co=256
endif
colorscheme hybrid
set number
set scrolloff=5
set wrap
set showbreak=+
set cursorline
set cursorcolumn
set ruler
set tabstop=8
set softtabstop=4
set expandtab
set smarttab
set laststatus=2
set foldlevel=100
syntax on


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 検索置換
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set incsearch
set ignorecase
set smartcase
set nohlsearch
set gdefault
if !exists('loaded_matchit')
  " matchitを有効化
  runtime macros/matchit.vim
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 入力関係
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backspace=indent,eol,start
set autoindent
set shiftwidth=4
set showmatch
set whichwrap=b,s,h,l,<,>,[,]
set smarttab
autocmd FileType ruby set ts=2 sw=2 softtabstop=2
autocmd FileType eruby set ts=2 sw=2 softtabstop=2
