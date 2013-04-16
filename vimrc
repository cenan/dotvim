set nocompatible			 " must be the first line

" *** Pathogen Settings *** {{{1
let pathogen_disabled=[]
" call add(g:pathogen_disabled, 'gundo')
execute pathogen#infect()
execute pathogen#helptags()
execute pathogen#incubate()

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
		set statusline=\#{buftabs}%=
		if count(g:pathogen_disabled, 'Syntastic') < 1
			set statusline+=%#warningmsg#
			set statusline+=%{SyntasticStatuslineFlag()}
			set statusline+=%*
		endif
		set statusline+=\ %m%3p%%
		if count(g:pathogen_disabled, 'Fugitive') < 1
			set statusline+=\ %L\ %{fugitive#statusline()}
		endif
		set statusline+=%y\ %{\&ff}\ 
	endif
	"au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
	"au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
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
		set guifont=Inconsolata\ 10
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
			if has("mac")
				colorscheme molokai
			else
				colorscheme Tomorrow-Night-Eighties
			endif
		endif
	end
endif

set scrolloff=3

set fillchars=""			 " no window separator character
set cursorline				 " highlight current line
set nocursorcolumn			 " don't highlight current column
set number					 " show line numbers
set listchars=tab:▸\ ,eol:¬
set listchars+=trail:←
set listchars+=extends:»
set listchars+=precedes:«

if has('autocmd')
	autocmd BufEnter * :setlocal cursorline
	autocmd BufLeave * :setlocal nocursorline
endif

" *** Keys *** {{{1
let mapleader = ","
imap jk <esc>

" turn off search highlighting, close quickfix pane
noremap // :nohlsearch <bar> cclose <cr>

" echo filename
nnoremap <silent> <leader>f :echo @%<cr>

" show tab and crlf characters
nnoremap <silent> <leader>l :set list!<cr>

nnoremap <silent> <leader>me :messages<cr>

" append mode line to end of current file
nnoremap <silent> <leader>ml :call AppendModeline()<cr>
nnoremap <silent> <leader>mlf :call AppendModelineFileType()<cr>

" tabs to spaces
nnoremap <silent> <leader>r :set noet\|retab!<cr>

" toggle syntax highlighting
nnoremap <silent> <leader>x :call ToggleSyntax()<cr>

" edit .vimrc
nnoremap <silent> <leader>v :edit $MYVIMRC<cr>
nnoremap <silent> <leader>z :let &scrolloff=999-&scrolloff<cr>
" change colorscheme
nnoremap <silent> <leader>c1 :colorscheme Tomorrow<cr>
nnoremap <silent> <leader>c2 :colorscheme Tomorrow-Night<cr>
nnoremap <silent> <leader>c3 :colorscheme Tomorrow-Night-Blue<cr>
nnoremap <silent> <leader>c4 :colorscheme Tomorrow-Night-Bright<cr>
nnoremap <silent> <leader>c5 :colorscheme Tomorrow-Night-Eighties<cr>
nnoremap <silent> <leader>m0 :colorscheme molokai<cr>
nnoremap <silent> <leader>s1 :colorscheme solarized<cr>
nnoremap <silent> <leader>sc :!scons<cr>
nnoremap <silent> <leader>j :%!python -m json.tool<cr>

" replace the selection in visual-mode
vnoremap <C-r> "hy:%s/<C-r>h//g<left><left>

nnoremap <leader>s :Gstatus<cr>

nnoremap <C-h> :lprev<cr>
nnoremap <C-l> :lnext<cr>

if has('autocmd')
	nmap <F8> :set paste<cr>i
	autocmd InsertLeave * set nopaste
	inoremap <c-c> <esc>
	nnoremap <c-c> <nop>
endif

noremap <silent> <F2> :NERDTreeToggle<CR>
nnoremap <silent> <C-S-n> :NERDTreeToggle<CR>
if executable("ctags")
	nmap <silent> <F3> :TagbarToggle<CR>
	nnoremap <silent> <space> :NERDTreeClose <bar> cclose <bar> lclose <bar> TagbarClose <cr>
else
	nmap <silent> <F3> :echo "CTags yoksa Tagbar da yok !!"<cr>
	nnoremap <silent> <space> :NERDTreeClose <bar> cclose <bar> lclose <cr>
endif

noremap <C-J> :bp<CR>
nnoremap <S-Tab> :bp<CR>
noremap <C-K> :bn<CR>
nnoremap <Tab> :bn<CR>

" Disable Tab and S-Tab on NERDTree window
autocmd FileType nerdtree noremap <buffer> <S-Tab> <nop>
autocmd FileType nerdtree noremap <buffer> <Tab> <nop>

inoremap <c-space> <C-x><C-o>
" save anyway when you forget to sudo
cnoremap w!! w !sudo tee % >/dev/null

vmap <C-S-Up> dkP`[V`]
vmap <C-S-Down> dp`[V`]

nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<cr>:copen<cr>

noremap <silent> <F12> :set number!<CR>

" *** Key Fixes *** {{{2
set backspace=indent,eol,start
" CTRL-U in insert mode deletes a lot.	Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

"cmap W w
"cmap Q q
cnoremap WQ wq
cnoremap Wq wq

"noremap <up> <nop>
"noremap <down> <nop>
"noremap <left> <nop>
"noremap <right> <nop>


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

" *** Abbreviations *** {{{1

iab tihs this
iab tehn then

" *** Filetype settings *** {{{1
if has('autocmd')
	filetype plugin indent on
	autocmd BufNewFile,BufRead *.txt setlocal filetype=text
	autocmd FileType text setlocal textwidth=78 complete+=k infercase
	autocmd FileType html setlocal shiftwidth=4 tabstop=4
	autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab
	autocmd FileType scheme setlocal shiftwidth=2 softtabstop=2 expandtab
	autocmd FileType coffee setlocal expandtab
	autocmd FileType javascript setlocal expandtab
	autocmd BufRead *.py nmap <buffer> <F5> :!python %<CR>
	autocmd BufRead *.c,*.h  nmap <buffer> <F5> :!scons<CR>
	" autocmd BufWritePost *.coffee silent CoffeeMake!
	autocmd BufNewFile,BufRead SConstruct setlocal filetype=python
	autocmd BufNewFile,BufRead *.fab setlocal filetype=python
	autocmd BufNewFile,BufRead *.as setlocal filetype=actionscript
	autocmd BufNewFile,BufRead *.asm setlocal filetype=fasm
	autocmd BufNewFile,BufRead *.nginx setlocal filetype=nginx
	autocmd BufNewFile,BufRead *.twig setlocal filetype=twig
	autocmd BufNewFile,BufRead */templates/*.html setlocal filetype=django
	autocmd BufNewFile,BufRead *.json setlocal filetype=javascript

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

let g:buftabs_only_basename=1
let g:buftabs_marker_modified=" +"
let g:buftabs_show_number=0
let g:buftabs_blacklist = ["^NERD_tree_[0-9]*$", "^__Tagbar__$"]
let g:buftabs_other_components_length=30
if &t_Co == 256 || has('gui_running')
  let g:buftabs_active_highlight_group="TabLineSel"
  let g:buftabs_marker_start=' '
  let g:buftabs_marker_end=' '
endif

let g:netrw_ftp_cmd="ftp -p"
let g:netrw_localmovecmd = 'move'
let g:pydiction_location = '~/.vim/after/ftplugin/pydiction/complete-dict'
let g:snips_author = 'Cenan Özen'
let g:use_zen_complete_tag = 1
let g:user_zen_expandabbr_key = '<c-d>'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 'rc'
let g:ctrlp_dotfiles = 0
let g:ctrlp_custom_ignore = {
  \ 'dir': '\.git$\|\.hg$\|\.temp$|node_modules$',
  \ 'file': '\.pyc$\|\.mp3$\|\.flac$\|\.swp$\|\.o$',
  \ 'link': '',
  \ }
"let ctrlp_match_window_bottom = 0
"let ctrlp_match_window_reversed = 0

let g:user_zen_settings = {'less': {'filters': 'fc','extends': 'css'}}

let g:syntastic_auto_loc_list = 1

let g:tagbar_ctags_bin='/usr/bin/ctags-exuberant'

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

function! AppendModelineFileType()
	let l:modeline = printf(" vim: set filetype=%s : ", &filetype)
	let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
	call append(line("$"), l:modeline)
endfunction

" *** Misc *** {{{1

" source machine local configuration if it exists
if filereadable($HOME . "/.vim/local.vim")
   source $HOME/.vim/local.vim
endif 

" The following autocommand will cause the quickfix window to open after any grep invocation:
if has('autocmd')
	autocmd QuickFixCmdPost *grep* cwindow
endif

