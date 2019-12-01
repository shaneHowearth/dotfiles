"execute pathogen#infect()

filetype plugin indent on
filetype on
syntax on
set runtimepath^=~/.vim/bundle/nerdtree
set runtimepath^=~/.vim/bundle/vim-fugitive
set runtimepath^=~/.vim/bundle/vim-go
set runtimepath^=~/.vim/bundle/vim-rails
set runtimepath^=~/.vim/bundle/vim-ruby
set runtimepath^=~/.vim/bundle/semantic-highlight
set runtimepath+=~/.fzf
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set nocompatible
set number
set paste
set background=dark
"Make lowercase searches case-insensitive, mixed/upper-case case-sensitive
set ignorecase
set smartcase
set hlsearch
set incsearch
set clipboard=unnamedplus
set textwidth=80



"Show file name in window header
set title

"Enable ruler (bottom right corner)
set ruler

"Prevent lines breaking in the middle of words
set lbr


"set colorcolumn=50,72,80
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list
set laststatus=2

" Key maps
"Avoid q: typo that pops up the annoying command history box
nnoremap q: :q
nnoremap <silent> <f2> :NERDTreeFind<cr>
nnoremap <silent> <f3> :NERDTreeToggle<cr>
nnoremap <silent> <f4> :r ~/.vim/snippets/goTest<cr>
nnoremap <F5> :e!<cr>
" nnoremap <silent> <f6> :Gblame<cr>
nnoremap <F8>  :SemanticHighlightToggle<cr>
" set scroll lock per pane
nnoremap <f9> :set scb!<cr>
" toggle GBlame
function! s:ToggleBlame()
    if &l:filetype ==# 'fugitiveblame'
        close
    else
        Gblame
    endif
endfunction

nnoremap <silent> <f6> :call <SID>ToggleBlame()<CR>

if !exists("autocommands_loaded")
  let autocommands_loaded = 1
  autocmd BufWritePost *.go :GoMetaLinter
  autocmd BufWritePost *.go :GoBuild
  autocmd BufWritePost *.go :GoVet
  autocmd BufWritePost *.go :GoLint
endif
let g:go_metalinter_command = "golangci-lint run"
let g:go_fmt_command = "goimports"
let g:go_def_mode = "gopls"
let g:go_info_mode = "gopls"
"let g:go_highlight_function_parameters = true
let s:counter = 0
let s:timer = -1

"Ruby
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType eruby setlocal expandtab shiftwidth=2 tabstop=2

"Vim-ruby
let g:ruby_indent_access_modifier_style = 'normal'
let g:ruby_indent_assignment_style = 'variable'
let g:ruby_indent_block_style = 'do'

"Comments
noremap <silent> \ :Commentary<cr>
autocmd FileType ruby setlocal commentstring=#\ %s

"FZF
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

set mouse=a
set ttymouse=sgr
set balloonexpr=go#tool#DescribeBalloon()
set balloondelay=250
set ballooneval
set balloonevalterm
au BufEnter * if (exists("b:default")) | let b:current_colors=default \| execute "colorscheme " . b:colors_name | endif
au BufLeave * if (exists("b:desert")) | execute "colorscheme " . b:current_colors | endif
