" Display
syntax on
set number
set hlsearch
set statusline=%F\ %=%Y\ (%l,%c)
set laststatus=2
set ruler

" Navigation and File Management
set path+=**
set wildmenu

" Tabbing
set softtabstop=2
set expandtab
set shiftwidth=2
set autoindent

" remove syntax highlighting and set files to not modifiable for compile dbt sql
au BufNewFile,BufRead */target/*.sql set noma ft=text

