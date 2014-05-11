set nocompatible			 " must be the first line

" *** Bundles *** {{{1
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

Bundle 'scrooloose/nerdtree'
Bundle 'Tagbar'
Bundle 'kien/ctrlp.vim'
Bundle 'mhinz/vim-startify'

Bundle 'Syntastic'
Bundle 'mattn/emmet-vim'

Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'

"if has("mac")
"  set background=dark
"  colorscheme solarized
"else
"  Bundle 'CSApprox'
"endif
"Bundle 'ap/vim-css-color'

Bundle 'plasticboy/vim-markdown'
Bundle 'groenewege/vim-less'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-rails'

if has('python')
  Bundle 'SirVer/ultisnips'
  Bundle 'honza/vim-snippets'
endif

Bundle 'bling/vim-airline'
let os=substitute(system('uname'), '\n', '', '')
if os == 'Darwin' || os == 'Mac'
	Bundle 'junegunn/vim-emoji'
endif

Bundle 'altercation/vim-colors-solarized'

if has('unix')
	Bundle 'justinmk/vim-gtfo'
endif

" nono/vim-handlebars

" Python bundles
" vim-flake8

" *** General Settings *** {{{1
set history=500				 " command line history
set encoding=utf-8 fileencodings=
set foldmethod=marker
set cryptmethod=blowfish

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
  set ruler				" always show the cursor position
  set showcmd			" display incomplete commands
endif

if has('statusline')
  set laststatus=2
  if has("win32")
    set statusline=%=%m%l/%L-%p%%
  else
    set statusline=\#{buftabs}%=
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    set statusline+=\ %m%3p%%
    set statusline+=\ %L\ %{fugitive#statusline()}
    set statusline+=%y\ %{\&ff}\
  endif
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
  "let g:solarized_termcolors=256
  "let g:solarized_termtrans=1
  if has("win32")
    colorscheme Borland
  else
    "set background=light
    "if index(['tokyo','pegasus'], hostname()) >= 0
    "  colorscheme Tomorrow-Night-Bright
    "else
    "  if has("mac")
    "    colorscheme molokai
    "  else
    "    colorscheme Tomorrow-Night-Eighties
    "  endif
    "endif
  endif
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

nnoremap <silent> <leader>me :messages<cr>

" append mode line to end of current file
nnoremap <silent> <leader>ml :call AppendModeline()<cr>
nnoremap <silent> <leader>mlf :call AppendModelineFileType()<cr>

" tabs to spaces
nnoremap <silent> <leader>r :set noet\|retab!<cr>

" edit .vimrc
nnoremap <silent> <leader>v :edit $MYVIMRC<cr>

nnoremap <silent> <leader>z :let &scrolloff=999-&scrolloff<cr>
nnoremap <silent> <leader>sc :!scons<cr>
nnoremap <silent> <leader>j :%!python -m json.tool<cr>

" replace the selection in visual-mode
vnoremap <C-r> "hy:%s/<C-r>h//g<left><left>

nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gp :Git push origin master<cr>

nnoremap <C-h> :lprev<cr>
nnoremap <C-l> :lnext<cr>

if has('autocmd')
  nmap <F8> :set paste<cr>i
  autocmd InsertLeave * set nopaste
  inoremap <c-c> <esc>
  nnoremap <c-c> <nop>
endif

noremap <silent> <F2> :NERDTreeToggle<CR>
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

nmap <leader>n :NERDTreeFind<cr>
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

nnoremap <C-S> :w<CR>
inoremap <C-S> <ESC>:w<CR>a

" *** Toggle various UI options *** {{{2
" toggle airline
nnoremap <silent> <leader>ta :AirlineToggle<cr>
" toggle gitgutter
nnoremap <silent> <leader>tg :GitGutterToggle<cr>
nnoremap <silent> <leader>tgl :GitGutterLineHighlightsToggle<cr>
" toggle tab and crlf characters
nnoremap <silent> <leader>tl :set list!<cr>
" toggle nerdtree
nnoremap <silent> <leader>tnt :NERDTreeToggle<cr>
" toggle line numbers
nnoremap <silent> <leader>tnu :set invnumber<cr>
" toggle syntax highlighting
nnoremap <silent> <leader>ts :call ToggleSyntax()<cr>

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

set whichwrap+=<,>,h,l,[,]

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
  autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType scheme setlocal shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType coffee setlocal shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2
  autocmd FileType ruby setlocal expandtab shiftwidth=2 softtabstop=2
  autocmd FileType eruby setlocal expandtab shiftwidth=2 softtabstop=2
  autocmd FileType vim setlocal foldcolumn=2
  autocmd BufRead *.py nmap <buffer> <F5> :!python %<CR>
  autocmd BufRead *.c,*.h  nmap <buffer> <F5> :!scons<CR>
  " autocmd BufWritePost *.coffee silent CoffeeMake!
  autocmd BufNewFile,BufRead SConstruct setlocal filetype=python
  autocmd BufNewFile,BufRead *.coffee setlocal filetype=coffee
  autocmd BufNewFile,BufRead *.cap setlocal filetype=ruby
  autocmd BufNewFile,BufRead *.fab setlocal filetype=python
  autocmd BufNewFile,BufRead *.as setlocal filetype=actionscript
  autocmd BufNewFile,BufRead *.asm setlocal filetype=fasm
  autocmd BufNewFile,BufRead *.nginx setlocal filetype=nginx
  autocmd BufNewFile,BufRead *.twig setlocal filetype=twig
  autocmd BufNewFile,BufRead */templates/*.html setlocal filetype=django
  autocmd BufNewFile,BufRead *.json setlocal filetype=javascript
  autocmd BufNewFile,BufRead Gemfile setlocal filetype=ruby

  autocmd BufNewFile,BufRead *.php setlocal makeprg=php\ % errorformat=%m

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  autocmd! BufWritePost .vimrc source $MYVIMRC
  autocmd! BufWritePost .vimrc silent AirlineRefresh
  if has("win32")
    autocmd! BufWritePost vimrc source $MYVIMRC
  endif
  " set autoread
endif


" *** Plug-in related settings *** {{{1

" *** NERDTree *** {{{2
let NERDTreeIgnore=['\.psd', '__MACOSX', '\.o', '\.pyc', '.DS_Store']

" *** Buftabs *** {{{2
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

" *** Ctrl-P *** {{{2
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 'rc'
let g:ctrlp_dotfiles = 0
let g:ctrlp_custom_ignore = {
  \ 'dir': '\.git$\|\.hg$\|\.temp$|node_modules$',
  \ 'file': '\.pyc$\|\.mp3$\|\.flac$\|\.swp$\|\.o$',
  \ 'link': '',
  \ }
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_regexp = 0
"let ctrlp_match_window_bottom = 0
"let ctrlp_match_window_reversed = 0

" *** GitGutter *** {{{2
let g:gitgutter_highlight_lines = 0
silent! if emoji#available()
  let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
  let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
  let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
  let g:gitgutter_sign_modified_removed = emoji#for('collision')
endif

" *** NetRW *** {{{2
let g:netrw_ftp_cmd="ftp -p"
let g:netrw_localmovecmd = 'move'

" *** Syntastic *** {{{2
let g:syntastic_auto_loc_list = 1

" *** TagBar *** {{{2
let g:tagbar_ctags_bin='/usr/bin/ctags-exuberant'

" *** Emmet *** {{{2
let g:user_emmet_complete_tag = 1
let g:user_emmet_expandabbr_key = '<c-e>'
let g:user_emmet_settings = {'less': {'filters': 'fc','extends': 'css'}}

let g:pydiction_location = '~/.vim/after/ftplugin/pydiction/complete-dict'

" *** VimAirline {{{2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline_theme = "solarized"
let g:airline_theme = "bubblegum"

" *** Startify{{{2
let g:startify_files_number=8
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

" %s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g
function! ListEmojis()
  for e in emoji#list()
    call append(line('$'), printf('%s (%s)', emoji#for(e), e))
  endfor
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

" vim: set ts=2 sw=2 tw=78 :
