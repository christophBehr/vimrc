set nocompatible              " required
filetype off                  " required

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avpreservevimstandard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

"Syntax Highlight
Plug 'junegunn/seoul256.vim'

"strg+n for nerdtree open and close
Plug 'preservim/nerdtree'

"gcc for comment out a line or gc to comment out a section vismod 
Plug 'tpope/vim-commentary'

"View and search LSP symbols and tags
Plug 'liuchengxu/vista.vim'

"Indentation PEP8
Plug 'Vimjas/vim-python-pep8-indent'

"Linting and Fixing
Plug 'dense-analysis/ale'

"Python specific objects
Plug 'jeetsukumaran/vim-pythonsense'

"Insert closing quotes and parenthesis
Plug 'jiangmiao/auto-pairs'

call plug#end()

"Add folding via space
au BufNewFile,BufRead *.py\
	set foldmethod=indent
nnoremap <space> za

"Settings for Ale Linter
let g:ale_linters = {
      \   'python': ['flake8', 'pylint'],
      \   'ruby': ['standardrb', 'rubocop'],
      \   'javascript': ['eslint'],
      \}
"Settings for Ale Fixer
let g:ale_fixers = {
      \    'python': ['yapf'],
      \}
nmap <F10> :ALEFix<CR>
let g:ale_fix_on_save = 1

"Auto fix and format on safe
function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '✨ all good ✨' : printf(
        \   '😞 %dW %dE',
        \   all_non_errors,
        \   all_errors
        \)
endfunction

set statusline=
set statusline+=%m
set statusline+=\ %f
set statusline+=%=
set statusline+=\ %{LinterStatus()}

"Turn on syntax highlighting
syntax on
filetype on

"Show line numbers
set number

"Activate NERDTree with ctrl+n
map <C-n> :NERDTreeToggle<CR>

"Seoul256 dark
"	Range:	233(darkest) ~ 239 (lightest)
"	Default: 237
let g:seoul256_background = 233
colo seoul256


