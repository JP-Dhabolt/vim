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
set number                        " show line numbers
set showcmd                       " show command in bottom bar
set cursorline                    " highlight current line
filetype indent on                " load filetype-specific indent files
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
" vim: set foldmethod=marker foldlevel=0:
