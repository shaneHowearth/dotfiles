"execute pathogen#infect()

filetype plugin indent on
filetype on
syntax on
set runtimepath^=~/.vim/bundle/auto-pairs
set runtimepath^=~/.vim/bundle/junegunn/fzf
set runtimepath^=~/.vim/bundle/junegunn/fzf.vim
set runtimepath^=~/.vim/bundle/nerdtree
set runtimepath^=~/.vim/bundle/semantic-highlight
set runtimepath^=~/.vim/bundle/tsuquyomi
set runtimepath^=~/.vim/bundle/vim-fugitive
set runtimepath^=~/.vim/bundle/vim-go
set runtimepath^=~/.vim/bundle/vimproc.vim
set runtimepath^=~/.vim/bundle/vim-rails
set runtimepath^=~/.vim/bundle/vim-tsx
set runtimepath^=~/.vim/bundle/vim-abolish
set runtimepath+=~/.fzf
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set nocompatible
set number
" set paste
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

"Search down into sub folders
"Provides tab-completion for all file related tasks
set path+=**

"Display all matching files when we tab complete
set wildmenu

"set colorcolumn=50,72,80
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list
set laststatus=2

" toggle GBlame
function! s:ToggleBlame()
    if &l:filetype ==# 'fugitiveblame'
        close
    else
        Gblame
    endif
endfunction

" Key maps
"Avoid q: typo that pops up the annoying command history box
nnoremap q: :q
nnoremap <silent> \ :Commentary<cr>
nnoremap <F2> :setlocal spell! spelllang=en_us<cr>
nnoremap <silent> <F3> :NERDTreeToggle<cr>
nnoremap <silent> <F5> :GoCoverageToggle<cr>
nnoremap <silent> <F6> :call <sid>ToggleBlame()<cr>
nnoremap <silent> <F7> :-1r ~/.vim/snippets/goErr<cr>wf{a
nnoremap <silent> <F8> :-1r ~/.vim/snippets/goTest<cr>1jwf{a
nnoremap <silent> <F9> :-1r ~/.vim/snippets/index.html<cr>6jwf>a
" set scroll lock per pane
" nnoremap <F9> :set scb!<cr>


if !exists("autocommands_loaded")
  let autocommands_loaded = 1
  let g:go_metalinter_autosave=1
  autocmd BufWritePost *.go :GoBuild
endif

let g:go_metalinter_command='golangci-lint'
let g:go_fmt_command = "goimports"
let g:go_def_mode = "gopls"
let g:go_info_mode = "gopls"
"let g:go_highlight_function_parameters = true
let s:counter = 0
let s:timer = -1

"Comments */
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

" Use Ale for javascript linting
let g:ale_linters = {
            \   'javascript': ['eslint'],
            \   'typescript': ['tsserver', 'tslint'],
            \   'vue': ['eslint']
            \}

set mouse=a
set ttymouse=sgr
set balloonexpr=go#tool#DescribeBalloon()
set balloondelay=250
set ballooneval
set balloonevalterm
"au BufLeave * if (exists("b:desert")) | execute "colorscheme " . b:current_colors | endif
