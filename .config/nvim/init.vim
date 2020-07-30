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
Plug 'fatih/vim-go'
" [[ Power Line ]]
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
" [[ Writting tools ]]
Plug 'neoclide/coc.nvim', {'branch': 'release'} " completion tool
" [[ Extra tools ]]
Plug 'vifm/vifm.vim'                            " file-manger inside nvim
Plug 'vimwiki/vimwiki'                          " own wiki
Plug 'ap/vim-css-color' 			" HEXA-color viewer

call plug#end()


" ----------------------------------------------------------------------------------------
" ==> General settings
" ----------------------------------------------------------------------------------------

set nu              " line numbers
set rnu             " relative numbers
set scrolloff=5

" ----------------------------------------------------------------------------------------
" ==> Some especial keys
" ----------------------------------------------------------------------------------------

:imap ii <Esc>

" ----------------------------------------------------------------------------------------
" ==> Lightline
" ----------------------------------------------------------------------------------------

let g:lightline = {
	\'colorscheme':'material',
	\'active':{
	\   'left':[[ 'mode','paste'],
	\	    [ 'gitbranch','cocstatus'],['filename','modifed']]
	\},
	\'component_function': {
	\  'costatus': 'coc#status',
	\  'gitbranch': 'FugitiveHead'
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
" ==> VimWiki
" ----------------------------------------------------------------------------------------

let g:vimwiki_list = [{'path':'~/vimwiki', 'syntax':'markdown', 'ext':'.md'}]

" ----------------------------------------------------------------------------------------
" ==> coc.nvim default settings
" ----------------------------------------------------------------------------------------

" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=no

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
