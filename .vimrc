nmap <C-left> <Esc>:tabp<CR>
nmap <C-right> <Esc>:tabn<CR>

" Tabs and indentation
set tabstop=4
set softtabstop=4
"set noexpandtab
set expandtab "Tabs as spaces
set shiftwidth=4
set backspace=2
set textwidth=78
set smartindent
set autoindent
nmap <Tab> <Esc>:cn<CR>
nmap <S-Tab> <Esc>:cp<CR>
nmap <S-H> <Esc>:tabp<CR>
nmap <S-L> <Esc>:tabn<CR>

" Syntax and highlighting
set bg=dark
colorscheme slate
set hlsearch
set nu
syntax on

" Highlight spaces at EOL and mixed tabs and spaces.
hi BogusWhitespace ctermbg=darkgreen guibg=darkgreen
match BogusWhitespace /\s\+$\|^\t\+ \+\|^ \+\t\+/

" Statusline and 256 colors
set laststatus=2
set t_Co=256

" Convenience Keymapping & C/C++ ctags
imap <C-F> <Esc>
map <F5> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
au BufWritePost *.c,*.cpp,*.h silent! !ctags -R &

" Echo the filename
nmap <F2> <Esc>:echo @%<CR>

" No trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

"______________________________
" Plugins
"______________________________

"::-----------------------
":: NERDTree
"::-----------------------
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"::-----------------------
":: Eclim
"::-----------------------
filetype plugin indent on


"::-----------------------
":: Pathogen
"::-----------------------
runtime bundle/vim-pathogen/autoload/pathogen.vim

filetype off
call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on


"::-----------------------
":: TagList
"::-----------------------

nmap <F4> <Esc>:TlistToggle<Esc>

"::-----------------------
":: Clang Complete
"::-----------------------
let g:clang_library_path= "/usr/lib/llvm-3.4/lib/libclang.so.1"

let g:clang_snippets = 1
let g:clang_snippets_engine = 'clang_complete'


"::-----------------------
":: YouCompleteMe
"::-----------------------
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'


"::-----------------------
":: NeoComplete
"::-----------------------
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
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
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


"::-----------------------
":: NeoSnippet
"::-----------------------
let g:neosnippet#disable_runtime_snippets = { "_": 1, }
let g:neosnippet#snippets_directory='~/.vim/snippets/neosnippet-snippets/neosnippets'

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

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


"::-----------------------
":: Powerline Status Bar
"::-----------------------
"---- LINUX -------
"set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
"---- MAC OSX -----
set rtp+=$HOME/Library/Python/2.7/lib/python/site-packages/powerline/bindings/vim/plugin/powerline.vim

" Always show statusline
set laststatus=2
"
" " Use 256 colours (Use this setting only if your terminal supports 256
" colours)
set t_Co=256

" These lines setup the environment to show graphics and colors correctly.
 set nocompatible

 let g:minBufExplForceSyntaxEnable = 1
 python from powerline.vim import setup as powerline_setup
 python powerline_setup()
 python del powerline_setup

  if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
    augroup END
  endif

  set laststatus=2 " Always display the statusline in all windows
  set guifont=Inconsolata\ for\ Powerline:h14
  set noshowmode " Hide the default mode text


"::-----------------------
":: Python mode
"::-----------------------
"let g:pymode = 1
let mapleader="," " For quickly running the code


"::-----------------------
":: Syntastic
"::-----------------------
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_html_tidy_blocklevel_tags = ['ui-view']

"::-----------------------
":: JavaScript Libraries Syntax
"::-----------------------
let g:used_javascript_libs = 'underscore,jquery,angularjs,angularuirouter'


"::-----------------------
":: Angular Vim
"::-----------------------
let g:angular_source_directory = 'app/src'
let g:angular_test_directory = 'test/units'
