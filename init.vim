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
let g:netrw_winsize=25
nnoremap <leader>fe :Lexplore<CR>
" }}}
" Snippet Injection {{{
" Example Below
" nnoremap <leader>html :-lread $HOME/.vim/.skeleton.html<CR>3jwf>a
" }}}
" Swap Files {{{
set swapfile
set dir=$HOME/tmp
" }}}
" File Extension Overrides {{{
augroup vimrc
  autocmd!
  autocmd BufNewFile,BufRead *.yml setlocal shiftwidth=2 tabstop=2 softtabstop=2
  autocmd BufNewFile,BufRead *.md setlocal shiftwidth=4 tabstop=4 softtabstop=4
  autocmd BufNewFile,BufRead *.js setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END
" }}}
" {{{ Plugins
call plug#begin(stdpath('data') . '/plugged')
Plug 'vimwiki/vimwiki'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
call plug#end()
" }}}
" {{{ VimWiki
let g:vimwiki_list = [{'path': '$WIKI_LOC', 'auto_tags': 1}]
command! Diary VimwikiDiaryIndex
augroup vimwikigroup
    autocmd!
    " automatically update links on read diary
    autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
augroup end
" }}}
" {{{ coc
" coc config file is ~/.config/nvim/coc-settings.json
" :CocCommand snippets.editSnippets to modify custom snippets
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-python',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json'
  \ ]
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

:verbose imap <tab>
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)


augroup cocgroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Run prettier on save
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" F2 runs rename
nmap <F2> :CocCommand document.renameCurrentWord<CR>
" }}}
" {{{ nerdcommenter
" <C-_> binds to Ctrl + / for some reason
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv
nmap <C-_> <Plug>NERDCommenterToggle

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code
" indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check if all selected lines are commented or
" not
let g:NERDToggleCheckAllLines = 1
" }}}
" {{{ gitgutter
" Disable gitgutter automatic mappings
let g:gitgutter_map_keys = 0

" Move to next (]) and previous ([) changes
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

" Preview changes
nmap <leader>hp <Plug>(GitGutterPreviewHunk)
" }}}
" vim: set foldmethod=marker foldlevel=0:
