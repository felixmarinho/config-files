filetype on
filetype plugin on
filetype indent on
syntax on
let mapleader = " "
set nocompatible
set number
set cursorline
set cursorcolumn
set shiftwidth=4
set tabstop=2
set expandtab
set nobackup
set scrolloff=10
set nowrap
set incsearch
set ignorecase
set smartcase
set showcmd
set noshowmode
set showmatch
set hlsearch
set history=100
set relativenumber
set wildmenu
set lazyredraw
set encoding=utf-8
set synmaxcol=200 
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set termguicolors



" PLUzoGINS ---------------------------------------------------------------- {{{

call plug#begin('~/.vim/plugged')

Plug 'dense-analysis/ale'

Plug 'preservim/nerdtree'

Plug 'kaicataldo/material.vim'

Plug 'itchyny/lightline.vim'

Plug 'vim-airline/vim-airline'

Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-sleuth'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'


call plug#end()
" }}}


" MAPPINGS --------------------------------------------------------------- {{{

" Mappings code goes here.
" NERDTree specific mappings.
" Map the F3 key to toggle NERDTree open and close.
nnoremap <F3> :NERDTreeToggle<cr>

" Have nerdtree ignore certain files and directories.
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

" Press the space bar to type the : character in command mode.
nnoremap <space> :

" Type jj to exit insert mode quickly.
inoremap jj <Esc>

nnoremap <c-j> :m .+1<CR>==
nnoremap <c-k> :m .-2<CR>==
inoremap <c-j> <Esc>:m .+1<CR>==gi
inoremap <c-k> <Esc>:m .-2<CR>==gi
vnoremap <c-j> :m '>+1<CR>gv=gv
vnoremap <c-k> :m '<-2<CR>gv=gv

nnoremap <leader>w :w<CR>          " Save
nnoremap <leader>q :q<CR>          " Quit
nnoremap <leader>/ :nohlsearch<CR> " Clear search highlights
nnoremap <leader>r :source ~/.vimrc<CR>
nnoremap <leader>o :call InsertLineBreakBelow()<CR>
nnoremap <leader>O :call InsertLineBreakAbove()<CR>

"-' }}}

" Functions {{{


function! InsertLineBreakBelow()
        let l:save_cursor = getcurpos()
            execute "normal! o\<Esc>"
                call setpos('.', [0, l:save_cursor[1], l:save_cursor[2], 0])
endfunction

function! InsertLineBreakAbove()
        let l:save_cursor = getcurpos()
            execute "normal! O\<Esc>"
                call setpos('.', [0, l:save_cursor[1] + 1, l:save_cursor[2], 0])
endfunction


"}}}

" VIMSCRIPT -------------------------------------------------------------- {{{


augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 expandtab

if version >= 703
        set undodir=~/.vim/backup
            set undofile
                set undoreload=10000
                    silent! call mkdir(expand('~/.vim/backup'), 'p')
endif


augroup cursor_off
        autocmd!
         autocmd WinLeave * set nocursorline nocursorcolumn
        autocmd WinEnter * if &filetype != 'help' | set cursorline cursorcolumn | endif
augroup END


    " Syntax: <font_name>\ <weight>\ <size>
if has("gui_running")
    set guifont=MesloLGS\ NF:h12
endif
    set guioptions-=T
    set guioptions-=L
    set guioptions-=r
    set guioptions-=m
    set guioptions-=b

    if has("termguicolors")
            set termguicolors
    endif

    autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
    autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 expandtab
    autocmd FileType markdown setlocal spell spelllang=en_us

    " Map the F4 key to toggle the menu, toolbar, and scroll bar.
    " <Bar> is the pipe character.
    " <CR> is the enter key.
" Map the F4 key to toggle the menu, toolbar, and scroll bar.
    " <Bar> is the pipe character.
    " <CR> is the enter key.
    nnoremap <F4> :if &guioptions=~#'mTr'<Bar>
        \set guioptions-=mTr<Bar>
        \else<Bar>
        \set guioptions+=mTr<Bar>
        \endif<CR>

" }}}



" Status bar code goes here.

" }}}

" STATUS LINE ------------------------------------------------------------ {{{

" Clear status line when vimrc is reloaded.
    set statusline=

    " Status line left side.
    set statusline+=\ %F\ %M\ %Y\ %R

    " Use a divider to separate the left side from the right side.
    set statusline+=%=

    " Status line right side.
    set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

    " Show the status on the second to last line.
    set laststatus=2

    " }}}

let g:lightline = { 'colorscheme': 'wombat' }

let g:airline_powerline_fonts = 1 " Use MesloLGS NF glyphs
let g:airline_theme = 'material'
set laststatus=2 " Always show statusline

let g:material_terminal_italics = 1
let g:material_theme_style = 'darker-community'
colorscheme material

let g:webdevicons_enable = 1
let g:webdevicons_enable_airline_statusline = 1

let NERDTreeShowHidden=1
