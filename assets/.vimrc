"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Basic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if &compatible
	set nocompatible
endif

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Make vim cwd the file that is being edited
autocmd BufEnter * silent! lcd %:p:h
" Add rust filetyp
augroup filetype_rust
    autocmd!
    autocmd BufReadPost *.rs setlocal filetype=rust
augroup END

" Line numbering
set number
set relativenumber

" Enable filetype plugins
filetype plugin indent on

let mapleader = " "

function! s:get_vimrc_path()
	if has('nvim')
		return $HOME . '/.config/nvim/init.vim'
	else 
		return $HOME . '/.vimrc'
	endif
endfunction

nnoremap <expr> <leader>1 ":edit ".<SID>get_vimrc_path()."<CR>"
nnoremap <expr> <leader>2 ":source ".<SID>get_vimrc_path()."<CR>"
nnoremap <silent> <leader>3 :PlugInstall<CR>
nnoremap <silent> <leader>4 :PlugUpgrade<CR>:PlugUpdate<CR>:CocUpdate<CR>
" Map redo to Ctrl+u
nnoremap U <C-r>

" Sudo saves the file (useful for handling the permission-denied error)
command! SudoSave execute 'w !sudo tee % > /dev/null' <bar> edit!

""" Misc
" Return to the last editing point when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" Mouse support
set mouse=i

" Automatically causes vim to reload files which have been written on disk but not modified in the buffer since the last write from vim
set autoread
" Trigger autoread when changing buffers inside while inside vim
autocmd FocusGained,BufEnter * :checktime

set modifiable


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
	set t_Co=256
endif

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

" Set language to english
let $LANG='en'
set langmenu=en

" Reset menus (becuase of the languase set above)
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

""" Search
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
" A shorter way to move between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
nnoremap <silent> <leader>wh :split<CR>
nnoremap <silent> <leader>wv :vertical split<CR>
nnoremap <silent> <leader>wq <C-W>q<CR>

""" Tabs
nnoremap <silent> <leader>] :tabn<CR>
nnoremap <silent> <leader>[ :tabp<CR>
nnoremap <silent> <leader>tl :tabs<CR>
" Duplicate current tab
nnoremap <silent> <leader>tn :tab split<CR>
nnoremap <silent> <leader>tq :tabclose<CR>
nnoremap <silent> <leader>tQ :tabonly<CR>

""" Buffers
" Switch CWD to the directory of the open buffer
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <silent> <leader>bf :bnext<CR>
nnoremap <silent> <leader>bb :bprevious<CR>
nnoremap <silent> <leader>bl :buffers<CR>
nnoremap <leader>bj :buffers<CR>:buffer<Space>

" Default split positions
set splitbelow
set splitright


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Terminals
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent> <C-t>h :terminal<CR>
nnoremap <silent> <C-t>v :vertical terminal<CR>
tnoremap <silent> <Esc> <C-\><C-n>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Tab sizing
set tabstop=4
set shiftwidth=4
set ai
set si
set wrap

" Remap VIM 0 to first non-blank character
nnoremap 0 ^

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	silent! %s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfun

autocmd BufWritePre *.txt,*.js,*.ts,*.sql,*.py,*.sh, :call CleanExtraSpaces()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Toggle spell checking
nmap <leader>ss :setlocal spell!<CR>
nmap <leader>sn ]s
nmap <leader>sp [s
nmap <leader>sa zg
nmap <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:get_coc_ext()
	let l:coc_ext = ['coc-prettier']

	if index(['json'], &filetype) != -1 
		let l:coc_ext += ['coc-json']
	elseif index(['ts', 'tsx', 'js', 'jsx'], &filetype) != -1
		let l:coc_ext += ['coc-tsserver', 'coc-jest', 'coc-eslint', 'coc-sql']
	elseif index(['html', 'css', 'scss', 'less'], &filetype) != -1
		let l:coc_ext += ['coc-html', 'coc-css']
	elseif index(['yml', 'yaml'], &filetype) != -1
		let l:coc_ext += ['coc-yaml']
	elseif index(['shell', 'sh'], &filetype) != -1
		let l:coc_ext += ['coc-sh']
	elseif index(['sql'], &filetype) != -1
		let l:coc_ext += ['coc-sql']
	elseif index(['rust'], &filetype) != -1
		let l:coc_ext += ['coc-rust-analyzer']
	endif

	return l:coc_ext
endfunction

function! s:get_plug_install_dir() abort
	if has("nvim")
			return $HOME."/.config/nvim/plugged"
	else
			return $HOME."/.vim/plugged"
	endif
endfunction

let g:coc_global_extensions = <SID>get_coc_ext()
 
call plug#begin(<SID>get_plug_install_dir())
Plug 'neoclide/coc.nvim', { 'branch': 'release', 'do': { -> coc#util#install() } }
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'PhilRunninger/nerdtree-visual-selection'
Plug 'PhilRunninger/nerdtree-buffer-ops'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'francoiscabrol/ranger.vim'
Plug 'townk/vim-autoclose'
Plug 'tpope/vim-surround'
Plug 'itspriddle/vim-shellcheck'
Plug 'mbbill/undotree'
Plug 'eliba2/vim-node-inspect'
Plug 'voldikss/vim-floaterm'
call plug#end()

""" Theme
colorscheme molokai

""" Coc
augroup commands_coc
	autocmd!
	autocmd CursorHold * silent call CocActionAsync('highlight')

	autocmd FileType typescript,javascript,css,html,sql,rust nmap <silent> g[ <Plug>(coc-diagnostic-prev)
	autocmd FileType typescript,javascript,css,html,sql,rust nmap <silent> g] <Plug>(coc-diagnostic-next)
	autocmd FileType typescript,javascript,css,html,sql,rust nmap <silent> gd <Plug>(coc-definition)
	autocmd FileType typescript,javascript,css,html,sql,rust nmap <silent> gt <Plug>(coc-type-definition)
	autocmd FileType typescript,javascript,css,html,sql,rust nmap <silent> gi <Plug>(coc-implementation)
	autocmd FileType typescript,javascript,css,html,sql,rust nmap <silent> gr <Plug>(coc-references)
	autocmd FileType typescript,javascript,css,html,sql,rust nmap <leader>ac <Plug>(coc-codeaction)
	autocmd FileType typescript,javascript,css,html,sql,rust nmap <leader>qf <Plug>(coc-fix-current)
	autocmd FileType typescript,javascript,css,html,sql,rust nmap <leader>rn <Plug>(coc-rename)
	autocmd FileType typescript,javascript,css,html,sql,rust xmap <leader>qr <Plug>(coc-format-selected)
	autocmd FileType typescript,javascript,css,html,sql,rust nmap <leader>qr <Plug>(coc-format-selected)
augroup END
" format current buffer.
command! -nargs=0 Format :call CocAction('format')
" fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)
" organize imports of the current buffer.
command! -nargs=0 OrgImp :call CocAction('runCommand', 'editor.action.organizeImport')

""" Node inspect
augroup commands_node_inspect
	autocmd!

	autocmd FileType typescript,javascript nnoremap <F2> :NodeInspectStart<CR>
	autocmd FileType typescript,javascript nnoremap <F3> :NodeInspectRun<CR>
	autocmd FileType typescript,javascript nnoremap <F4> :NodeInspectConnect("127.0.0.1:9229")<CR>
	autocmd FileType typescript,javascript nnoremap <F5> :NodeInspectStepInto<CR>
	autocmd FileType typescript,javascript nnoremap <F6> :NodeInspectStepOver<CR>
	autocmd FileType typescript,javascript nnoremap <F7> :NodeInspectToggleBreakpoint<CR>
	autocmd FileType typescript,javascript nnoremap <F8> :NodeInspectStop<CR>
function! s:show_documentation()
	if (index(['vim', 'help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

""" Jest
" Run jest for current project
command! -nargs=0 Jest :call CocAction('runCommand', 'jest.projectTest')<CR>
" Run jest for current file
command! -nargs=0 JestFile :call CocAction('runCommand', 'jest.fileTest', ['%'])<CR>
" Run jest for current test
command! -nargs=0 JestTest :call CocAction('runCommand', 'jest.singleTest')<CR>
" Init jest in current cwd, require global jest command exists
command! -nargs=0 JestInit :call CocAction('runCommand', 'jest.init')<CR>

""" Ranger
let g:ranger_map_keys = 0 " Disable default key mappings
nnoremap <silent> <leader>r :Ranger<CR>

""" Rust
if has("mac") || has("macunix")
	let g:rust_clip_command = 'pbcopy'
else
	let g:rust_clip_command = 'xclip -selection clipboard'
endif

""" NERDTree
let NERDTreeShowHidden=1
nnoremap <silent> <leader>tt :NERDTreeToggle<CR>
nnoremap <silent> <leader>tf :NERDTreeFocus<CR>
nnoremap <silent> <leader>ts :NERDTreeFind<CR>
nnoremap <silent> <leader>tr :NERDTreeRefreshRoot<CR>
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

""" NERDCommneter
let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1
nmap <leader>/ <plug>NERDCommenterToggle<CR>

""" Undotree
nnoremap <silent> <leader>u :UndotreeToggle<CR>
if has("persistent_undo")
	execute 'set undodir='.$HOME.'/.undodir'
	set undofile
endif

""" FZF
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <leader>f :Rg<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
\}

""" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

""" Floaterm
nnoremap   <silent>   <F9>     :FloatermPrev<CR>
tnoremap   <silent>   <F9>     <C-\><C-n>:FloatermPrev<CR>
nnoremap   <silent>   <F10>    :FloatermNext<CR>
tnoremap   <silent>   <F10>    <C-\><C-n>:FloatermNext<CR>
nnoremap   <silent>   <F11>    :FloatermNew<CR>
tnoremap   <silent>   <F11>    <C-\><C-n>:FloatermNew<CR>
nnoremap   <silent>   <F12>   :FloatermToggle<CR>
tnoremap   <silent>   <F12>   <C-\><C-n>:FloatermToggle<CR>
let g:floaterm_autoclose = 1
