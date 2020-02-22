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
" Included Diff Function {{{
" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
" }}}
set modelines=1
" vim:foldmethod=marker:foldlevel=0
