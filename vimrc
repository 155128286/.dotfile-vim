" .vimrc
" Author: Mark Nichols
" largely copied from Steve Losh (stevelosh.com)
" addition bits borrowed from https://github.com/nvie/vimrc/blob/master/vimrc
" further bits from http://vimcasts.org
" also, https://github.com/lukaszkorecki/DOtFiles
" and from: http://www.drbunsen.org/text-triumvirate.html
"
" ---------------------------------------------------------------------------------
" use Vim settings rather than vi settings (must be first)
" ---------------------------------------------------------------------------------
set nocompatible

" ---------------------------------------------------------------------------------
" setup Pathogen to manage plugins
" ---------------------------------------------------------------------------------
filetype on                   " best to have it on before turning it off
filetype off                  " force reloading after pathogen loaded
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on     " enable plugins, detection and indenting in one step

" ---------------------------------------------------------------------------------
" change mapleader from \ to ,
" ---------------------------------------------------------------------------------
let mapleader=','

" ---------------------------------------------------------------------------------
" basic options
" ---------------------------------------------------------------------------------
set encoding=utf-8
set modelines=0
set tabstop=4                   " a tab stop is 4 spaces
set shiftwidth=4                " number of spaces to use for autoindenting
set softtabstop=4               " when <BS>, pretend a tab is removed, even if spaces
set expandtab                   " expand tabs to spaces (overloadable by file type later)
set scrolloff=3                 " keep 3 lines off the edges of the screen when scrolling
set autoindent                  " always set autoindenting on
set showmode                    " always show what mode we're in
set showcmd                     " display info about current command in status lin
set hidden
set wildmenu                    " navigate <Left> & <Right> through completion lists
set wildmode=list:longest       " allows expansion of wildmenu
set visualbell                  " visual bell
set cursorline                  " highlight the line containing the cursor
set ttyfast                     " improves redrawing
set ruler                       " show row,col in status area
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set history=1000
"if version >= 730
"    set undodir=~/.tmp/undodir      " set undo file location
"    set undofile
"endif

" ---------------------------------------------------------------------------------
" backups
" ---------------------------------------------------------------------------------
set backup
set noswapfile

set undodir=~/.tmp/undo/       " undo files
set backupdir=~/.tmp/backup/   " backups
set directory=~/.tmp/swap/     " swap files

" make those directories automatically if they don't already exist
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

set ffs=unix,mac,dos            " default file types
set spell                       " turn spell check on
set autoread                    " automatically updates file when editted outside vim

" use relative (offset) line number only in active window split
if v:version >= 703
    set relativenumber
    :au WinEnter * :setlocal relativenumber
    :au WinLeave * :setlocal nonumber
else
    set number
    :au WinEnter * :setlocal number
    :au WinLeave * :setlocal nonumber
endif


" automatically resize vertical splits to maximize current split
":au WinEnter * :set winfixheight
":au WinEnter * :wincmd =

" ---------------------------------------------------------------------------------
" Editor layout
" ---------------------------------------------------------------------------------
set termencoding=utf-8
set encoding=utf-8
set lazyredraw                  " don't update the display while executing macros
set laststatus=2                " tell Vim to always put a status line in,
                                "   even if there is only one window
set cmdheight=2                 " ues a status bar that is two rows high

" ---------------------------------------------------------------------------------
" Set up the solarized color scheme - not as easy as it ought to be
" need `syntax on` for colors to work properly
" ---------------------------------------------------------------------------------
syntax on
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans = 1
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
colorscheme solarized


" set options based on whether we're in the GUI or terminal
" Mostly we're hiding the toolbar in MacVim

if has("gui_running")
    set guioptions=egmrt
    set guioptions-=T
    set showtabline=2           " always show tabbar in gui
endif

" Fonts
set gfn=Courier:h15
set shell=/bin/zsh

" ---------------------------------------------------------------------------------
" moving and searching
" ---------------------------------------------------------------------------------
nnoremap / /\v
vnoremap / /\v
set ignorecase                  " ignore case while searching
set smartcase                   " ignore case if search string is all lower case
                                "    case-sensitive otherwise
set gdefault                    " search/replace globally (on a line) by default
set incsearch                   " allow search matches as you type
set showmatch                   " set show matching parens
set hlsearch                    " highlight search terms
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" ---------------------------------------------------------------------------------
" working with OS X Clipboard
" ---------------------------------------------------------------------------------
" Yank text to the OS X clipboard
noremap <leader>y "*y
noremap <leader>yy "*Y

" Preserve indentation while pasting text from the OS X clipboard
noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>

" ---------------------------------------------------------------------------------
" handle long lines
" ---------------------------------------------------------------------------------
set wrap
set textwidth=120
set formatoptions=qrn1
if version >= 703
    set colorcolumn=85
endif

" command to Wrap long lines. Sets wrap, linebreak, and nolist
command! -nargs=* Wrap set wrap linebreak nolist

" show invisible characters ala TextMate
set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮

" ---------------------------------------------------------------------------------
" add TextMate indentation key mappings
" from vimcasts,org #5
" altered to be non-recursive
" ---------------------------------------------------------------------------------
nnoremap <D-[> <<
nnoremap <D-]> >>
nnoremap <D-[> <gv
nnoremap <d-]> >gv

" remap the help key
" inoremap <F1> <ESC>
" nnoremap <F1> <ESC>
" vnoremap <F1> <ESC>
"
" ---------------------------------------------------------------------------------
" remap ; to :, save a keystroke
" ---------------------------------------------------------------------------------
nnoremap ; :

" ---------------------------------------------------------------------------------
" save on losing focus
" ---------------------------------------------------------------------------------
au FocusLost * :wa

" ---------------------------------------------------------------------------------
" map jj to ESC for quicker escaping
" ---------------------------------------------------------------------------------
inoremap jj <ESC>

" ---------------------------------------------------------------------------------
" stuff for working with split windows
" ---------------------------------------------------------------------------------
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" ---------------------------------------------------------------------------------
" stuff for working with tabs
" ---------------------------------------------------------------------------------
nnoremap <C-l> gt
nnoremap <C-h> gT

" ---------------------------------------------------------------------------------
" from vimcasts.org #24
" automatically source .vimrc when it is saved
" ---------------------------------------------------------------------------------
if has("autocmd")
   autocmd! bufwritepost .vimrc source $MYVIMRC
endif

" ---------------------------------------------------------------------------------
" from vimcasts.org #24
" shortcut to edit .vimrc file -- opens file in new tab
" ---------------------------------------------------------------------------------
nnoremap <leader>v :tabedit $MYVIMRC<CR>

" ---------------------------------------------------------------------------------
" control whitespace preferences based on filetype, uses autocmd
" ---------------------------------------------------------------------------------
if has("autocmd")
    " enable file type detection
    filetype on

    " syntax of these languages is fussy over tabs Vs spaces
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

    " treat .rss files as XML
    autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml

    " markdown filetype
    autocmd BufNewFile,BufRead *.md, *.mkd, *.markdown setfiletype markdown
    autocmd BufNewFile,BufRead *.md, *.mkd, *.markdown set spell

    " non ruby files related to Ruby
    autocmd BufNewFile,BufRead Gemfile,Gemfile.lock,Guardfile setfiletype ruby

    autocmd BufNewFile,BufRead Rakefile setfiletype rake
    autocmd BufNewFile,BufRead Rakefile set syntax=ruby

    autocmd BufNewFile,BufRead *.rake setfiletype rake
    autocmd BufNewFile,BufRead *.rake set syntax=ruby

    " Python specific settings
    let NERDTreeIgnore = ['\.pyc$', '\~$', '\.rbc$']
    autocmd BufNewFile,BufRead *.py set ts=2 sts=2 sw=2 expandtab
endif

" ---------------------------------------------------------------------------------
" stuff for bundles
" ---------------------------------------------------------------------------------
" NERDTree
" toggle NERDTRee on or off via F2
noremap <F2> :NERDTreeToggle<CR>
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeWinSize=33

" NERDCommenter
" <leader>c
"
" Gundo
nnoremap <F5> :GundoToggle<CR>

" Powerline
"let g:Powerline_theme = 'solarized256'

" ---------------------------------------------------------------------------------
"  finis
" ---------------------------------------------------------------------------------

" set indent size for ruby
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
" enable matchit
runtime macros/matchit.vim
" indent guides settings
let g:indent_guides_guide_size=1

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

vnoremap // y/\V<C-R>"<CR>
