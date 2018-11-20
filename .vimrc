
" ######## Plugin Manager Start ##########
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Appearance
Plug 'drewtempelmeyer/palenight.vim'
Plug 'rakr/vim-one'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'

" Fully file,buffer, mru, tag finder
Plug 'ctrlpvim/ctrlp.vim'

"Eksy escape keys
Plug 'zhou13/vim-easyescape'
"Nerd tree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Autocomplete plugin
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' } 
"Go build plugin
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'tpope/vim-surround'

" git related
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

call plug#end()

set number
set relativenumber
let mapleader = ","
let maplocalleader = "."

" Automatically toggles between relative and absolute number modes when entering and exiting insert mode
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

"Show key strokes
set showcmd
set statusline=%F%m%r%h%w\ [Format\ =\ %{&ff}]\ [Type\ =\ %Y]\ [Ascii\ =\ \%03.3b]\ [Hex\ =\ \%02.2B]\ [Cursor\ pos\ =\ %04l,%04v][%p%%]\ [Total\ Length\ =\ %L] 
set laststatus=2
set noshowmode
"Set keybindings for ESC using vim-easyescape plugin
let g:easyescape_chars = { "j": 1, "k": 1 }
let g:easyescape_timeout = 100
cnoremap jk <ESC>
cnoremap kj <ESC>

"Toggle nerdtree using Ctrl+n
map <C-n> :NERDTreeToggle<CR>
"Open Nerd Tree automatically when vim startsup with no files specified.
au StdinReadPre * let s:std_in=1
au VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"*************vim-go plugin settings*****************
" use goimports for formatting
let g:go_fmt_command = "goimports"

" turn highlighting on
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 2
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" Open go doc in vertical window, horizontal, or tab
augroup go_file_group
	autocmd!
	au Filetype go nnoremap <leader>v :vsp <CR>:exe "GoDef" <CR>
	au Filetype go nnoremap <leader>s :sp <CR>:exe "GoDef"<CR>
	au Filetype go nnoremap <leader>t :tab split <CR>:exe "GoDef"<CR>
augroup END
"*************vim-go plugin settings end*****************

" Allow reloaddover everything in insert mode
set backspace=indent,eol,start
":
"************* Enable true colors if available ******************************
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif
"************* Enable true colors if available end ******************************

set background=dark
colorscheme one

" let g:lightline.colorscheme = 'palenight'

" reloading vimrc
nnoremap <Leader>r :source $MYVIMRC<CR>
" edit vimrc
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>

" gruvbox settings
let g:gruvbox_italic = 1
let g:gruvbox_termcolors = 256
let g:gruvbox_contrast_dark = 'soft'
let g:gruvbox_contrast_light = 'soft'
let g:gruvbox_italicize_comments = 1

" Make any help doc split vertically instead of horizontal
au FileType help wincmd L

" to move to the end of the line or start of the line
nnoremap L $<esc>
nnoremap H I<esc>
