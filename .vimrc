" VUNDLE INIT
set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

Plugin 'christoomey/vim-tmux-navigator'
Plugin 'vim-autoformat/vim-autoformat'
" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required




" PERSONAL CONFIG

au BufNewFile,BufRead *.py set 
    \ tabstop=4
    \ softtabstop=4 
    \ shiftwidth=4 
    \ textwidth=79
    \ expandtab
    \ autoindent
    \ fileformat=unix
set nu
syntax on
"set tabstop=4
"set shiftwidth=4
"set expandtab
"filetype indent on

" JSON formatting settings
autocmd FileType json setlocal
  \ tabstop=2
  \ softtabstop=2
  \ shiftwidth=2
  \ expandtab
  \ autoindent
  \ formatoptions=tcq

" Enable syntax highlighting
syntax enable

" Auto-format JSON with jq if available
if executable('jq')
  autocmd FileType json nnoremap <leader>jq :%!jq '.'<CR>
endif

" Highlight JSON syntax errors
let g:vim_json_syntax_conceal = 0

" Auto-format JSON files on save
augroup json_format
  autocmd!
  " Only trigger for .json files 
  autocmd BufWritePre *.json call FormatJSON()
augroup END

" JSON formatting function using jq
function! FormatJSON()
  " Save cursor position
  let l:cursor_pos = getpos('.')
  
  " Format the entire buffer with jq
  %!jq '.'
  
  " Restore cursor position
  call setpos('.', l:cursor_pos)
endfunction
