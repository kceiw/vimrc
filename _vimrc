" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" For pathogen.vim: auto load all plugins in .vim/bundle
execute pathogen#infect()

" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set ff=unix

set history=50		" keep 50 lines of command line history
set showcmd		" display incomplete commands
" do not redraw, when running macros..
set lz
set ignorecase
" ignore case if search pattern is all lowercase,case-sensitive otherwise
set smartcase
" allows pattern matching with special characters
set magic
set incsearch		" do incremental searching
set nu!                 " display line number
set enc=utf-8
set fileencodings=utf-8,gb18030,utf-16,big5
set fileformats=unix,dos
set nobackup

" show special characters
set list
set listchars=tab:▸\ ,eol:¬

" Set to auto read when a file is changed from the outside
set autoread

" auto implement enhancement
set wildmenu

" highlight the matched parentheses
set showmatch

set ruler		" show the cursor position all the time
set rulerformat=%{strftime('%a\ %m')}
set cmdheight=2
set laststatus=2
" show file type and encoding in status line
" %F file name
" %m modification status
" %r read only?
" %Y file type
" %{&fileformat} file encoding
" %b the ACSII on the cursor
" %B the hex code on the cursor
" %l cursor line
" %c cursor colume
" %V virtual row number
" %p percentile
" %% %
" %L total line number
set statusline=%f%m%r\ 0x%B\ %y\ %l:%c(%p%%)/%L%<\ %{&fileformat}\ %{&fileencoding}\ %{strftime(\"%a\ %d/%m\ %H:%M\")}

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
set formatoptions=tcrqnocw


" whether fold or not
" set foldenable
set foldmethod=syntax
set foldcolumn=0

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

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  filetype plugin indent on
  set grepprg=grep\ -nH\ $*

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx

  " Remove All autocommands for the current group.
  au!

  " For all text files set 'textwidth' to 80 characters.
  autocmd FileType text setlocal textwidth=80

  autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType lua setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType css setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType less setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType json setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType typescript setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType ts setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType javascript setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType sql setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType html setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType htmldjango setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType hbs setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType objc setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4
  autocmd FileType cs setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4
  autocmd FileType sh setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4

  autocmd FileType c setlocal shiftwidth=8 tabstop=8 textwidth=80
  autocmd FileType cpp setlocal shiftwidth=8 tabstop=8 textwidth=80
  autocmd FileType java setlocal shiftwidth=8 tabstop=8

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " for velocity.vim
  au BufEnter,BufRead,BufNewFile *.vm  setfiletype velocity
  au BufEnter,BufRead,BufNewFile *.txt setlocal ft=text
  au BufEnter,BufRead,BufNewFile *.js setlocal ft=javascript
  au BufEnter,BufRead,BufNewFile *.hbs setlocal ft=hbs
  au BufEnter,BufRead,BufNewFile *.ts setlocal ft=typescript
  au BufEnter,BufRead,BufNewFile *.json setlocal ft=json
  au BufEnter,BufRead,BufNewFile *.less setlocal ft=less

  augroup END
else
  set autoindent		" always set autoindenting on

endif " has("autocmd")

" set the map leader
" default is /
let mapleader = ","
let g:mapleader = ","

nmap <F10> :!ctags -R --c-kinds=+cdefgmnstuvx --c++-kinds=+cdefgmnstuvx --fields=+iamS --extra=+q --languages=+c++,c;cscope -bcqR <CR>
nmap <F12> :cscope add cscope.out<CR>:CCTreeLoadDB cscope.out<CR>

" move between windows
nmap <leader>wj <C-W>j
nmap <leader>wk <C-W>k
nmap <leader>wh <C-W>h
nmap <leader>wl <C-W>l
nmap <leader>w- <C-W>-
nmap <leader>w+ <C-W>+
nmap <leader>w= <C-W>=

" redraw
map <leader>l :redraw<CR>

" tab shortcut
nmap <leader>tnew :tabnew<CR>
nmap <leader>te :tabedit<CR>
nmap <leader>tc :tabclose<CR>
nmap <leader>tm :tabmove<CR>
nmap <leader>tn :tabNex<CR>
nmap <leader>tp :tabprevious<CR>
nmap <leader>tf :tabfirst<CR>
nmap <leader>tl :tablast<CR>

" open the error console
map <leader>ec :botright cope<CR>

" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h

nnoremap <leader><space> :noh<cr>

" strip trailing spaces
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
