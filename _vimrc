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

set history=50          " keep 50 lines of command line history
set showcmd             " display incomplete commands
" do not redraw, when running macros..
set lz
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

set wildignore+=*.o,*.tmp,*.bak,*.so,*.swp,*.zip

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
set statusline=%f%m%r\ %y\ %l:%c(%p%%)/%L%<\ %{&fileformat}\ %{&fileencoding}\ %{strftime(\"%a\ %d/%m\ %H:%M\")}

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
  autocmd FileType xml setlocal expandtab shiftwidth=4 softtabstop=4

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
  au BufEnter,BufRead,BufNewFile *.csproj setlocal ft=xml tabstop=2 shiftwidth=2 softtabstop=2
  au BufEnter,BufRead,BufNewFile *.targets setlocal ft=xml tabstop=2 shiftwidth=2 softtabstop=2
  au BufEnter,BufRead,bufNewFile *.xaml setlocal ft=xml

  augroup END
else
  set autoindent                " always set autoindenting on

endif " has("autocmd")

" set the map leader
" default is /
let mapleader = ","
let g:mapleader = ","

nmap <F10> :!ctags -R --c-kinds=+cdefgmnstuvx --c++-kinds=+cdefgmnstuvx --fields=+iamS --extra=+q --languages=+c++,c;cscope -bcqR <CR>
nmap <F12> :cscope add cscope.out<CR>:CCTreeLoadDB cscope.out<CR>

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

" open the error console
map <leader>ec :botright cope<CR>

" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h

" clear search highlighting
nnoremap <leader><space> :noh<cr>

" strip trailing spaces
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

nnoremap <leader>u :GundoToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""
" Beginning of setting of plugin python mode


" Override go-to.definition key shortcut to Ctrl-]
let g:pymode_rope_goto_definition_bind = "<C-]>"

" Turn on the run code script
let g:pymode_run = 1

" Override run current python file key shortcut to Ctrl-Shift-e
let g:pymode_run_bind = '<leader>pr'

" Turns on the documentation script
let g:pymode_doc = 1

" Override view python doc key shortcut to Ctrl-Shift-d
let g:pymode_doc_bind = '<leader>pd'

" If this option is set to 1, pymode will enable the following options for
" python buffers: >
"
" setlocal complete+=t
" setlocal formatoptions-=t
" if v:version > 702 && !&relativenumber
" setlocal number
" endif
" setlocal nowrap
" setlocal textwidth=79
" setlocal commentstring=#%s
" setlocal
" define=^\s*\\(def\\\\|class\\)
let g:pymode_options = 1


" Pymode supports PEP8-compatible python indent.
let g:pymode_indent = 1

" Fast and usual python folding in Vim.
let g:pymode_folding = 1

" Enable automatic virtualenv detection
let g:pymode_virtualenv = 1

" Turn on code checking
let g:pymode_lint = 1

" Check code when editing (on the fly)
let g:pymode_lint_on_fly = 1

" Extended autocompletion (rope could complete objects which have not been
" imported) from project
let g:pymode_rope_autoimport = 1

" Offer to unresolved import object after completion.
let g:pymode_rope_autoimport_import_after_complete = 1

" Keymap for rename method/function/class/variables under cursor
let g:pymode_rope_rename_bind = '<leader>rn'

" Organize imports sorts imports, too. It does that according to PEP8. Unused
" imports will be dropped.
let g:pymode_rope_organize_imports_bind = '<leader>oi'

" Extract method/variable from selected lines.
let g:pymode_rope_extract_method_bind = '<leader>rm'
let g:pymode_rope_extract_variable_bind = '<leader>rv'

" End of setting of plugin python mode
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
" Begin of setting of plugin Syntastic

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1

" End of setting of plugin Syntastic
""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""
" Begin of setting of plugin fugutive

if has("autocmd")
  autocmd BufReadPost fugitive://* set bufhidden=delete
endif " has("autocmd")

" End of setting of plugin fugutive
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
" Begin of setting of plugin rainbow_parentheses

" Always have RainbowParentheses on
if has("autocmd")
  au VimEnter * RainbowParenthesesToggle
  au Syntax * RainbowParenthesesLoadRound
  au Syntax * RainbowParenthesesLoadSquare
  au Syntax * RainbowParenthesesLoadBraces
endif " has("autocmd")

" End of setting of plugin rainbow_parentheses
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
" Begin of setting of plugin tsuquyomi
" show method signature. It slows down completion
let g:tsuquyomi_completion_detail = 1
autocmd FileType typescript setlocal completeopt+=menu,preview
" End of setting of plugin tsuquyomi
""""""""""""""""""""""""""""""""""""""

if has("gui_running")
  if has("gui_win32")
    set guifont=Lucida_Sans_Typewriter:h16:cANSI
    set guifontwide=NSimsun:h12
  endif
endif
