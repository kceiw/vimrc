" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" For pathogen.vim: auto load all plugins in .vim/bundle
execute pathogen#infect()

" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc

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

  autocmd QuickFixCmdPost *grep* cwindow

  augroup END
else
  set autoindent                " always set autoindenting on

endif " has("autocmd")

" set the map leader
" default is /
let mapleader = ","
let g:mapleader = ","

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
			\ 'cs': ['OmniSharp'],
                        \ 'py': ['pylint', 'flake8']
			\}

" End of setting of ALE
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
" Begin of setting of plugin tsuquyomi
" show method signature. It slows down completion
let g:tsuquyomi_completion_detail = 1
autocmd FileType typescript setlocal completeopt+=menu,preview
" End of setting of plugin tsuquyomi
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
" Begin of setting of plugin NERDTree
" Show NERT tree at the left
" Quickfix window seems to open below the second window.
" If NERDTREE is at the right. Most likely Quickfix window will show below it.
let g:NERDTreeWinPos = 'left'
let NERDTreeShowHidden = 1
map <C-n> :NERDTreeToggle<CR>
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
" Begin of omnisharp-vim
" Looks like stdio doesn't work properly yet.
"
let g:OmniSharp_server_stdio = 0
let g:OmniSharp_selector_ui = 'fzf'

" only highlight documents when entering/leaving a buffer
" 3 means to highlight whenver text changes.
let g:OmniSharp_highlight_types = 2

" Set the type lookup function to use the preview window instead of echoing it¬
let g:OmniSharp_typeLookupInPreview = 1

" Timeout in seconds to wait for a response from the server¬
let g:OmniSharp_timeout = 5

" Enable snippet completion
let g:OmniSharp_want_snippet=1

" Don't autoselect first omnicomplete option, show options even if there is only¬
" one (so the preview documentation is accessible). Remove 'preview' if you¬
" don't want to see any documentation whatsoever.¬
set completeopt+=longest,menuone,preview

" Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

augroup omnisharp_commands
    autocmd!

    " Show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

    " Navigate up and down by method/property/field
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>

    " Find all code errors/warnings for the current solution and populate the quickfix window
    autocmd FileType cs nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>
    autocmd FileType cs nnoremap <Leader>cf :OmniSharpCodeFormat<CR>

    " Rename with dialog
    autocmd FileType cs nnoremap <Leader>nm :OmniSharpRename<CR>
augroup END

" End of omnisharp-vim
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
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" End of ack
""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""
" Begin of YouCompleteMe
let g:ycm_filetype_whitelist = {
        \ 'python': 1,
        \ 'cs': 1,
        \ 'javascript': 1,
        \ 'typescript': 1
        \ }
" End of YouCompleteMe
""""""""""""""""""""""""""""""""""""""


" Put these lines at the very end of your vimrc file.

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
