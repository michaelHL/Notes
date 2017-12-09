set nocompatible              " be iMproved, required
filetype off                  " required
syntax on

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" let path = '~/some/path/here'
" call vundle#rc(path)

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between here and filetype plugin indent on.
" scripts on GitHub repos
Plugin 'tpope/vim-fugitive'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-rails.git'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" fuzzy finder
Plugin 'Yggdroot/LeaderF'

" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" Distraction-free writing in Vim
Plugin 'junegunn/goyo.vim'

" Provide easy code formatting in Vim by integrating existing code formatters.
Plugin 'Chiel92/vim-autoformat'

" quoting/parenthesizing made simple
Plugin 'tpope/vim-surround'

" Defaults everyone can agree on
Plugin 'tpope/vim-sensible'

" comment stuff out
Plugin 'tpope/vim-commentary'

" enable repeating supported plugin maps with "."
Plugin 'tpope/vim-repeat'

" helpers for UNIX
Plugin 'tpope/vim-eunuch'

" tree explorer plugin for vim
Plugin 'scrooloose/nerdtree'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'

" lean & mean status/tabline for vim that's light as air
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Better whitespace highlighting for Vim
Plugin 'ntpeters/vim-better-whitespace'

" One colorscheme pack to rule them all!
Plugin 'michaelHL/awesome-vim-colorschemes'

" Vim plugin, provides insert mode auto-completion for
" quotes, parens, brackets, etc.
Plugin 'Raimondi/delimitMate'

" A Vim alignment plugin
Plugin 'junegunn/vim-easy-align'

" rainbow parenthese improved, shorter code
Plugin 'luochen1990/rainbow'

" eliminating the buff!!
Plugin 'qpkorr/vim-bufkill'

" vimscript for gist
Plugin 'mattn/gist-vim'

" vim interface to Web API
Plugin 'mattn/webapi-vim'

" YCM
Plugin 'Valloric/YouCompleteMe'

" gtags
Plugin 'aceofall/gtags.vim'

" Markdown Vim Mode
Plugin 'plasticboy/vim-markdown'

" Auto close tags
Plugin 'alvan/vim-closetag'

" Add file type glyphs/icons
Plugin 'ryanoasis/vim-devicons'

call vundle#end()
filetype plugin indent on     " required

" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin commands are not allowed.

set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set t_Co=256
color meta5
set colorcolumn=80
set cursorline
set shortmess=aoOtI
set ai
set nu
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set list listchars=tab:\ \ " trainling space -_||
" smartindent refuse to indent with #
" set smartindent
" set cindent
" set cinkeys-=0#
" set indentkeys-=0#
set autoindent
set nowrap
set wildmenu
set ignorecase
set showmatch
set vb t_vb=
set t_md=
set ruler
set scrolloff=5
set laststatus=2
set virtualedit=block
set backspace=indent,eol,start
set showmode
set cmdheight=1
set showcmd
set nohls
set hidden
set splitbelow
set splitright
set guicursor=
set autoread
set timeoutlen=200 ttimeoutlen=0

" 打开自动定位到最后编辑的位置, 需要确认.viminfo当前用户可写
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" F2 行号切换
nnoremap <silent> <F2> :set number!<CR>

" F3 粘贴模式
set pastetoggle=<F3>

" F4 换行开关
nnoremap <F4> :set wrap! wrap?<CR>

" http://stackoverflow.com/questions/13194428/is-better-way-to-zoom-windows-in-vim-than-zoomwin
" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()

" disbale paste mode when leaving insert mode
au InsertLeave * set nopaste

" F8 简易编译
map <F8> :call CompileRun()<CR>
func! CompileRun()
    exec "w"
    if &filetype == 'c'
       :!clear; gcc -std=c11 -Wall % -o %<; time ./%<
    elseif &filetype == 'cpp'
       :!clear; g++ -std=c++11 -Wall % -o %<; time ./%<
    elseif &filetype == 'python'
       :!clear; time python3 %
    elseif &filetype == 'sh'
       :!clear; sh %
    elseif &filetype == 'perl'
       :!clear; time perl %
    endif
endfunc

" F10 语法开关，关闭语法可以加快大文件的展示
nnoremap <F10> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>

""" vim-autoformat
let g:formatdef_c = '"astyle --style=java --indent=spaces=4 --indent-switches --align-pointer=name --remove-braces --pad-oper --pad-comma --pad-header --unpad-paren"'
let g:formatdef_perl = '"perltidy -l=78 -i=4 -ci=4 -vt=2 -cti=1 -pt=2 -bt=1 -sbt=1 -bbt=1 -nsfs -nolq -wbb=\"% + - * / x != == >= <= =~ !~ < > | & = **= += *= &= <<= &&= -= /= |= >>= ||= //= .= %= ^= x=\" -st -tqw -se -ce"'
let g:formatters_c = ['c']
let g:formatters_cpp = ['c']
let g:formatters_java = ['c']
let g:formatters_perl = ['perl']
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

"""  goyo
" let g:goyo_height = 90
let g:goyo_margin_top = 4
let g:goyo_margin_bottom = 4

""" key map
let mapleader = "\ "

nnoremap U <C-r>
nnoremap <silent> n  nzz
nnoremap <silent> N  Nzz
nnoremap <silent> {  {zz
nnoremap <silent> }  }zz
nnoremap <silent> *  *zz
nnoremap <silent> #  #zz
nnoremap <silent> g* g*zz
" nnoremap <silent> J  mzJ`z

nnoremap <F1> <nop>
nnoremap Q    <nop>
nnoremap K    <nop>

nnoremap <buffer> <silent> k  gk
nnoremap <buffer> <silent> j  gj
nnoremap <buffer> <silent> gk k
nnoremap <buffer> <silent> gj j
nnoremap <buffer> <silent> 0 g0
nnoremap <buffer> <silent> $ g$

nnoremap <silent> <C-h>      <C-w><Left>
nnoremap <silent> <C-l>      <C-w><Right>
nnoremap <silent> <C-j>      <C-w><Down>
nnoremap <silent> <C-k>      <C-w><Up>
nnoremap <silent> <C-e>      2<C-e>
nnoremap <silent> <C-y>      2<C-y>
nnoremap <silent> <Leader>v  <C-w>v
nnoremap <silent> <Leader>3  <C-w><Right><C-w>v<C-w>s
inoremap <C-l>               ->
inoremap <C-k>               <Space>=><Space>
nmap     <silent> <Leader>s  <Plug>(easymotion-s)


nnoremap <silent> +           :resize +4<CR>
nnoremap <silent> _           :resize -4<CR>
nnoremap <silent> ++          :vertical resize +6<CR>
nnoremap <silent> __          :vertical resize -6<CR>
nnoremap <silent> <Tab>       :bn<CR>
nnoremap <silent> <S-Tab>     :bp<CR>
nnoremap <silent> <Leader>w   :w<CR>
nnoremap <silent> <Leader>p   :q!<CR>
nnoremap <silent> <Leader>q   :BD!<CR>
nnoremap <silent> <Leader>qa  :qa!<CR>
nnoremap <silent> <Leader>n   :enew<CR>
nnoremap <silent> <Leader>nh  :new<CR>
nnoremap <silent> <Leader>nv  :vnew<CR>
nnoremap <silent> <Leader>e   :e!<CR>
nnoremap <silent> <Leader>wa  :wa!<CR>
nnoremap <silent> <Leader>wq  :wq!<CR>
nnoremap <silent> <Leader>wqa :wqa!<CR>
nnoremap <silent> <Leader>l   :StripWhitespace<CR>
nnoremap <silent> <Leader>z   :ZoomToggle<CR>
nnoremap <silent> <F11>       :Goyo<CR>
nnoremap <silent> <C-n>       :NERDTreeToggle<CR>
nnoremap <silent> ==          :Autoformat<CR>

""" vim-commentary
autocmd FileType python,shell,coffee set commentstring=#\ %s
autocmd FileType java,c,cpp set commentstring=//\ %s

""" air-line
let g:airline_theme="behelit"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#whitespace#enabled = 1
" let g:airline_section_c = '%{strftime("❦ %H:%M:%S ❦")}'
" let g:airline#extensions#whitespace#symbol = '!'

""" nerd-tree
" autocmd Vimenter * NERDTree
" autocmd VimEnter * wincmd p
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
let g:NERDTreeWinSize = 27
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

""" nerdtree-syntax-highlight
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
let g:NERDTreeExtensionHighlightColor = {} "this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['css'] = '' "assigning it to an empty string will skip highlight
let g:NERDTreeLimitedSyntax = 1

""" LeaderF
let g:Lf_StlSeparator = { 'left': '', 'right': ''  }

""" easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

""" easy-motion
hi EasyMotionTarget ctermbg=none ctermfg=87
hi EasyMotionTarget2First ctermbg=none ctermfg=75
hi EasyMotionTarget2Second ctermbg=none ctermfg=lightred

"""vim-better-whitespace
hi ExtraWhitespace ctermbg=237

""" rainbow
let g:rainbow_active = 1

""" gist-vim
let g:gist_detect_filetype = 1
let g:gist_show_privates = 1
let g:gist_get_multiplefile = 1

""" vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 0

""" gtags
set cscopetag
set cscopeprg='gtags-cscope'

let GtagsCscope_Auto_Load = 1
let CtagsCscope_Auto_Map = 1
let GtagsCscope_Quiet = 1

""" vim-closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.md'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_emptyTags_caseSensitive = 1

""" ycm
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_server_python_interpreter = '/usr/bin/python2'
set completeopt=longest,menu
let g:ycm_semantic_triggers = {
\ 'c' : ['->', '.', ' ', '(', '[', '&'],
\ 'cpp,objcpp' : ['->', '.', ' ', '(', '[', '&', '::'],
\ 'perl' : ['->', '::', ' '],
\ 'php' : ['->', '::', '.'],
\ 'cs,java,javascript,d,vim,python,perl6,scala,vb,elixir,go' : ['.'],
\ 'ruby' : ['.', '::'],
\ 'lua' : ['.', ':']
\ }

""" delimitMate
let g:delimitMate_autoclose = 1
let g:delimitMate_matchpairs = "(:),[:],{:}"
let delimitMate_quotes = "\" '"
let g:delimitMate_jump_expansion = 0
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_inside_quotes = 1
