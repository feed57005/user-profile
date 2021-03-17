"           _
"    __   _(_)_ __ ___  _ __ ___
"    \ \ / / | '_ ` _ \| '__/ __|
"     \ V /| | | | | | | | | (__
"    (_)_/ |_|_| |_| |_|_|  \___|
"

set t_Co=256 " set 256 terminal colors

" Directories {{{

"set nowb
"set noswapfile

if has('win32')
  set backupdir=$HOME\vimfiles\bak
  set directory=$HOME\vimfiles\tmp
  set runtimepath+=$HOME\vimfiles
  set runtimepath+=$HOME\vimfiles\snippets
else
  set backupdir=$HOME/.vim/bak
  set directory=$HOME/.vim/tmp
  set runtimepath+=$HOME/.vim
  set runtimepath+=$HOME/.vim/snippets
endif
" }}}
" Search {{{
" set highlighted incremental searching with smart case ignoring
set hlsearch
set incsearch
set ignorecase
set smartcase
" }}}
" Tabs & Formatting {{{
set expandtab
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set formatoptions=tcqron2       " 'tc' wrap text and comments using textwidth
                                " 'q' allow formating of comments with gq
                                " 'ro' auto comment leader after <CR> or 'o'
                                " 'n' recognize numbered lists
                                " '2' use second line of paragraph for indent
                                " see :h fo-table
" }}}
" Misc {{{
set nowrap
set nocompatible                "
set nobackup                    " dont make backups before save
set exrc                        " enable per-directory .vimrc (BEWARE)
set history=700                 " how many lines of history VIM has to remember

set backspace=indent,eol,start  " standard backspace behaviour
set foldmethod=marker           " use markers for folding
set scrolloff=7                 " Minimal number of columns to scroll verticaly
set sidescroll=7                " and horizontally
set nolazyredraw                " redraw even when executing not typed commands
set fileformats=unix,dos        " EOL types autodetection
set ttyfast                     " fast terminal connection
set mouse=a                     " enable mouse in all modes
set ttymouse=sgr
set confirm                     " ask what to do when leaving modified buffer
set exrc                        " enable reading .vimrc from current dir
set secure                      " disable dangerous cmds in current dir .vimrc

"set textwidth=80
" }}}
" UI {{{
syntax on
syntax sync maxlines=500
set wildmode=longest,list
set wildignorecase
set wildmenu                    " command-line <Tab> completion above command line
set ruler                       " show where the cursor is
set showmatch                   " show matching bracets when text indicator is over them
set mat=2                       " how many tenths of a second to blink
set switchbuf=usetab            " also considers buffers in other tabs
set foldcolumn=2                " width of fold column
set showtabline=1               " show tabline only when there more than one tab page
set number                      " line numbering
set numberwidth=4               " width of number column
set linebreak                   " line break
" Look and Feel {{{
colorscheme myelflord           " modified elflord from 7.3
set showbreak==>
set cmdheight=1                 " commandline - 2 lines height
set laststatus=2                " show statusline - always

if has("gui_running")
  set vb t_vb=                  " hitting <ESC> in Normal Mode gives me headache
  set guitablabel=%t
  set showtabline=2             " always
  set guioptions=aci            " 'egmrLtT' is default
  set guifont=Terminus:h12:cEASTEUROPE
  if not has("gui_macvim")
    au GUIEnter * simalt ~x     " start maximized window (TODO)
  else
    set guifont=Droid Sans Mono:h14
  endif
endif
" }}}
" Status line {{{

" Git branch (not used)
function! GitBranch()
    let branch = system("git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* //'")
    if branch != ''
        return '   Git Branch: ' . substitute(branch, '\n', '', 'g')
    en
    return ''
endfunction

set statusline=%n:%*\ %<%f\ %y%m%1*%r%*%=[%b,0x%B]\ \ %l/%L,%c%V\ \ %P
highlight StatusLine cterm=bold,underline ctermfg=7 ctermbg=5
highlight StatusLineNC cterm=underline ctermfg=7 ctermbg=0
" }}}
" }}}
" Keys {{{

" With a map leader it's possible to do extra key combinations
let mapleader = ","
let g:mapleader = ","

" <F1> is Escape
map <F1> <Esc>
imap <F1> <Esc>

" <F4> Quickfix List
" TODO Toggle
map <F4> :botright cope<CR>
imap <F4> :botright cope<CR>

" <F12> Toogle pasting
set pastetoggle=<F12>

" ,r Substitute
map <leader>r :%s/<C-R><C-w>/

" ,R Grep
if executable('ag')
  map <leader>R :Ag <C-R><C-w>
else
  map <leader>R :grep -R <C-R><C-w>
endif

" ,w Fast save
nmap <leader>w :w!<cr>

" buffer wipeout
nmap <C-x> :bw<CR>

" Quickfix
map <F4> :botright cope<CR>
imap <F4> :botright cope<CR>
map <leader>n :cn<cr>
map <leader>p :cp<cr>

" no highlight
nmap <leader>l :noh<cr>

" ,m ,M syntax/marker foldmethod
nmap <leader>m :set foldmethod=syntax<cr>
nmap <leader>M :set foldmethod=marker<cr>

" shell like keys in command mode
cnoremap <C-A> <Home>

" }}}

" Plugins

" Enable filetype
filetype indent on
filetype plugin on

" XML folding {{{
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax
" }}}

" netrw {{{
let g:netrw_sort_sequence = '[\/]$' " sort directories first
" }}}

" fswitch {{{
au! BufEnter *.cpp,*.cxx,*.cc,*.c,*.mm let b:fswitchdst = 'h,hpp' | let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/**|,ifrel:|/src/|../include|'
au! BufEnter *.h,*.hpp let b:fswitchdst = 'cpp,cc,c,mm' | let b:fswitchlocs = 'reg:/include/src/,reg:/include.*/src/,ifrel:|/include/|../src|'

nmap <silent> <Leader>of :FSHere<cr>
nmap <silent> <Leader>ol :FSRight<cr>
nmap <silent> <Leader>oL :FSSplitRight<cr>
nmap <silent> <Leader>oh :FSLeft<cr>
nmap <silent> <Leader>oH :FSSplitLeft<cr>
nmap <silent> <Leader>ok :FSAbove<cr>
nmap <silent> <Leader>oK :FSSplitAbove<cr>
nmap <silent> <Leader>oj :FSBelow<cr>
nmap <silent> <Leader>oJ :FSSplitBelow<cr>

" }}}

" CtrlP {{{
map <C-b> :CtrlPBuffer<CR>
map <C-o> :CtrlP<CR>
noremap <C-T> <C-O>
let g:ctrlp_working_path_mode=0
let g:ctrlp_switch_buffer='V'
let g:ctrlp_max_files=0
" }}}

" NERDTree {{{
let NERDTreeWinSize=30
let NERDTreeIgnore=['\.lo$','\.o$', '\.pyc$']
let NERDTreeShowBookmarks=1
map <leader>g :NERDTreeFind<CR>
map <F2> :NERDTreeToggle<CR>
imap <F2> :NERDTreeToggle<CR>
" }}}

" xptemplate {{{
" see ftplugin/_common/personal.xpt.vim for custom vars
let g:xptemplate_brace_complete = 0
" }}}

" vimcommander {{{
noremap <silent> <F10> :cal VimCommanderToggle()<CR>
" }}}

" airline {{{
let g:airline_powerline_fonts=1
" }}}

" vim-jinja {{{
autocmd BufNewFile,BufRead *.tmpl set ft=jinja
" }}}

" vim-dispatch {{{
" <F5> save buffer & run make
imap <F5> <Esc>:Make<CR>
map <F5> :Make<CR>
" }}}

" pymode {{{
let g:pymode_rope = 0
" }}}

" vim-markdown {{{
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'C++=cpp']
" }}}

" Vista {{{
let g:vista_default_executive = 'ale'
let g:vista_sidebar_width = 50
map <F3> :Vista!!<CR>
imap <F3> :Vista!!<CR>
" }}}

" ALE {{{
let g:ale_c_ccls_executable='vim-ccls'
let g:ale_cpp_ccls_executable='vim-ccls'

let g:ale_c_parse_compile_commands=1
let g:ale_cpp_parse_compile_commands=1
let g:ale_c_build_dir_names=['build', '_build', 'out_linux/Release', 'out_linux/Debug']
let g:ale_completion_enabled=1
" -log-file=~/ccls.log -v=1
let g:ale_linters = {
\  'cpp': ['ccls'],
\  'c': ['ccls'],
\}
" Use ALE's function for omnicompletion.
set omnifunc=ale#completion#OmniFunc
let g:ale_completion_autoimport=1
":ALEFindReferences -vsplit
":ALEGoToDefinition

let g:ale_fixers = {
\  'cpp': ['clang-format', 'remove_trailing_lines', 'trim_whitespace']
\}

map <C-K> :ALEFix<CR>
imap <C-K> <ESC>:ALEFix<CR>i

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" : "\<TAB>"
" }}}

autocmd! BufNewFile,BufRead *.gn,*.gni set filetype=gn

" nvim python support
if has('nvim')
  let g:python_host_prog='/usr/bin/python'
endif

" vundle

filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#rc()

Bundle 'gmarik/Vundle.vim'

Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-surround'
Bundle 'derekwyatt/vim-fswitch'
Bundle 'kien/ctrlp.vim'
Bundle 'drmingdrmer/xptemplate'
Bundle 'vim-scripts/vimcommander'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'bling/vim-airline'
Bundle 'prabirshrestha/asyncomplete.vim'
Bundle 'dense-analysis/ale'
Bundle 'liuchengxu/vista.vim'
Bundle 'feed57005/vim-tabmapping'

if has('nvim')
  Bundle 'Numkil/ag.nvim'
else
  Bundle 'rking/ag.vim'
endif

" Git
Bundle 'tpope/vim-fugitive'
Bundle 'gregsexton/gitv'
Bundle 'airblade/vim-gitgutter'

" File Type Support
Bundle 'tikhomirov/vim-glsl'
Bundle 'klen/python-mode'
Bundle 'sukima/xmledit'
Bundle 'tpope/vim-liquid'
Bundle 'tpope/vim-markdown'
Bundle 'vim-scripts/AnsiEsc.vim'
Bundle 'udalov/kotlin-vim'

"Bundle 'lepture/vim-jinja'
"Bundle 'mustache/vim-mustache-handlebars'
"Bundle 'cstrahan/vim-capnp' " Cap'n Proto support
"Bundle 'feed57005/gn.vim'
"Bundle 'pangloss/vim-javascript'

filetype plugin indent on
