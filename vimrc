"-------- Set First ---------
let $VIMFILES = '~/.vim'
let $MYVIMRC  = '~/.vim/vimrc'
let s:VundlePath = '$VIMFILES/bundle/Vundle.vim'
let s:BundlePath = '$VIMFILES/bundle'
let s:MyFont     = 'DejaVu_Sans_Mono_for_Powerline:h16'
let s:MyFontWide = 'Microsoft_YaHei_Mono:h16'
let s:GuiColorScheme     = 'synic'
let s:ConsoleColorScheme = 'synic'
"----------------------------
" Defalut Path {{{
if !exists('$VIMFILES')
    let $VIMFILES = expand(split(&rtp, ',')[0])
endif
set rtp+=$VIMFILES
"}}}
" Remap <Leader> {{{
let mapleader = ','
noremap \ ,
noremap , <Leader>
"}}}


" Encoding & GUI {{{
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,taiwan,prc,japan,latin1
set wildmenu
set laststatus=2
set statusline=[%t%r]\ [%{&ff}\|%{&fenc}]
              \%=(%c,\ %l)\ --\ %P\ --\ \ [lines:\ %L]
if has('gui_running')
    set guioptions=M
    exe "set guifont=" . s:MyFont
    exe "set guifontwide=" . s:MyFontWide
else
    set t_Co=256
    language en_US.utf8
endif
"}}}
" Vundle & Plugins {{{
"   Vundle Initialization {{{
    set nocompatible
    filetype off
    exe "set rtp+=".s:VundlePath
    "call vundle#begin(s:BundlePath)
    exe "call vundle#begin('".expand(s:BundlePath)."')"
    "}}}
"-------- Plugin List ---------
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'scrooloose/nerdcommenter'
Plugin 'artoj/qmake-syntax-vim'
Plugin 'tpope/vim-surround'
Plugin 'guns/xterm-color-table.vim'
"------ Install Manually ------
Plugin 'manually_visincr', {'pinned': 1}
Plugin 'manually_taglist', {'pinned': 1}
"------------------------------
"   Vundle Initialization Finish {{{
    call vundle#end()
    filetype plugin indent on
    "}}}
"   Airline Setting {{{
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#whitespace#enabled = 0
    let g:airline#extensions#tabline#fnamemod = ':t'
    let g:airline#extensions#tabline#tab_nr_type = 1
    let g:airline#extensions#tabline#buffer_idx_mode = 1
    let g:airline_section_z = '%3p%% %{g:airline_symbols.linenr}%4l:%3v'
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline_symbols.crypt = ''
    let g:airline_symbols.maxlinenr = '㏑'
    let g:airline_symbols.linenr = ''
    nmap <Leader>1 <Plug>AirlineSelectTab1
    nmap <Leader>2 <Plug>AirlineSelectTab2
    nmap <Leader>3 <Plug>AirlineSelectTab3
    nmap <Leader>4 <Plug>AirlineSelectTab4
    nmap <Leader>5 <Plug>AirlineSelectTab5
    nmap <Leader>6 <Plug>AirlineSelectTab6
    nmap <Leader>7 <Plug>AirlineSelectTab7
    nmap <Leader>8 <Plug>AirlineSelectTab8
    nmap <Leader>9 <Plug>AirlineSelectTab9
    nmap         J <Plug>AirlineSelectPrevTab
    nmap         K <Plug>AirlineSelectNextTab
    "}}}
"   CtrlP Setting {{{
    let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'line']
    let g:ctrlp_working_path_mode = 0
    nnoremap zp :CtrlP
    nnoremap zpt :CtrlPTag<CR>
    nnoremap zpb :CtrlPBufTag<CR>
    nnoremap zpq :CtrlPQuickfix<CR>
    nnoremap zpl :CtrlPLine<CR>
    nnoremap <silent> <M-p> :CtrlPLastMode<CR>
    "}}}
"   NERDTree Setting {{{
    let g:NERDTreeMapChangeRoot = "CC"
    nnoremap <silent> <Leader>e :call My_toggleNERDTreeF()<CR>
        func! My_toggleNERDTreeF()
            if exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) == 1
                NERDTreeClose
            else
                NERDTreeFind
            endif
        endfunc
    "}}}
"   TagList Setting {{{
    nnoremap <silent> <F3> :TlistToggle<CR>
    "}}}
"}}}
" ****** Basic Setting****** {{{
set nonumber rnu
set autoindent
set tabstop=4 expandtab
set shiftwidth=4
syntax on
set hls
set hidden
set listchars+=tab:>-
set sessionoptions-=options
set sessionoptions+=localoptions
set ignorecase smartcase
set textwidth=0
set backspace=indent,start
set foldmethod=marker
set incsearch
set virtualedit=block
set diffopt+=vertical
set tags=./tags;,tags
set ttimeoutlen=0
set showcmd
set nowrap
"   Color Scheme Setting {{{
    if has('gui_running')
        exe "colo ".s:GuiColorScheme
    else
        exe "colo ".s:ConsoleColorScheme
    endif
    "}}}
"}}}
" Mappings {{{
"   Simple Remapping {{{
    nnoremap Q gQ
    nnoremap QQ :qa<CR>
    nnoremap Y y$
    "noremap <expr> j (v:count == 0 ? 'gj' : 'j')
    "noremap <expr> k (v:count == 0 ? 'gk' : 'k')
    nnoremap <BS> X
    noremap <C-j> J
    noremap <Up> <C-y>
    noremap <Down> <C-e>
    inoremap <C-Up> <C-x><C-y>
    inoremap <C-Down> <C-x><C-e>
    noremap <C-@> @@
    inoremap <C-j> <Esc>gUiwea
    nnoremap S :wa<CR>
    noremap zm zM
    noremap zr zR
    nnoremap <CR> o<C-u><Esc>
    vnoremap <C-c> "*y
    vnoremap <C-v> "*p
    cmap <C-a> <Home>
    imap <C-a> <C-o>^
    imap <C-e> <End>
    noremap ' "
    noremap " '
    imap <C-l> <C-n><C-p>
    "}}}
"   Commands {{{
    command! CopyAllInBuffer normal gg"*yG<c-o><c-o>
    command! CD cd %:p:h
    "}}}
"   Function Key {{{
    nnoremap <F1> :tab h 
    nnoremap <silent> <F2> :se hls!<CR>
    inoremap <silent> <F2> <C-o>:se hls!<CR>
    nnoremap <silent> <F4> :call My_editOrSaveVimrc()<CR>
    nnoremap <silent> <C-F4> :tabe $MYVIMRC<CR>
    nnoremap <silent> <S-F4> :tabe $MYVIMRC<CR>
        if !exists('*EditOrSaveVimrc')
        func! My_editOrSaveVimrc()
            if expand('%:p') == expand(expand('$MYVIMRC'))
                write
                source %
            else
                edit $MYVIMRC
            endif
        endfunc
        endif
    nnoremap <silent> <F6> :exe &nu?'se nu! rnu':'se nu nornu'<CR>
    inoremap <silent> <F6> <C-o>:exe &nu?'se nu! rnu':'se nu nornu'<CR>
        "God like ( :exe 'set nu!' &nu ? 'rnu!' : '' )
    nnoremap <F7> :mks! ~/Session.vim<CR>
    nnoremap <F8> :so ~/Session.vim<CR>
    "}}}
"   Buffer Control {{{
    nnoremap <C-q> <C-^>
    nnoremap <silent> <C-h> :bp<CR>
    nnoremap <silent> <C-l> :bn<CR>
    nnoremap <silent> <M-d> :let hans_varY=@#\|bp\|bd!#\|let @#=hans_varY\|unlet hans_varY<CR>
    nnoremap <silent> <Leader>bp :bp<CR>
    nnoremap <silent> <Leader>bn :bn<CR>
    nnoremap <Leader>bd :ls<CR>:bd<Space>
    nnoremap <Leader>bw :ls<CR>:bw<Space>
    nnoremap <Leader>bb :ls<CR>:b<Space>
    "}}}
"   Window & Tab Control {{{
    nnoremap gw <C-w>w
    nnoremap gW <C-w>W
    nnoremap <M-c> <C-w>c
    nnoremap <silent> <M-o> :only<CR>
    nnoremap <C-c> <C-w>c
    nnoremap zx :bd<CR>
    nnoremap <M-,> <C-w><
    nnoremap <M-.> <C-w>>
    nnoremap <M--> <C-w>-
    nnoremap <M-=> <C-w>+
    nnoremap <silent> <C-w>t :tabe %<CR>
    nnoremap <silent> <C-n> :tabnew<CR>
    "}}}
"   Quick Fix {{{
    nnoremap <silent><Leader>cw :cw<CR>
    nnoremap <silent><Leader>cn :cn<CR>
    nnoremap <silent><Leader>cp :cp<CR>
    "}}}
"   Complex Remapping & Scripts {{{
    vnoremap <silent> * :<C-u>
      \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
      \gvy/<C-r><C-r>=substitute(
      \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
      \gV:call setreg('"', old_reg, old_regtype)<CR>

    vnoremap <Leader>q1 :call My_addAroundSelected()<CR>
        func! My_addAroundSelected()
            let tempReg1 = @"
            let tempReg2 = @-
            let tempReg3 = @*

            call inputsave()
            let addChar = input('Please type 2 characters to add around selected text(q: quit): ')
            call inputrestore()
            if addChar[0] == 'q' || addChar[0] == 'Q'
                return
            endif
            if col("'>") == col('$') - 1
                let editMode = 'a'
            else
                let editMode = 'i'
            endif
            exe "normal gvx".editMode.addChar[0].addChar[1]."\eP"

            let @" = tempReg1
            let @- = tempReg2
            let @* = tempReg3
        endfunc
    "}}}
"}}}
" Others {{{
"   Backup & Swap
    set directory-=.
    set backupdir-=.
    set directory+=.
    set backupdir+=.
    exe 'set directory^='.expand('$VIMFILES/.tmp')
    exe 'set backupdir^='.expand('$VIMFILES/.tmp')
"   Packages
    packadd! matchit
"   Change viminfo path
    let &viminfo .= ',n'.$VIMFILES.'/viminfo'
"}}}
" Load Local Settings {{{
    " OS settings
    if filereadable(expand(expand("$VIMFILES/ovimrc")))
        source $VIMFILES/ovimrc
    endif
    " Machine settings
    if filereadable(expand(expand("$VIMFILES/mvimrc")))
        source $VIMFILES/mvimrc
    endif
    " Functions
    if filereadable(expand(expand("$VIMFILES/funcs.vim")))
        source $VIMFILES/funcs.vim
    endif
"}}}
