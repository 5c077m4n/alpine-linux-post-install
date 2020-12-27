"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Basic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible

" Make vim cwd the file that is being edited
autocmd BufEnter * silent! lcd %:p:h

" Line numbering
set number
set relativenumber

" Enable filetype plugins
filetype plugin on
filetype indent on

let mapleader = " "
nnoremap <silent><leader>1 :e ~/.vimrc<CR>
nnoremap <leader>2 :source ~/.vimrc<CR>
nnoremap <silent><leader>3 :PlugInstall<CR>
" Map redo to Ctrl+u
nnoremap U <C-r>

" :W sudo saves the file (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

""" Misc
" Return to the last editing point when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

try
    colorscheme desert
catch
endtry

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
"source $VIMRUNTIME/delmenu.vim
"source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Add a bit extra margin to the left
set foldcolumn=1

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Windows, tabs & buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" Windows
" A simpler way to move between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
nnoremap <C-n> <C-W>n
nnoremap <C-q> <C-W>q

""" Tabs
" Opens a new tab with the current buffer's path
nnoremap <leader>te :tabedit <C-r>=expand("%:p:h")<CR>
" Switch CWD to the directory of the open buffer
nnoremap <leader>cd :cd %:p:h<cr>:pwd<CR>

nnoremap <C-]> :tabn<CR>
nnoremap <C-[> :tabp<CR>

nnoremap <leader>tl :tabs<CR>
nnoremap <leader>td :tab split<CR>
nnoremap <leader>tq :tabclose<CR>
nnoremap <leader>tQ :tabonly<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.ts,*.sql,*.py,*.sh, :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Toggle spell checking
map <leader>ss :setlocal spell!<cr>

map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! GetPlugInstallDir()
        if has("nvim")
                return "~/.config/nvim/plugged"
        else
                return "~/.vim/plugged"
        endif
endfunction
 
call plug#begin(GetPlugInstallDir())
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'elzr/vim-json', { 'for': ['json', 'javascript', 'typescript'] }
Plug 'othree/html5.vim', { 'for': ['javascript', 'typescript', 'html'] }
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'javascript', 'typescript', 'html'] }
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'francoiscabrol/ranger.vim'
Plug 'townk/vim-autoclose'
Plug 'tpope/vim-surround'
Plug 'itspriddle/vim-shellcheck'
Plug 'mbbill/undotree'
call plug#end()

let g:coc_global_extensions = ['coc-tsserver', 'coc-json']
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" GoTo code navigation.
augroup TSServer
    autocmd!
    autocmd FileType typescript,javascript nmap <silent> gd <Plug>(coc-definition)
    autocmd FileType typescript,javascript nmap <silent> gt <Plug>(coc-type-definition)
    autocmd FileType typescript,javascript nmap <silent> gi <Plug>(coc-implementation)
    autocmd FileType typescript,javascript nmap <silent> gr <Plug>(coc-references)
    " Remap keys for applying codeAction to the current buffer.
    autocmd FileType typescript,javascript nmap <leader>ac <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    autocmd FileType typescript,javascript nmap <leader>qf <Plug>(coc-fix-current)
augroup END

" Ranger config
let g:ranger_map_keys = 0 " Disable default key mappings
nnoremap <silent> <leader>r :Ranger<CR>

" Rust vim settings
let g:rust_clip_command = 'xclip -selection clipboard'

" NERDTree
nnoremap <C-t> :NERDTreeToggle<CR>
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Undotree config
nnoremap <leader>u :UndotreeToggle<CR>
if has("persistent_undo")
	set undodir=$HOME.GetPlugInstallDir()."/.undodir"
	set undofile
endif

" Vim racer shortcuts
let g:racer_cmd = $HOME."/.cargo/bin/racer"
let g:racer_insert_paren = 1
let g:racer_experimental_completer = 1
augroup Racer
    autocmd!
    autocmd FileType rust nmap <buffer> gd         <Plug>(rust-def)
    autocmd FileType rust nmap <buffer> gs         <Plug>(rust-def-split)
    autocmd FileType rust nmap <buffer> gx         <Plug>(rust-def-vertical)
    autocmd FileType rust nmap <buffer> gt         <Plug>(rust-def-tab)
    autocmd FileType rust nmap <buffer> <leader>gd <Plug>(rust-doc)
    autocmd FileType rust nmap <buffer> <leader>gD <Plug>(rust-doc-tab)
augroup END
set hidden

" FZF
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <leader>f :Rg<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
\}

" Syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
