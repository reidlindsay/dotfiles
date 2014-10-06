set nocompatible                " Ignore vi compatibility options

set hidden                      " Allow unwritten changes when opening new file

set nowrap                      " Don't wrap long lines
set tabstop=4                   " Tab is four spaces
set backspace=indent,eol,start  " Allow backspace in insert mode
set autoindent                  " Always enable auto indent
set copyindent                  " Copy previous indentation on auto indent
set shiftwidth=4                " Number of spaces per indent
set shiftround                  " Use multiple of shiftwidth with > and <
set showmatch                   " Show matching parenthesis
set ignorecase                  " Ignore case when searching
set smartcase                   " Ignore case when lowercase, otherwise use case
set smarttab                    " Insert tabs according to shiftwidth
set expandtab                   " Expand tabs to spaces
set hlsearch                    " Highlight search terms
set incsearch                   " Show search match as you type

set history=1000                " Remember commands and search history
set undolevels=1000             " Remember many levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*~
set title                       " Change terminal title
set novisualbell                " Don't flash screen
set noerrorbells                " Don't beep

set nobackup                    " Don't write backup files
set noswapfile                  " Don't page to disk
set nowb                        " Don't use write buffer

set pastetoggle=<F2>            " Use <F2> to switch to paste mode

filetype plugin on              " Auto detect file type
filetype indent on
"set foldmethod=indent           " Code folding based on indentation

set autoread                    " Auto reload if file changes externally
set showcmd                     " Show current command in status bar

set lazyredraw                  " Enable lazy screen redraw
set ruler                       " Enable ruler (line/column number bottom right)
set so=7                        " Set scroll off to 8 lines from top/bottom

let python_highlight_all=1
syntax enable                   " Enable syntax highlighting
set t_Co=256                    " Enable 256 colour mode
colorscheme wombat256mod
set background=dark
set encoding=utf8               " Default to UTF8 encoding
set ffs=unix,dos,mac

" Highlight line at column 80 then solid past column 120
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn="80,".join(range(120,999),",")

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
set viminfo^=%

" Remove trailing whitespace on Python source files
func! RemoveTrailingWhitespace()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call RemoveTrailingWhitespace()


" vimrc file for following the coding standards specified in PEP 7 & 8.
"
" To use this file, source it in your own personal .vimrc file (``source
" <filename>``) or, if you don't have a .vimrc file, you can just symlink to it
" (``ln -s <this file> ~/.vimrc``).  All options are protected by autocmds
" (read below for an explanation of the command) so blind sourcing of this file
" is safe and will not affect your settings for non-Python or non-C files.
"
"
" All setting are protected by 'au' ('autocmd') statements.  Only files ending
" in .py or .pyw will trigger the Python settings while files ending in *.c or
" *.h will trigger the C settings.  This makes the file "safe" in terms of only
" adjusting settings for Python and C files.
"
" Only basic settings needed to enforce the style guidelines are set.
" Some suggested options are listed but commented out at the end of this file.

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Turn off settings in 'formatoptions' relating to comment formatting.
" - c : do not automatically insert the comment leader when wrapping based on
"    'textwidth'
" - o : do not insert the comment leader when using 'o' or 'O' from command mode
" - r : do not insert the comment leader when hitting <Enter> in insert mode
" Python: not needed
" C: prevents insertion of '*' at the beginning of every line in a comment
au BufRead,BufNewFile *.c,*.h set formatoptions-=c formatoptions-=o formatoptions-=r

" Use UNIX (\n) line endings.
" Only used for new files so as to not force existing files to change their
" line endings.
" Python: yes
" C: yes
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

