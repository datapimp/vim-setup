set nocompatible

set number
set ruler
set autoindent
set nobackup
set noswapfile
set guifont=Monaco:h20
set statusline=%t%(\ [%n%M]%)%(\ %H%R%W%)\ %(%c-%v,\ %l\ of\ %L%)

call pathogen#runtime_append_all_bundles()

syntax on
filetype plugin indent on

let otl_map_tabs = 1
let mapleader=','
let ruby_fold = 1
let ruby_no_comment_fold = 1

noremap ; :
inoremap <S-CR> <Esc>

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" might be a bad idea
set autoread

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc

" Status bar
set laststatus=2

" NERDTree configuration
let NERDTreeIgnore=['\.rbc$', '\~$']
map <Leader>sd :NERDTreeToggle<CR>

" Command-T configuration
let g:CommandTMaxHeight=20

" ZoomWin configuration
map <Leader>z :ZoomWin<CR>

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function s:setupWrapping()
  set wrap
  set wm=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Mm <CR>
endfunction

" make and python use real tabs
au FileType make                                     set noexpandtab
au FileType python                                   set noexpandtab

" Thorfile, Rakefile and Gemfile are Ruby
au BufRead,BufNewFile {Vagrantfile,Gemfile,Rakefile,Thorfile,config.ru}    set ft=ruby
au BufRead,BufNewFile *.haml.jst set ft=haml

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

au BufRead,BufNewFile *.txt call s:setupWrapping()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Use modeline overrides
set modeline
set modelines=10

" Default color scheme
colorscheme Spectacular
set guifont=Liberation\ Mono\ Regular:h20

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

noremap <Leader>vm :RVmodel <CR>
noremap <Leader>vc :RVcontroller <CR> 
noremap <Leader>vv :RVview <CR>
noremap <Leader>vu :RVunittest <CR>
noremap <Leader>vM :RVmigration <CR>

noremap <Leader>cc :!coffee --output ./lib --compile ./src/*.coffee <CR>

if has("folding")
 set foldenable
 set foldmethod=syntax
 set foldlevel=1
 set foldnestmax=2
 set foldtext=strpart(getline(v:foldstart),0,50).'\ ...\ '.substitute(getline(v:foldend),'^[\ #]*','','g').'\ '
endif

"let coffee_compile_on_save = 1
