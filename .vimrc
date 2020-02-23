" Initial Vim example
" source $VIMRUNTIME/vimrc_example.vim
" Leader Shortcuts {{{
let mapleader=","
" save session
nnoremap <leader>s :mksession<CR>
" }}}
" Tab settings {{{
set tabstop=4                     " number of visual spaces per TAB
set softtabstop=4                 " number of spaces in tab when editing
set expandtab                     " tabs are spaces
" }}}
" UI Layout {{{
syntax enable                     " enable syntax
set nocompatible                  " Do not try to be vi
set number                        " show line numbers
set showcmd                       " show command in bottom bar
set cursorline                    " highlight current line
filetype plugin on                " Enable plugins
filetype indent on                " load filetype-specific indent files
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**
set wildmenu                      " visual autocomplete for command menu
set lazyredraw                    " redraw only when needed
set showmatch                     " highlight matching [{()}]
" }}}
" Search settings {{{
set incsearch                     " search as characters are entered
set hlsearch                      " highlights matches
" Turn off search highlighting by pressing ,<space>
nnoremap <leader><space> :nohlsearch<CR>
" }}}
" Folding {{{
set foldenable                    " enable folding
set foldlevelstart=10             " open most folds by default
set foldnestmax=10                " 10 nested fold max
set foldmethod=indent             " fold based on indent level
" space open/closes folds
nnoremap <space> za
" }}}
" Modelines {{{
set modeline
set modelines=1
" }}}
" Tagging {{{
" Create the `tags` file
command! MakeTags !ctags -R .
" }}}
" File Browsing {{{
let g:netrw_banner=0              " disable annoying banner
let g:netrw_browse_split=4        " open in prior window
let g:netrw_altv=1                " opens splits to the right
let g:netrw_liststyle=3           " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
" }}}
" Snippet Injection {{{
" Example Below
" nnoremap <leader>html :-lread $HOME/.vim/.skeleton.html<CR>3jwf>a
" }}}
" Swap Files {{{
set swapfile
set dir=$HOME/tmp
" }}}
" vim: set foldmethod=marker foldlevel=0:
