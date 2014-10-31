set nocompatible
filetype off 
" PACKAGES
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'		" fuzzy file finder, buffer switcher, MRU, etc.
Plugin 'bling/vim-airline'  " fancy statusline
"Plugin 'fholgado/minibufexpl.vim'
"Plugin 'Valloric/YouCompleteMe' " has a compiled component, not officially supported on windows
"Plugin 'vim-scripts/noerrmsg.vim' " shut up YouCompleteMe error messages (adhoc)

"Plugin 'Shougo/vimproc.vim'  " Required for vimshell
"Plugin 'Shougo/vimshell.vim' 

Plugin 'xolox/vim-misc'		 " Required for vim-easytags
Plugin 'xolox/vim-easytags'

Plugin 'mileszs/ack.vim' " ack

"Plugin 'endel/vim-github-colorscheme' " github colorscheme

"Plugin 'Shougo/neocomplcache.vim' 

"Plugin 'tomasr/molokai'
"Plugin 'Shougo/unite.vim'

Plugin 'majutsushi/tagbar' " integrates with airline to show current tag

Plugin 'vim-scripts/ruby-matchit' " def -> end using %

Plugin 'christoomey/vim-tmux-navigator'

"let g:ycm_auto_trigger=0 " disable YouCompleteMe temporarily

call vundle#end()
filetype plugin indent on

" BASIC
set nu 					" add line numbers
let mapleader=","  		" use , for leader key
set hidden				" allow hidden buffer changes
set t_Co=256			" 256 color terminal support
" change fold highlight to purple color similar to terminal, and white font
" use colortest script to find colors
highlight Folded ctermfg=231 ctermbg=53 
set encoding=utf-8 		" use utf-8
set noesckeys			" fixes delay when pressing esc to get out of insert mode

" SHIFTING
set shiftwidth=4
set tabstop=4				" 4 char tabs
set autoindent				" always autoindent
set copyindent				" copy previous indentation
set shiftround				" indent by multiples of shiftwidth
set smarttab

" AUTOCOMPLETION
set completeopt=longest,menuone		" change autocompletion
set dictionary+=/usr/share/dict/words " add word list to dictionary
"set complete+=k						" add dictionary (k) completion to ctrl+n default case

" STATUS
set noshowmode				" get rid of -- INSERT -- from bar
set laststatus=2

" SIZE
set columns=84					" allow room for the 4 character lines margin
"set columns=125				" bigger window
"set lines=40

" LINES
set nowrap				" disable line wrapping
set backspace=indent,eol,start		" backspace over everything

" MATCHING
set showmatch				" show matching parenthesis
set ignorecase				" ignore cases in search
set smartcase				" unless case sensitive
set hlsearch				" highlight search terms
set incsearch				" incremental searching

" NETRW
let g:netrw_liststyle=3		" set netrw style to NerdTree style
let g:netrw_banner=0		" remove banner

function! NetRW_Depth(...)
	let line = getline(a:1)
	let line = substitute(line, ' ', '', 'g') " strip whitespace 
	let pipes = substitute(line, '\v(\|*).*', '\1', 'g') " leave only initial | 
	let depth = strlen(pipes)
	return depth
endfunction

function! NetRW_Up()
	let line_number = line('.')
	let original_line_number = line('.')
	let original_depth = NetRW_Depth(line_number)
	while line_number >= 1
		let line_number = line_number - 1
		if NetRW_Depth(line_number) == original_depth - 1
			return line_number
		endif
	endwhile
	return original_line_number
endfunction

autocmd filetype netrw nnoremap <buffer> - :execute "normal " . NetRW_Up() . "G"<cr>:call netrw#LocalBrowseCheck(<SNR>64_NetrwBrowseChgDir(1,<SNR>64_NetrwGetWord()))<CR>
"autocmd filetype netrw nnoremap <buffer> q :bwipeout<cr>:bd<cr>

" BINDINGS
nnoremap <Leader>v :e ~/.vimrc<cr>
nnoremap <Leader>so :source ~/.vimrc<cr>
nnoremap <Leader><Leader> :bn<cr>
nnoremap <Leader>m :bp<cr>
nnoremap <Leader>w :w<cr>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>Q :q!<cr>
nnoremap <Leader>c :make<cr>
"nnoremap <Leader>t :shell<cr>
nnoremap <Leader>d :e.<cr>
"nnoremap <Leader>p :<C-u>Unite -no-split -buffer-name=files -start-insert file_rec/async:!<cr>
nnoremap <F5> :setlocal spell! spelllang=en_us<cr> 
"nnoremap <c-F> <c-w>w<c-f><c-w>w
"nnoremap <c-B> <c-w>w<c-b><c-w>w

"nmap \i @='yyp$daw0Pa,<C-v><Esc>$xj'<cr>
nmap \l vaw"ayggdG:r!ruby ~/.scripts/lookup.rb <(echo <C-r>a)<cr>gg/Verb<cr>:noh<cr>zt
nmap \i @='yypf,ly$0Pa,<C-v><Esc>f,d$j'<cr>
nmap \h :noh<cr>
nmap \w :set wrap!<cr>
nmap \zs :set foldmethod=syntax<cr>
nmap \zi :set foldmethod=indent<cr>
nmap \zm :set foldmethod=manual<cr>
nmap \v :vsp<cr>
nmap \s :split<cr>

" RUN BINDINGS
au filetype ruby nnoremap <buffer> <Leader>r :!ruby %:p<cr>
au filetype python nnoremap <buffer> <Leader>r :!python %:p<cr>
au filetype haskell nnoremap <buffer> <Leader>r :!runhaskell %:p<cr>

" execute command under cursor
nnoremap <Leader>x !$sh<cr>
nnoremap <Leader>j yyp
nnoremap <Leader>k yyP

" BUNDLE KEYS
nnoremap <Leader>bi :BundleInstall<cr>
nnoremap <Leader>bc :BundleClean<cr>

" CTRLP KEYS
nnoremap  <Leader>p :CtrlP<cr>
nnoremap  <Leader>t :CtrlPBufTag<cr>
nnoremap  <Leader>T :CtrlPTag<cr>
nnoremap  <Leader>. :CtrlPBuffer<cr>
nnoremap  <Leader>R :CtrlPMRU<cr>

" AIRLINE SETTINGS
if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

"stop whitespace detection stuff
autocmd VimEnter * silent AirlineToggleWhitespace

" unicode symbols
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.linenr = 'L' "'␤'
let g:airline#extensions#tabline#enabled = 1

" VIM-EASYTAGS - DELETE ~/.vimtags ON STARTUP
au VimEnter * silent !echo ""  > ~/.vimtags

function! SearchClassUp(...)
	let lineno = line(".")
	let startlineno = lineno

	while lineno >= 1
		let lineno = lineno - 1

		if getline(lineno) =~ "class"
			return lineno
		end
	endwhile

	return startlineno
endfunction

autocmd filetype ruby nnoremap <buffer> [c :silent! execute "normal " . SearchClassUp() . "G"<cr>
