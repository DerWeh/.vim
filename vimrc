" VIM Configuration File

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" disable vi compatibility (emulation of old bugs)
set nocompatible

" enable pathogen for plug-in management
call pathogen#infect()
call pathogen#helptags()

" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" Each new line will be automatically indented the correct amount according to
" the C indentation standard.
set cindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set softtabstop=4
" set noexpandtab        " expand tabs to spaces
set expandtab
" wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
"" set textwidth=120

" turn syntax highlighting on
set t_Co=256
syntax on
" colorscheme wombat256
" Show whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
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
" Remove highlight from searchresults
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
  ” diff settings
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

" ariline configuration
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#vcs_priority = ["git"]
set laststatus=2
" let g:airline_theme='lucius'
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

" configure SuperTab
let g:SuperTabLongestEnhanced = 1
if &omnifunc != ''
  call SuperTabChain(&omnifunc, "<c-p>")
endif

" mine
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
set completeopt=menu,preview,longest

