set nocompatible			 " must be the first line

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


" *** General Settings ***
set history=500				 " command line history
set encoding=utf-8 fileencodings=
set foldmethod=marker

" *** Search ***
set incsearch				 " do incremental searching
set hlsearch				 " lighlight search items
set ignorecase				 " case insensitive search
set smartcase				 " ignore case when only lowercase


" *** Indentation ***
set shiftwidth=4			 " number of spaces to use for each step of (auto)indent
set tabstop=4				 " number of spaces a tab counts for
set smartindent


" *** Directories ***
set backup
set backupdir=$HOME/.temp//  " for backup files
set directory=$HOME/.temp//  " for swap files
silent execute '!mkdir -p $HOME/.temp'


" *** UI ***
if has('cmdline_info')
	set ruler				 " always show the cursor position
	set showcmd				 " display incomplete commands
endif

if has('statusline')
	set laststatus=2
	"set statusline=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exi
	"  sts(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
	"set statusline=%=%m(%{\&ff})%y\ %l/%L(%p%%)
	set statusline=%=%m%l/%L-%p%%
	au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
	au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
endif

if has('mouse')
	set mouse=a				 " set mouse for all modes
endif

if has("gui_running")
	syntax on
	set guioptions=gmr
	set guifont=Monaco\ 10
	colorscheme molokai
else
	set t_Co=256
	colorscheme molokai
endif

set fillchars=""			 " no window seperator character
set nocursorline			 " highlight current line
set nocursorcolumn			 " don't highlight current column
set number					 " show line numbers
set listchars=tab:▸\ ,eol:¬


" *** Keys ***
let mapleader = ","
nnoremap <silent> <Leader>v :edit $MYVIMRC<CR>
nnoremap <silent> <Leader>t :set noet\|retab!<CR>
nnoremap <silent> <Leader>l :set list!<CR>
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>
nnoremap <silent> <Leader>p :call PythonMode()<CR>
nnoremap <silent> <Leader>s :call ToggleSyntax()<CR>
nnoremap <silent> <Leader>z :let &scrolloff=999-&scrolloff<CR>
nnoremap <silent> <Leader>h :nohlsearch<cr>
nnoremap <silent> <leader>b :!scons<cr>
nmap <silent> <F2> :NERDTreeToggle<CR>
nmap <silent> <F3> :TagbarToggle<CR>

map <a-Left> :bp<CR>
map <a-Right> :bn<CR>
map <a-x> :Bclose<CR>
nnoremap - :1b<cr>
nnoremap ğ :2b<cr>
nnoremap ü :3b<cr>
nnoremap ö :4b<cr>
nnoremap ç :5b<cr>

imap <F11> <ESC>"+y<CR>
imap <F12> <ESC>"+gP<CR>
inoremap <c-space> <C-x><C-o>
" save anyway when you forget to sudo
cmap w!! w !sudo tee % >/dev/null


" *** Key Fixes ***
set backspace=indent,eol,start
" CTRL-U in insert mode deletes a lot.	Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

cmap W w
cmap Q q
cmap WQ wq
cmap Wq wq

"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>
"imap <up> <nop>
"imap <down> <nop>
"imap <left> <nop>
"imap <right> <nop>


" *** Misc Fixes ***
set hidden					 " fix 'must save first' when changing buffers
set lazyredraw				 " don't update the screen while playing macros
set mousehide				 " hide pointer while typing
set clipboard+=unnamed		 " supposed to use the system clipboard
set swapsync=


" *** AutoComplete ***
set completeopt=longest,menuone
set wildmenu
"set wildmode=list:longest
if has('unix')
	set dictionary+=/usr/share/dict/words
endif


" *** Filetype settings ***
if has('autocmd')
	filetype plugin indent on
	autocmd BufNewFile,BufRead *.txt setlocal filetype=text
	autocmd FileType text setlocal textwidth=78 complete+=k infercase
	autocmd FileType html setlocal shiftwidth=4 tabstop=4
	autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
	autocmd BufRead *.py nmap <buffer> <F5> :!python %<CR>
	autocmd BufRead *.c,*.h  nmap <buffer> <F5> :!scons<CR>
	autocmd BufWritePost *.coffee silent CoffeeMake! -b
	"au BufRead,BufNewFile *.b set filetype=betik

	" autocmd! Syntax betik source $VIM/betik.vim

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	" (happens when dropping a file on gvim).
	" Also don't do it when the mark is in the first line, that is the default
	" position when opening a file.
	autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
	autocmd! BufWritePost .vimrc source $MYVIMRC

	" set autoread
endif


" *** Plug-ins ***
let g:pydiction_location = '~/.vim/after/ftplugin/pydiction/complete-dict'
let g:user_zen_expandabbr_key = '<c-d>'
let g:use_zen_complete_tag = 1
let g:buftabs_only_basename=1
let g:buftabs_in_statusline=0
let g:buftabs_active_highlight_group="Visual"
let g:netrw_ftp_cmd="ftp -p"
let g:netrw_localmovecmd = 'move'
let NERDTreeIgnore=['\.psd', '__MACOSX', '\.o']
let g:snips_author = 'Cenan Özen'


" *** Functions ***
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
endif

command! CD cd %:p:h
command! LCD lcd %:p:h

function! ToggleSyntax()
	if exists("g:syntax_on")
		syntax off
	else
		syntax enable
	endif
endfunction

function! PythonMode()
	set guifont=Inconsolata\ Medium\ 12
	colorscheme django
endfunction

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d :",
		\ &tabstop, &shiftwidth, &textwidth)
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction

