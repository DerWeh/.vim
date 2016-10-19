" VIM Configuration File

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
set nocompatible

" set up pathogen
runtime bundle/pathogen/autoload/pathogen.vim
if !exists('g:pathogen_disabled')
  let g:pathogen_disabled = []
endif

" neocomplete requires Vim 7.3 and Lua
if v:version < 703 || !has('lua') || (v:version == 703 && !has('patch885'))
  call add(g:pathogen_disabled, 'neocomplete')
"else
"  call add(g:pathogen_disabled, 'supertab')
endif

" enable pathogen for plug-in management
call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" Each new line will be automatically indented the correct amount according to
" the C indentation standard.
set cindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=2        " tab width is 4 spaces
set shiftwidth=2     " indent also with 4 spaces
set softtabstop=2
" set noexpandtab
set expandtab
" wrap lines at 120 chars. 80 is somewhat antiquated with nowadays displays.
"" set textwidth=120
set foldmethod=marker

" turn syntax highlighting on
set t_Co=256
syntax on
set background=light
colorscheme PaperColor
" Show whitespace
highlight ExtraWhitespace ctermbg=Magenta guibg=#ffafd7
au InsertLeave * match ExtraWhitespace /\s\+$/

"" turn line numbers on
"set number
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */
if has("vms")
  set nobackup      " do not keep a backup file, use versions instead
else
  set backup        " keep a backup file
endif
" display incomplete commands
set showcmd
" The Vim editor will start searching when you type the first character of the
" search string.
set incsearch
" Any search highlights the string matched by the search.
set hlsearch
set ignorecase
set smartcase

"sometimes increases performance
set lazyredraw " can lead to problems with splits?
set ttyfast


"" store swapfiles in a central location
"set directory=~/.vim/tmp/swap//,.,/var/tmp//,/tmp//
"if !isdirectory(expand("~") . '/.vim' . '/tmp/swap')
"  call mkdir(expand("~") . '/.vim' . '/tmp/swap', 'p')
"endif

"" Install OmniCppComplete like described on http://vim.wikia.com/wiki/C++_code_completion
"" This offers intelligent C++ completion when typing ‘.’ ‘->’ or <C-o>
"" Load standard tag files
"set tags+=~/.vim/tags/cpp
"set tags+=~/.vim/tags/gl
"set tags+=~/.vim/tags/sdl
"set tags+=~/.vim/tags/qt4
"" Install DoxygenToolkit from http://www.vim.org/scripts/script.php?script_id=987
"let g:DoxygenToolkit_authorName="John Doe <john@doe.com>"

" in normal mode F2 will save the file
nmap <F2> :w<CR>
" in insert mode F2 will exit insert, save, enters insert again
imap <F2> <ESC>:w<CR><Space>i
" toggle paste mode for pasting code without intend
set pastetoggle=<F3>
" switch between header/source with F4
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
" Toggle tagbar
map <F8> <Esc>:TagbarToggle<CR>
" Change sorting order to order of appearance in file
let g:tagbar_sort = 0
" Remove highlight from search results
map <C-n> :nohl<CR>

" Move between windows with Ctrl+[h,j,k,l]
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Move between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" Intending codeblocks
vmap < <gv
nmap < <gv
vmap > >gv
nmap > >gv

"" create doxygen comment
"map <F6> :Dox<CR>

" goto definition with F12
map <F12> <C-]>
" in diff mode we use the spell check keys for merging
if &diff
  " diff settings
  map <M-Down> ]c
  map <M-Up> [c
  map <M-Left> do
  map <M-Right> dp
  map <F9> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg
else
  " spell settings
  :setlocal spell spelllang=en
  " set the spellfile - folders must exist
  set spellfile=~/.vim/spellfile.add
  map <M-Down> ]s
  map <M-Up> [s
endif

" go to last cursor position upon opening files
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
            \ | wincmd p | diffthis
endif

" airline configuration {{{
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#vcs_priority = ["git"]
set laststatus=2
"let g:airline_theme='papercolor'
"let g:lightline = { 'colorscheme': 'PaperColor' }
let g:airline_powerline_fonts = 1
let g:airline_detect_spell=0

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
let g:airline_symbols.paste = 'PASTE'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.spell = ''
"}}}

" easy motion {{{
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1

" Move to line
map  <Leader><Leader>f <Plug>(easymotion-bd-f)
nmap <Leader><Leader>f <Plug>(easymotion-overwin-f)

map  <Leader><Leader>w <Plug>(easymotion-bd-w)
nmap <Leader><Leader>w <Plug>(easymotion-overwin-w)

map  <Leader>/ <Plug>(easymotion-sn)
omap <Leader>/ <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to
" EasyMotion.
" " Without these mappings, `n` & `N` works fine. (These mappings just provide
" " different highlight method and have some other features )
map  <Leader>n <Plug>(easymotion-next)
map  <Leader>N <Plug>(easymotion-prev)
" }}}

" indent guides setting {{{
let g:indent_guides_color_change_percent = 15
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'tagbar']
let g:indent_guides_default_mapping = 1
let g:indent_guides_start_level = 1
"}}}

" pydocstring {{{
nmap <silent> <Leader>pd <Plug>(pydocstring)
"}}}

" mine
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
set completeopt=menu,preview,longest

" supertab {{{
" only use supertab if neocomplete is not working
if index(g:pathogen_disabled, 'neocomplete') != -1
  let g:SuperTabLongestEnhanced = 1
  let g:SuperTabDefaultCompletionType = 'context'
  autocmd FileType *
    \ if &omnifunc != '' |
    \   call SuperTabChain(&omnifunc, "<c-p>") |
    \ endif
else
  " disable supertab default mapping
  let g:SuperTabMappingForward = '<Nop>'
  let g:SuperTabMappingBackward = '<Nop>'
endif
"}}}

" neocomplete {{{
if index(g:pathogen_disabled, 'neocomplete') == -1
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1

  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#enable_camel_case = 1
  let g:neocomplete#auto_completion_start_length = 2

  " increase limit for tag cache files
  let g:neocomplete#sources#tags#cache_limit_size = 16777216 " 16MB
  " default: 100, more to get more methods (e.g. np.<TAB>)
  let g:neocomplete#max_list = 500

  " disable for Python
  "call neocomplete#util#set_default_dictionary(
  "       \'g:neocomplete#sources#omni#input_patterns',
  "       \'python',
  "       \'')
  "
  "" <TAB>: completion.
  "inoremap <expr> <Tab> pumvisible() ? '\<C-n>' : '\<Tab>'
  " For smart TAB completion.
  "inoremap <expr><TAB>  pumvisible() ? '\<C-n>' :
  "        \ <SID>check_back_space() ? '\<TAB>' :
  "        \ neocomplete#start_manual_complete()
  "  function! s:check_back_space() "{{{
  "    let col = col('.') - 1
  "    return !col || getline('.')[col - 1]  =~ '\s'
  "  endfunction"}}}

  inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' :
          \ <SID>check_back_space() ? '<S-TAB>' :
          \ neocomplete#start_manual_complete()

    function! s:check_back_space() "{{{
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
    endfunction"}}}
  let g:neocomplete#enable_auto_delimiter = 1
  " let g:neocomplete#enable_auto_select = 1
  " Search from neocomplete, omni candidates, vim keywords.
  let g:neocomplete#fallback_mappings =
    \ ["\<C-x>\<C-o>", "\<C-x>\<C-n>"]
  let g:neocomplete#use_vimproc = 1

  " enable neosnippet
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

  imap <expr><TAB>
   \ pumvisible() ? '<C-n>' :
   \ neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" :
   \ ! <SID>check_back_space() ? neocomplete#start_manual_complete() :
   \ "\<TAB>"

  imap <c-k> <Plug>(neosnippet_expand_or_jump)
  smap <c-k> <Plug>(neosnippet_expand_or_jump)
  xmap <c-k> <Plug>(neosnippet_expand_target)

  " let g:neosnippet#enable_completed_snippet=1
  " For conceal markers.
  if has('conceal')
    set conceallevel=2 concealcursor=niv
  endif
endif
"}}}

" colorize {{{
let g:colorizer_startup = 0
"let g:colorizer_maxlines = 800
"}}}
