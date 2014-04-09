set nocompatible
set background=dark

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
filetype on
syntax on
set mouse=a
set showmode
set cursorline
set showmatch
set incsearch
set hlsearch

if has('gui_running')
    :set guioptions=
endif

hi cursorline guibg=#333333
hi CursorColumn guibg=#333333

set nowrap
set autoindent
set shiftwidth=4
set expandtab
set tabstop=4
set softtabstop=4 

let mapleader=","
let g:pyflakes_use_quickfix = 0
let g:pep8_map='<leader>8'

set history=1000

map <Leader>ue :UltiSnipsEdit<cr>
map <Leader>co :TComment<CR>
map <Leader>nn :NERDTreeToggle<cr>
map <Leader>nf :NERDTreeFind<cr>

nmap <leader>a <Esc>:Ack!

map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

nnoremap ' `
nnoremap ` '

set noerrorbells
set visualbell
set t_vb=

colorscheme vividchalk

set wildmode=list:longest

set foldmethod=indent
set foldlevel=99

au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

:set wildignore+=virtualenv,*.pyc


if has('win32') || has('win64')
    set clipboard=unnamed
    let g:ackprg="ack -H --nocolor --nogroup --column"
else
    let g:ackprg="ack-grep -H --nocolor --nogroup --column"
endif

function! InitializeDirectories()
    let separator = "."
    let parent = $HOME
    let prefix = '.vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

    for [dirname, settingname] in items(dir_list)
        let directory = parent . '/' . prefix . dirname . "/"
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction
call InitializeDirectories()
