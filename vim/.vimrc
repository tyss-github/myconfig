set nocompatible              " required
filetype off                  " required

" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
"自动补全引号、括号等
Plugin 'Raimondi/delimitMate'
"添加注释
Plugin 'tpope/vim-commentary'
Plugin 'ervandew/supertab'
Plugin 'gmarik/vundle'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'kien/ctrlp.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'artur-shaik/vim-javacomplete2'
Plugin 'file:///Users/chengyuting/.vim/bundle/load_template'
call vundle#end()

" set NERDTREE
let NERDTreeWinPos='left'
let NERDTreeWinSize=30
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
map <F2> :NERDTreeToggle<CR>

" set TagBar
let g:tagbar_ctags_bin='/usr/local/bin/ctags'          "ctags程序的路径
let g:tagbar_width=30                   "窗口宽度的设置
map <F8> :TagbarToggle<CR>

" set MinBufferExplorer
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
let g:miniBufExplMoreThanOne=0
map <leader>[ :bp<CR>
map <leader>] :bn<CR>

" set vim-airline
set laststatus=2

" 缩进
au BufNewFile,BufRead *.py,*.java
\ set tabstop=4 |
\ set softtabstop=4 |
\ set shiftwidth=4 |
\ set expandtab |
\ set autoindent |
\ set fileformat=unix

au BufNewFile,BufRead *.js, *.html, *.css
\ set tabstop=2 |
\ set softtabstop=2 |
\ set shiftwidth=2 

set encoding=utf-8

" set YCM
au BufNewFile,BufRead *.py
\ let g:ycm_autoclose_preview_window_after_completion=2 |
\ let g:ycm_seed_identifiers_with_syntax=1

" let g:ycm_filetype_blacklist = {
"	\ 'java': 1
"	\ }

map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" python with virtualenv support
python3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    with open(activate_this, 'r') as f:
        exec(f.read(), dict(__file__=activate_this))
EOF

" 高亮
let python_highlight_all=1
syntax on

" 配色
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme Zenburn
endif
call togglebg#map("<F5>")

" 显示行号
set nu
set backspace=indent,eol,start

" 代码折叠
au BufNewFile,BufRead *.py
\ set foldmethod=indent |
\ set foldlevel=0 |
\ nnoremap <space> za

" 自动补全括号
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
 inoremap ) <c-r>=ClosePair(')')<CR>
 inoremap ] <c-r>=ClosePair(']')<CR>
 inoremap } <c-r>=ClosePair('}')<CR>

function ClosePair(char)
 if getline('.')[col('.') - 1] == a:char
 return "\<Right>"
 else
 return a:char
 endif
endf

" 注释解注释
au BufNewFile,BufRead *.py
\ map <leader>/ :s/^\([ ]*\)/\1# /<CR> |
\ map <leader>. :s/^\([ ]*\)# /\1/<CR>

au BufNewFile,BufRead *.java
\ map <leader>/ :s:^\([ ]*\):\1// :<CR> |
\ map <leader>. :s:^\([ ]*\)// :\1:<CR>

map <leader>, :1,$s/[ ]*$//<CR>

" highlight search toggle
set hlsearch
nnoremap <leader>h <ESC>:set hls! hls?<CR>
highlight IncSearch term=reverse ctermfg=230 ctermbg=22 guifg=#ffffe0 guibg=#284f28
highlight Search term=reverse cterm=reverse ctermfg=228 ctermbg=23 gui=reverse guifg=#f8f893 guibg=#385f38

" JAVA 相关
au BufNewFile,BufRead *.java
\ setlocal omnifunc=javacomplete#Complete |
\ let g:JavaComplete_PomPath = "pom.xml" |
\ let g:SuperTabDefaultCompletionType = '<C-x><C-o>' |
\ set completefunc=javacomplete#CompleteParamsInf |
\ inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P> |
\ inoremap <buffer> <C-S-Space> <C-X><C-U><C-P> |
\ inoremap <buffer>  .  .<C-X><C-O><C-P>


" 快捷键冲突
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" 添加模版文件
let g:template_path = '/Users/chengyuting/.vim/bundle/load_template/template/'
map <leader>l :LoadTemplate<CR>
