" #######, Plugin Manager Star, ##########
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Appearance
Plug 'drewtempelmeyer/palenight.vim'
Plug 'rakr/vim-one'

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
Plug 'tpope/vim-repeat'

" yaml stuff
Plug 'mrk21/yaml-vim'

" csv plugin
Plug 'chrisbra/csv.vim'

" scala plugin
Plug 'derekwyatt/vim-scala'

Plug '907th/vim-auto-save'

" git related
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'bling/vim-bufferline'
Plug 'itchyny/landscape.vim'
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
Plug 'rstacruz/vim-closer'
Plug 'GEverding/vim-hocon'

Plug 'kana/vim-submode'

"Log syntax
Plug 'mtdl9/vim-log-highlighting'

call plug#end()


" set swap, undo, backupfiles locations
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

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
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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

" set background=dark
syntax on
colorscheme landscape
" set guifont=Fira\ Code:h12
set guifont=Monaco:h12

" let g:lightline.colorscheme = 'palenight'

" reloading vimrc
nnoremap <Leader>r :source $MYVIMRC<CR>
" edit vimrc
nnoremap <Leader>ev :tabnew $MYVIMRC<CR>

" Make any help doc split vertically instead of horizontal
au FileType help wincmd L

" to move to the end of the line or start of the line
nnoremap L $<esc>
nnoremap H I<esc>

" Center cursor to the middle of the screen automatically
set scrolloff=0
if !exists('*VCenterCursor')
  augroup VCenterCursor
  au!
  au OptionSet *,*.*
    \ if and( expand("<amatch>")=='scrolloff' ,
    \         exists('#VCenterCursor#WinEnter,WinNew,VimResized') )|
    \   au! VCenterCursor WinEnter,WinNew,VimResized|
    \ endif
  augroup END
  function VCenterCursor()
    if !exists('#VCenterCursor#WinEnter,WinNew,VimResized')
      let s:default_scrolloff=&scrolloff
      let &scrolloff=winheight(win_getid())/2
      au VCenterCursor WinEnter,WinNew,VimResized *,*.*
        \ let &scrolloff=winheight(win_getid())/2
    else
      au! VCenterCursor WinEnter,WinNew,VimResized
      let &scrolloff=s:default_scrolloff
    endif
  endfunction
endif

nnoremap <leader>zz :call VCenterCursor()<CR>

" yaml code folding
" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

set nofoldenable

" Polyglot plugin stuff
let g:polyglot_disabled = ['scala']

" auto expand brackets
inoremap (; (<CR>);<C-c>O
inoremap (, (<CR>),<C-c>O
inoremap {; {<CR>};<C-c>O
inoremap {, {<CR>},<C-c>O
inoremap [; [<CR>];<C-c>O
inoremap [, [<CR>],<C-c>O

" copy to system keyboard
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

" set YMC utf
set encoding=utf-8

" resize windows
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>1


" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" create submode for prev/next windows
call submode#enter_with('next/prev', 'n', '', '<left>', 'gT')
call submode#enter_with('next/prev', 'n', '', '<right>', 'gt')
call submode#map('next/prev', 'n', '', '<left>', 'gT')
call submode#map('next/prev', 'n', '', '<right>', 'gt')

" enable autosave on startup
let g:auto_save = 1

" open ctrlp in new tab
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }
