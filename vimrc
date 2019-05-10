execute pathogen#infect()
filetype off
filetype plugin indent off
filetype plugin indent on
" Make the pretty
syntax on

" Installed bundles
set runtimepath^=~/.vim/bundle/ctrlp.vim
set runtimepath^=~/.vim/bundle/nerdtree
set runtimepath^=~/.vim/bundle/vim-javascript
set runtimepath^=~/.vim/bundle/vim-go
set runtimepath+=$GOROOT/misc/vim

set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set nocompatible
set number
set paste
set background=dark
""Prevent lines breaking in the middle of words
set lbr

"Make lowercase searches case-insensitive, mixed/upper-case case-sensitive
set ignorecase
set smartcase

"Show file name in window header
set title

"Enable ruler (bottom right corner)
set ruler
" Ctags key bind (No longer used, gopls is AWESOME)
"map <f12> :!start /min ctags -R .<cr>

" Show whitespace
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list
set laststatus=2

" Set F3 to toggle Nerdtree on/off
nmap <silent> <F3> :NERDTreeToggle<CR>

" On write run linter(s)
autocmd BufWritePost *.go :!golangci-lint run

" Go specific settings
let g:go_metalinter_command = "golangci-lint run"
let g:go_fmt_command = "goimports"
let g:go_def_mode = "gopls"

" Balloons
let s:counter = 0
let s:timer = -1
set mouse=a
set ttymouse=sgr
set balloonexpr=go#tool#DescribeBalloon()
set balloondelay=250
set ballooneval
set balloonevalterm
