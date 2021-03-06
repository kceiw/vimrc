" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" For pathogen.vim: auto load all plugins in .vim/bundle
execute pathogen#infect()

" auto reload vimrc when editing it
autocmd! BufWritePost .vimrc source ~/.vimrc

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50          " keep 50 lines of command line history
set showcmd             " display incomplete commands
set ignorecase
" ignore case if search pattern is all lowercase,case-sensitive otherwise
set smartcase
" allows pattern matching with special characters
set magic
set incsearch           " do incremental searching

" show relative line number
set number
set relativenumber

set enc=utf-8
set fileencodings=utf-8,gb18030,utf-16,big5
set fileformats=unix,dos
set nobackup
" highlight the line where the cursor is
set cursorline
" instruct VIM not to always redraw, especially during macro
set lazyredraw

" show special characters
set list
set listchars=tab:▸\ ,eol:¬

" Set to auto read when a file is changed from the outside
set autoread

" auto implement enhancement
set wildmenu

set wildignore+=*.o,*.tmp,*.bak,*.so,*.swp,*.zip,*.git,*.git/*,*pyc,*.obj,*.lib,*.dll,*gz,*bzip2

set modeline

" highlight the matched parentheses
set showmatch

set ruler               " show the cursor position all the time
set rulerformat=%{strftime('%a\ %m')}
set cmdheight=2
set laststatus=2
" show file type and encoding in status line
" %F file name
" %m modification status
" %r read only?
" %y file type
" %{&fileformat} file encoding
" %b the ACSII on the cursor
" %B the hex code on the cursor
" %l cursor line
" %c cursor colume
" %V virtual row number
" %p percentile
" %% %
" %L total line number
set statusline=%f%m%r\ %y\ %l:%c(%p%%)/%L%<\ %{fugitive#statusline()}\ %{&fileformat}\ %{&fileencoding}\ %{strftime(\"%a\ %d/%m\ %H:%M\")}

" auto format
" t: auto-wrap text using textwidth. (does not apply to comments)
" c: auto-wrap comments using textwidth
" q: allow formatting of comments with gq command. When using gq command in
" comments, blank lines and lines only with comment leaders and white spaces
" are considered as paragraph delimiters.
" r: auto insert comment leader after hitting 'Enter' in Insert mode.
" o: auto insert comment leader after hitting 'o' or 'O'
" a: auto format paragraphs when text is inserted or deleted
" w: a trailing non white space ends a paragraph
" n: numbered lists
set formatoptions=tcrqnocw


" whether fold or not
set foldenable
set foldmethod=syntax
set foldcolumn=0
set foldlevelstart=10

" wrap and the length of a line
set wrap
set linebreak
set textwidth=80

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

set noexpandtab
set tabstop=4 shiftwidth=4 softtabstop=4

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  filetype plugin indent on
  set grepprg=grep\ -nH\ $*
  if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading
  endif

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx

  " Remove All autocommands for the current group.
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  au BufEnter,BufRead,BufNewFile *.txt setlocal ft=text
  au BufEnter,BufRead,BufNewFile *.js setlocal ft=javascript
  au BufEnter,BufRead,BufNewFile *.hbs setlocal ft=hbs
  au BufEnter,BufRead,BufNewFile *.json setlocal ft=json
  au BufEnter,BufRead,BufNewFile *.less setlocal ft=less
  au BufEnter,BufRead,BufNewFile *.py setlocal ft=python
  au BufEnter,BufRead,BufNewFile *.html setlocal ft=html
  au BufEnter,BufRead,BufNewFile *.csproj setlocal ft=xml tabstop=2 shiftwidth=2 expandtab
  au BufEnter,BufRead,BufNewFile *.targets setlocal ft=xml tabstop=2 shiftwidth=2 expandtab
  au BufEnter,BufRead,BufNewFile *.xaml setlocal ft=xml
  au BufEnter,BufRead,BufNewFile *.yaml setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

  autocmd QuickFixCmdPost *grep* cwindow

  augroup END
else
  set autoindent                " always set autoindenting on

endif " has("autocmd")

" set the map leader
" default is /
let mapleader = ","
let maplocaleader = ","

" vertically split the window and move to the new one
nnoremap <leader>w <C-w>v<C-w>l

" move between windows
nmap <leader>wj <C-W>j
nmap <leader>wk <C-W>k
nmap <leader>wh <C-W>h
nmap <leader>wl <C-W>l
nmap <leader>w- <C-W>-
nmap <leader>w+ <C-W>+
nmap <leader>w= <C-W>=
nmap <leader>w, <C-W><
nmap <leader>w. <C-W>>

" redraw
map <leader>l :redraw<CR>

" tab shortcut
nmap <leader>tnew :tabnew<CR>
nmap <leader>te :tabedit<CR>
nmap <leader>tc :tabclose<CR>
nmap <leader>tm :tabmove<CR>
nmap <leader>tn :tabnext<CR>
nmap <leader>tp :tabprevious<CR>
nmap <leader>tf :tabfirst<CR>
nmap <leader>tl :tablast<CR>

" open the quickfix window
map <leader>f :botright cope<CR>

" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h

" clear search highlighting
nnoremap <leader><space> :noh<cr>

" strip trailing spaces
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

nnoremap <leader>u :GundoToggle<CR>

""""""""""""""""""""""""""""""""""""""
" Begin of setting of plugin fugutive

if has("autocmd")
  autocmd BufReadPost fugitive://* set bufhidden=delete
endif " has("autocmd")

" End of setting of plugin fugutive
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
" Begin of setting of rainbow
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
" End of setting of rainbow
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
" Begin of setting of TagBar
nmap <F8> :TagbarToggle<CR>
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
" Begin of setting of ALE
" Only run ale on file save
let g:ale_lint_on_text_changed = 'never'
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0
" Show quickfix window when the file contains error/warning.
let g:ale_open_list = 1
" This can be useful if you are combining ALE with
" some other plugin which sets quickfix errors, etc.
let g:ale_keep_list_window_open = 1

" Change the gutter character
let g:ale_sign_error = 'LE'
let g:ale_sign_warning = 'LW'

let g:ale_linters = {
			\ 'py': ['pylint', 'flake8']
			\}

" End of setting of ALE
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
" Begin of setting of plugin NERDTree
" Show NERT tree at the left
" Quickfix window seems to open below the second window.
" If NERDTREE is at the right. Most likely Quickfix window will show below it.
let g:NERDTreeWinPos = 'left'

" Show hidden files
let NERDTreeShowHidden = 1

augroup nerdtree_auto
	autocmd!

	" start Nerdtree if vim doesn't open a file
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

	" start Nerdtree if vim opens a directory
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | wincmd p | endif

	" close vim if only Nerdtree is left
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END
" End of setting of plugin NERDTree
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
" Begin of setting of plugin NERDCommenter
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" End of setting of plugin NERDCommenter
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
" Begin of vim-better-whitespace
" Remove trailing whitespace on save
let g:strip_whitespace_on_save = 1
" Don't confirm when removing on save.
let g:strip_whitespace_confirm=0
" Only remove on the modified lines when it's saved.
let g:strip_only_modified_lines=0
" End of vim-better-whitespace
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
" Begin of ack
" End of ack
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
" Begin of FZF

" Have Ag and Rg take options.
" https://github.com/junegunn/fzf.vim/issues/92
function! s:ag_with_opts(arg, bang)
	let tokens  = split(a:arg)
	let ag_opts = join(filter(copy(tokens), 'v:val =~ "^-"'))
	let query   = join(filter(copy(tokens), 'v:val !~ "^-"'))
	call fzf#vim#ag(query, ag_opts, a:bang ? {} : {'down': '40%'})
endfunction

function! s:rg_with_opts(arg, bang)
	let tokens  = split(a:arg)
	let ag_opts = join(filter(copy(tokens), 'v:val =~ "^-"'))
	let query   = join(filter(copy(tokens), 'v:val !~ "^-"'))
	call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".ag_opts.query, 1)
endfunction

augroup fzf_group
	autocmd!
	autocmd VimEnter * command! -nargs=* -bang Ag call s:ag_with_opts(<q-args>, <bang>0)
	autocmd VimEnter * command! -nargs=* -bang Rg call s:rg_with_opts(<q-args>, <bang>0)
augroup END

" End of FZF
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
" Begin of YouCompleteMe
let g:ycm_filetype_whitelist = {
        \ 'python': 1,
        \ 'cs': 1,
        \ 'javascript': 1,
        \ 'typescript': 1
        \ }

" auto trigger ycm. This also enable signature help
let g:ycm_auto_trigger = 1

" echo the current diagnostic when you move the cursor to the line.
let g:ycm_echo_current_diagnostic = 1

" Set the error symbol
let g:ycm_error_symbol = 'EE'

" Set the warning symbol
let g:ycm_warning_symbol = 'WW'

" auto close the preview window
let g:ycm_autoclose_preview_window_after_completion = 1

" auto complete in comment in case it has code snippet
let g:ycm_complete_in_comments = 1
"
augroup ycm_keymapping
	autocmd!

	" Enable mapping for the supported files.

    autocmd FileType c,cpp,cs,javascript,python,typescript nnoremap <Leader>yd :YcmCompleter GoTo<CR>
    autocmd FileType javascript,typescript nnoremap <Leader>yim :YcmCompleter GotoImplementation<CR>
	autocmd FileType cs nnoremap <Leader>yim :YcmCompleter GoToImplementationElseDeclaration<CR>
    autocmd FileType c,cpp nnoremap <Leader>yin :YcmCompleter GotoInclude<CR>
    autocmd FileType c,cpp nnoremap <Leader>yp :YcmCompleter GetParent<CR>
    autocmd FileType c,cpp,cs,javascript,python,typescript nnoremap <Leader>yr :YcmCompleter GoToReferences<CR>
    autocmd FileType c,cpp,cs,javascript,python,typescript nnoremap <Leader>yt :YcmCompleter GetType<CR>

    autocmd FileType c,cpp,javascript,typescript nnoremap <Leader>yx :YcmCompleter FixIt<CR>
    autocmd FileType c,cpp,cs,javascript,python,typescript nnoremap <Leader>yc :YcmCompleter GetDoc<CR>

    autocmd FileType c,cpp,javascript,typescript nnoremap <Leader>yf :YcmCompleter Format<CR>


augroup END

" End of YouCompleteMe
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
" Begin of vimspector

" the HUMAN mappings are
" Key 	Function 	API
" F5 	When debugging, continue. Otherwise start debugging. 	vimspector#Continue()
" F3 	Stop debugging. 	vimspector#Stop()
" F4 	Restart debugging with the same configuration. 	vimspector#Restart()
" F6 	Pause debugee. 	vimspector#Pause()
" F9 	Toggle line breakpoint on the current line. 	vimspector#ToggleBreakpoint()
" <leader>F9 	Toggle conditional line breakpoint on the current line. 	vimspector#ToggleBreakpoint( { trigger expr, hit count expr } )
" F8 	Add a function breakpoint for the expression under cursor 	vimspector#AddFunctionBreakpoint( '<cexpr>' )
" <leader>F8 	Run to Cursor 	vimspector#RunToCursor()
" F10 	Step Over 	vimspector#StepOver()
" F11 	Step Into 	vimspector#StepInto()
" F12 	Step out of current function scope 	vimspector#StepOut()
let g:vimspector_enable_mappings = 'HUMAN'

" End of vimspector
""""""""""""""""""""""""""""""""""""""

" Put these lines at the very end of your vimrc file.

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
