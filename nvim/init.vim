" ============================================================================
" VIM CONFIGURATION
" ============================================================================

" GENERAL

set number
set relativenumber
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set nowrap
set scrolloff=10
set cursorline
set cursorcolumn
set incsearch
set ignorecase
set smartcase
set showcmd
set noshowmode
set showmatch
set hlsearch
set history=100
set wildmenu
set wildmode=list:longest
set synmaxcol=200
autocmd FileType markdown,text,gitcommit setlocal spell
set termguicolors
set splitbelow splitright
set autoindent
set mouse=a
set title
set inccommand=split
scriptencoding utf-8
" Clipboard integration
set clipboard=unnamedplus

" Completion menu behavior
set completeopt=noinsert,menuone,noselect

let mapleader = " "

" FILETYPES & SYNTAX

filetype on
filetype plugin on
filetype indent on
syntax on

" FILE SEARCH / WILDCARDS

set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" FZF

set rtp+=/opt/homebrew/opt/fzf

" PLUGINS

"call plug#begin('~/.vim/plugged')
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

Plug 'dense-analysis/ale'
Plug 'scrooloose/nerdtree'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'itchyny/lightline.vim'
"Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'autoload/onedark.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-sleuth'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/space-vim-dark'
Plug 'joshdick/onedark.vim'
" Code editing
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
" Code intelligence
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Git integration
Plug 'tpope/vim-fugitive'

call plug#end()

" NERDTREE

let NERDTreeIgnore = [
      \ '\.git$',
      \ '\.jpg$',
      \ '\.mp4$',
      \ '\.ogg$',
      \ '\.iso$',
      \ '\.pdf$',
      \ '\.pyc$',
      \ '\.odt$',
      \ '\.png$',
      \ '\.gif$',
      \ '\.db$'
      \ ]

let NERDTreeShowHidden = 1

nnoremap <leader>c :NERDTreeToggle<CR>
"
" KEY MAPPINGS

" Insert mode
inoremap <c-c> <Esc>

" Command-line mode
nnoremap <Space> :

" Save / Quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Search
nnoremap <leader>/ :nohlsearch<CR>

" Insert line breaks while preserving cursor position
nnoremap <leader>o :call InsertLineBreakBelow()<CR>
nnoremap <leader>O :call InsertLineBreakAbove()<CR>
" Buffer navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

" FUNCTIONS

function! InsertLineBreakBelow()
let l:save_cursor = getcurpos()
execute "normal! o<Esc>"
call setpos('.', [0, l:save_cursor, l:save_cursor, 0])
endfunction

function! InsertLineBreakAbove()
let l:save_cursor = getcurpos()
execute "normal! O<Esc>"
call setpos('.', [0, l:save_cursor + 1, l:save_cursor, 0])
endfunction

" FILETYPE-SPECIFIC SETTINGS

augroup filetype_settings
autocmd!
autocmd FileType vim setlocal foldmethod=marker
autocmd FileType html setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType python setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType markdown setlocal spell spelllang=en_us
augroup END

" CURSOR

augroup cursor_behavior
autocmd!
autocmd WinLeave * set nocursorline nocursorcolumn
autocmd WinEnter * if &filetype !=# 'help' | set cursorline cursorcolumn | endif
augroup END

" UNDO HISTORY

if exists('+undofile')
set undodir=~/.vim/backup
set undofile
set undoreload=10000
silent! call mkdir(expand('~/.vim/backup'), 'p')
endif

" GUI

if has("gui_running")
set guifont=JetBrains\Mono\Nerd\Font:h14
endif

set guioptions-=T
set guioptions-=L
set guioptions-=r
set guioptions-=m
set guioptions-=b

if has("termguicolors")
set termguicolors
endif

" Toggle menu, toolbar and scrollbars
nnoremap <F4> :if &guioptions =~# 'mTr'<Bar>
\set guioptions-=mTr<Bar>
\else<Bar>
\set guioptions+=mTr<Bar>
\endif<CR>

" STATUS LINE

set statusline=
set statusline+=\ %F\ %M\ %Y\ %R
set statusline+=%=
set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%
set laststatus=2

" THEME

colorscheme onedark

let g:material_theme_style = 'darker-cummunity'
let g:material_terminal_italics = 1

" COLORS

" Comments
"hi Comment cterm=italic gui=italic
"hi Comment guifg=#616161
"hi Comment guibg=#2c2f33

" Folded text
"hi Folded guibg=#2c2f33

" Main background
"hi Normal guibg=#2c2f33 guifg=#cdd6f4

" Empty areas
"hi NonText guibg=#2c2f33
"hi EndOfBuffer guibg=#2c2f33

" Line numbers
"hi LineNr guifg=#595959

"Cursor 
highlight CursorLine guibg=#282c34
highlight cursorcolumn guibg=#282c34
"set guicursor=a:block-Cursor/lCursor-blinkwait700-blinkon400-blinkoff250
highlight Cursor guifg=#cccccc guibg=#888888
"highlight lCursor guifg=#cccccc guibg=#cccccc


" LIGHTLINE

let g:lightline = {
\ 'colorscheme': 'onedark'
\ }

" AIRLINE

let g:airline_powerline_fonts = 1
let g:airline_theme = 'material'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'

" DEVICONS

let g:webdevicons_enable = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:DevIconsEnableFoldersOpenClose = 1

highlight lCursor guifg=#cccccc guibg=#cccccc


packloadall
