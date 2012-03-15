set nocompatible			 " must be the first line

" *** Pathogen Settings *** {{{1
call pathogen#infect()
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" *** General Settings *** {{{1
set history=500				 " command line history
set encoding=utf-8 fileencodings=
set foldmethod=marker

" *** Search *** {{{2
set hlsearch				 " highlight search items
set ignorecase				 " case insensitive search
set incsearch				 " do incremental searching
set smartcase				 " ignore case when only lowercase


" *** Indentation *** {{{2
set shiftwidth=4			 " number of spaces to use for each step of (auto)indent
set tabstop=4				 " number of spaces a tab counts for
set smartindent


" *** Directories *** {{{2
if has("win32")
	set nobackup
	set noswapfile
else
	set backup
	set backupdir=$HOME/.temp//  " for backup files
	set directory=$HOME/.temp//  " for swap files
	if exists("*mkdir")
		if !isdirectory($HOME . "/.temp")
			call mkdir($HOME . "/.temp", "p")
		endif
	endif
endif


" *** UI *** {{{1
if has('cmdline_info')
	set ruler				 " always show the cursor position
	set showcmd				 " display incomplete commands
endif

if has('statusline')
	set laststatus=2
	"set statusline=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exi
	"  sts(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
	if has("win32")
		set statusline=%=%m%l/%L-%p%%
	else
		set statusline=%=%{SyntasticStatuslineFlag()}\ %m%3p%%\ %L\ %{fugitive#statusline()}%y\ %{\&ff}
	endif
	au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
	au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
endif

if has('mouse')
	set mouse=a				 " set mouse for all modes
endif

if has("gui_running")
	syntax on
	set guioptions=gmr
	if has("win32")
		set guifont=Monaco:h12:cTURKISH
		colorscheme molokai
	else
		set guifont=Consolas\ 13
		set background=dark
		colorscheme solarized
	end
else
	syntax on
	set t_Co=256
	let g:solarized_termcolors=256
	let g:solarized_termtrans=1
	if has("win32")
		colorscheme Borland
	else
		"set background=light
		if index(['tokyo','pegasus'], hostname()) >= 0
			colorscheme Tomorrow-Night-Bright
		else
			colorscheme Tomorrow-Night-Eighties
		endif
	end
endif

set fillchars=""			 " no window separator character
set cursorline				 " highlight current line
set nocursorcolumn			 " don't highlight current column
set number					 " show line numbers
set listchars=tab:▸\ ,eol:¬
set listchars+=trail:←
set listchars+=extends:»
set listchars+=precedes:«


" *** Keys *** {{{1
let mapleader = ","
" echo filename
nnoremap <silent> <Leader>f :echo @%<cr>
" turn off search highlighting
nnoremap <silent> <Leader>h :nohlsearch<cr>
" show tab and crlf characters
nnoremap <silent> <Leader>l :set list!<cr>
" append mode line to end of current file
nnoremap <silent> <Leader>ml :call AppendModeline()<cr>
" tabs to spaces
nnoremap <silent> <Leader>r :set noet\|retab!<cr>
" toggle syntax highlighting
nnoremap <silent> <Leader>s :call ToggleSyntax()<cr>
" edit .vimrc
nnoremap <silent> <Leader>v :edit $MYVIMRC<cr>
nnoremap <silent> <Leader>z :let &scrolloff=999-&scrolloff<cr>
" change colorscheme
nnoremap <silent> <leader>c1 :colorscheme Tomorrow<cr>
nnoremap <silent> <leader>c2 :colorscheme Tomorrow-Night<cr>
nnoremap <silent> <leader>c3 :colorscheme Tomorrow-Night-Blue<cr>
nnoremap <silent> <leader>c4 :colorscheme Tomorrow-Night-Bright<cr>
nnoremap <silent> <leader>c5 :colorscheme Tomorrow-Night-Eighties<cr>
nnoremap <silent> <leader>m0 :colorscheme molokai<cr>
nnoremap <silent> <leader>s1 :colorscheme solarized<cr>
nnoremap <silent> <leader>sc :!scons<cr>

" replace the selection in visual-mode
vnoremap <C-r> "hy:%s/<C-r>h//g<left><left>

set pastetoggle=<F8>

nmap <silent> <F2> :NERDTreeToggle<CR>
if !has("win32")
	nmap <silent> <F3> :TagbarToggle<CR>
endif
if has("win32")
	nmap <silent> <Space> :NERDTreeClose<cr>
else
	nmap <silent> <Space> :NERDTreeClose <bar> cclose <bar> TagbarClose<cr>
endif

map <C-J> :bp<CR>
nmap <S-Tab> :bp<CR>
map <C-K> :bn<CR>
nmap <Tab> :bn<CR>

inoremap <c-space> <C-x><C-o>
" save anyway when you forget to sudo
cmap w!! w !sudo tee % >/dev/null

vmap <C-S-Up> dkP`[V`]
vmap <C-S-Down> dp`[V`]

" *** Key Fixes *** {{{2
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


" *** Misc Fixes *** {{{1
set hidden					 " fix 'must save first' when changing buffers
set lazyredraw				 " don't update the screen while playing macros
set mousehide				 " hide pointer while typing
set clipboard+=unnamed		 " supposed to use the system clipboard
set swapsync=
set shortmess+=I			 " remove useless splash screen

" *** AutoComplete *** {{{1
set completeopt=longest,menuone
set wildmenu
"set wildmode=list:longest
if has('unix')
	set dictionary+=/usr/share/dict/words
endif


" *** Filetype settings *** {{{1
if has('autocmd')
	filetype plugin indent on
	autocmd BufNewFile,BufRead *.txt setlocal filetype=text
	autocmd FileType text setlocal textwidth=78 complete+=k infercase
	autocmd FileType html setlocal shiftwidth=4 tabstop=4
	autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab
	autocmd BufRead *.py nmap <buffer> <F5> :!python %<CR>
	autocmd BufRead *.c,*.h  nmap <buffer> <F5> :!scons<CR>
	autocmd BufWritePost *.coffee silent CoffeeMake!
	autocmd BufNewFile,BufRead SConstruct setlocal filetype=python
	autocmd BufNewFile,BufRead *.asm setlocal filetype=fasm
	autocmd BufNewFile,BufRead *.nginx setlocal filetype=nginx
	autocmd BufNewFile,BufRead */templates/*.html setlocal filetype=django

	autocmd BufNewFile,BufRead *.php setlocal makeprg=php\ % errorformat=%m

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	" (happens when dropping a file on gvim).
	" Also don't do it when the mark is in the first line, that is the default
	" position when opening a file.
	autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
	autocmd! BufWritePost .vimrc source $MYVIMRC
	if has("win32")
		autocmd! BufWritePost vimrc source $MYVIMRC
	endif
	" set autoread
endif


" *** Plug-in related settings *** {{{1
let NERDTreeIgnore=['\.psd', '__MACOSX', '\.o', '\.pyc']
let g:buftabs_active_highlight_group="Visual"
let g:buftabs_in_statusline=0
let g:buftabs_only_basename=1
let g:netrw_ftp_cmd="ftp -p"
let g:netrw_localmovecmd = 'move'
let g:pydiction_location = '~/.vim/after/ftplugin/pydiction/complete-dict'
let g:snips_author = 'Cenan Özen'
let g:use_zen_complete_tag = 1
let g:user_zen_expandabbr_key = '<c-d>'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 2
let g:ctrlp_custom_ignore = {
  \ 'dir': '\.git$\|\.hg$\|\.temp$',
  \ 'file': '\.pyc$\|\.mp3$\|\.flac$\|\.swp$\|\.o$',
  \ 'link': '',
  \ }


" *** Functions *** {{{1
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

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
" TODO: check for existing modeline
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d :",
		\ &tabstop, &shiftwidth, &textwidth)
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction

" *** Misc *** {{{1

" source machine local configuration if it exists
if filereadable($HOME . "/.vim/local.vim")
   source $HOME/.vim/local.vim
endif 

