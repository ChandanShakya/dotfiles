syntax on                   " Turn Syntax highlighting On
filetype plugin on

set mouse=a
set nocompatible
set t_Co=256
set encoding=utf-8
set relativenumber          " Turn relative line numbering On
set number                  " Turn line number on
set visualbell              " Use Visual Bell instead of audible bell
set t_vb=                   " Set no visual bell
set noerrorbells            " Turn Error Bells off
set noshowmode              " Show no mode below status bar
set tabstop=4               " Put 4 spaces = 1 tab
set softtabstop=4           " While editing, count 4 spaces = 1 tab
set shiftwidth=4            " While indenting, indent 4 spaces inside
set expandtab               " Allow individual space navigation in tabs
set smartindent             " Perform smart indent
set showmatch               " Highlight matching brackets
set nohlsearch              " After searching, remove the highlight
set smartcase               " Case sensitive highlighting while search
set nowrap                  " Do not wrap text when reaching max window length
set noswapfile              " Creates no swap file
set nobackup                " Do not create a backup file before overwriting
set incsearch               " Highilights the words as you type

highlight Visual cterm=bold ctermbg=Blue ctermfg=NONE

call plug#begin('~/.vim/plugged')   " Call the plugins from plugin directory

Plug 'tpope/vim-fugitive'
Plug 'ap/vim-css-color'
Plug 'preservim/nerdtree'
Plug 'vimwiki/vimwiki'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()                     " End the plugin call

colorscheme zellner                 " Set Colorscheme to slate
set background=dark                 " Set background to dark

let mapleader = " "                 " Set the leader key to space
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <silent> <leader>= :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>
nnoremap <silent> <leader>. :resize +5<CR>
nnoremap <silent> <leader>, :resize -5<CR>
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <C-n> :tabnew<CR>
nnoremap <C-q> :tabclose<CR>

" Start NERDTree when Vim is started without file arguments.
let g:python3_host_prog = '/usr/bin/python3'
let g:vimwiki_list_ignore_newline = 0
let g:vimwiki_list = [{'auto_diary_index': 1}]
"let NERDTreeShowHidden=0
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

"autocmd BufWritePre * :%s/\s\+$//e

lua << EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {"c","html","css","javascript","php","bash","vim","markdown"},

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    -- disable = { "html" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
}
EOF
