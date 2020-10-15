" ----------------------------------------------------------------------------------------
" ==> Plugins requirements
" ----------------------------------------------------------------------------------------

set nocompatible 		" be iMproved
filetype plugin indent on
filetype plugin on
filetype off
syntax on

" ----------------------------------------------------------------------------------------
" => Vundle For Managing Plugins
" ----------------------------------------------------------------------------------------

call plug#begin('~/.local/share/nvim/plugged')
" [[ Golang ]]
Plug 'fatih/vim-go', {'tag': 'v1.24'}

" [[ Aesthetics ]]
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'dracula/vim', {'as':'dracula'}
Plug 'ryanoasis/vim-devicons'

" [[ Writting tools ]]
Plug 'neoclide/coc.nvim', {'branch': 'release'} " completion tool
Plug 'preservim/nerdcommenter' 

" [[ Extra tools ]]
Plug 'vimwiki/vimwiki'                          " own wiki
Plug 'ap/vim-css-color' 		            	" HEX-color viewer
Plug 'NLKNguyen/papercolor-theme'

" [[ File visualizer ]]
Plug 'vifm/vifm.vim'                            " file-manger inside nvim
Plug 'preservim/nerdtree/'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'

call plug#end()

" ----------------------------------------------------------------------------------------
" ==> General settings
" ----------------------------------------------------------------------------------------

set number          " line numbers
set relativenumber  " relative numbers
set scrolloff=5
set tabstop=4       " tab spaces
set expandtab       " 
set shiftwidth=4    " indent spaces
set splitbelow splitright
set encoding=UTF-8
set mouse=nvi
set updatetime=100

let g:deoplete#enable_at_startup = 1

highlight CursorLineNR guifg=#cc99ff ctermfg=2
highlight LineNR guifg=#cc99ff
hi LineNr       term=bold cterm=bold ctermfg=2 guifg=Grey guibg=Grey90

" ----------------------------------------------------------------------------------------
" ==> Some fancy settings
" ----------------------------------------------------------------------------------------

set termguicolors

let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.dark': {
  \       'override' : {
  \         'color00' : ['#263238', ''],
  \         'linenumber_bg' : ['#263238', ''],
  \         'linenumber_fg' : ['#ffcb6b',''],
  \         'cursorlinenr_bg' : ['#263238',''],
  \         'cursorlinenr_fg' : ['#ffcb6b','']
  \       }
  \     }
  \   }
  \ }
set background=dark
" colorscheme PaperColor
colorscheme dracula


highlight Comment gui=bold gui=italic

" ----------------------------------------------------------------------------------------
" ==> Some especial keys
" ----------------------------------------------------------------------------------------

:imap ii <Esc>
 
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" ----------------------------------------------------------------------------------------
" ==> Vim-go
" ----------------------------------------------------------------------------------------

let g:go_fold_enable = ['block', 'import', 'varconst', 'package_comment']


let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1


:map <F5> :w<CR>:GoRun<CR>

" ----------------------------------------------------------------------------------------
" ==> Lightline
" ----------------------------------------------------------------------------------------

let g:lightline = {
	\'colorscheme':'dracula',
	\'active':{
	\   'left':[[ 'mode','paste'],
	\	        [ 'gitbranch','cocstatus'], ['relativepath'],['modified']],
    \   'right': [ [ 'syntastic', 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
	\},
	\'component_function': {
	\   'costatus': 'coc#status',
	\   'gitbranch': 'FugitiveHead',
    \   'syntastic': 'SyntasticStatuslineFlag',
	\},
	\}

" ----------------------------------------------------------------------------------------
" ==> VimVifm
" ----------------------------------------------------------------------------------------

let mapleader=','
map <leader>vv :Vifm<CR>
map <leader>vs :VsplitVifm<CR>
map <leader>sp :SplitVifm<CR>
map <leader>dv :DiffVifm<CR>
map <leader>tv :TabVifm<CR>

" ----------------------------------------------------------------------------------------
" ==> NERDTree
" ----------------------------------------------------------------------------------------

map <C-b> :NERDTreeToggle<CR>

" ----------------------------------------------------------------------------------------
" ==> NERDCommenter
" ----------------------------------------------------------------------------------------

let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
"let g:NERDCustomDelimiters = { 'go': { 'left': '/**','right': '*/' } }

map <space>cc <plug>NERDCommenterToggle
nmap <space>ca <plug>NERDCommenterAppend

" ----------------------------------------------------------------------------------------
" ==> GitGutter
" ----------------------------------------------------------------------------------------

highlight GitGutterAdd    guifg=#05a167 ctermfg=green
highlight GitGutterChange guifg=#fff8b7 ctermfg=yellow
highlight GitGutterDelete guifg=#ef4135 ctermfg=red

set signcolumn=auto

let g:gitgutter_enabled = 1
let g:gitgutter_signs = 1
let g:gitgutter_map_keys = 0

let g:gitgutter_git_executable ="/usr/bin/git"

" ----------------------------------------------------------------------------------------
" ==> VimWiki
" ----------------------------------------------------------------------------------------

"let g:vimwiki_list = [{'path':'~/vimwiki', 'syntax':'markdown', 'ext':'.md'}]
let g:vimwiki_list = [{'path':'~/vimwiki', 'syntax':'default', 'ext':'.wiki'}]

map <leader>ww :VimwikiIndex<CR>

let g:vimwiki_hl_headers = 1
highlight VimwikiHeader1 guifg=#ef4135
highlight VimwikiHeader2 guifg=#05a167
highlight VimwikiHeader3 guifg=#1975d1
highlight VimwikiHeader4 guifg=#cc99ff
highlight VimwikiHeader5 guifg=#93ffff
highlight VimwikiHeader6 guifg=#fff8b7

" ----------------------------------------------------------------------------------------
" ==> coc.nvim default settings
" ----------------------------------------------------------------------------------------

"" RUN :CocInstall coc-snippets
let g:coc_global_extensions = [
    \ 'coc-pairs',
    \]

command! -nargs=0 Prettier :CocCommand prettier.formatFile

" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
" set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
" set signcolumn=no

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
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

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'
