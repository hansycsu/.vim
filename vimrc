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


" Encoding & GUI {{{
set encoding=utf-8
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
    nnoremap <silent> <Leader>e :call ToggleNERDTreeF()<CR>
        func! ToggleNERDTreeF()
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
    noremap <expr> j (v:count == 0 ? 'gj' : 'j')
    noremap <expr> k (v:count == 0 ? 'gk' : 'k')
    nnoremap <BS> X
    noremap <C-J> J
    noremap <Up> <C-Y>
    noremap <Down> <C-E>
    inoremap <C-Up> <C-X><C-Y>
    inoremap <C-Down> <C-X><C-E>
    noremap <C-@> @@
    inoremap <C-J> <esc>gUiwea
    command! CopyAllInBuffer normal ggyG<c-o><c-o>
    nnoremap S :wa<CR>
    noremap zm zM
    noremap zr zR
    nnoremap <CR> o<C-U><Esc>
    "}}}
"   Function Key {{{
    nnoremap <F1> :tab h 
    nnoremap <silent> <F2> :se hls!<CR>
    nnoremap <silent> <F4> :call EditOrSaveVimrc()<CR>
    nnoremap <silent> <C-F4> :tabe $MYVIMRC<CR>
    nnoremap <silent> <S-F4> :tabe $MYVIMRC<CR>
        if !exists('*EditOrSaveVimrc')
        func! EditOrSaveVimrc()
            if expand('%:p') == expand(expand('$MYVIMRC'))
                write
                source %
            else
                edit $MYVIMRC
            endif
        endfunc
        endif
    nnoremap <silent> <F6> :exe &nu?'se nu! rnu':'se nu nornu'<CR>
        "God like ( :exe 'set nu!' &nu ? 'rnu!' : '' )
    nnoremap <F7> :mks! ~/Session.vim<CR>
    nnoremap <F8> :so ~/Session.vim<CR>
    "}}}
"   Buffer Control {{{
    nnoremap <C-Tab> <C-^>
    nnoremap <silent> <C-H> :bp<CR>
    nnoremap <silent> <C-L> :bn<CR>
    nnoremap <silent> <M-d> :let hans_varY=@#\|bp\|bd!#\|let @#=hans_varY\|unlet hans_varY<CR>
    nnoremap <silent> <Leader>bp :bp<CR>
    nnoremap <silent> <Leader>bn :bn<CR>
    nnoremap <Leader>bd :ls<CR>:bd
    nnoremap <Leader>bw :ls<CR>:bw
    nnoremap <Leader>bb :ls<CR>:b
    "}}}
"   Window & Tab Control {{{
    nnoremap gw <C-W>w
    nnoremap gW <C-W>W
    nnoremap <M-c> <C-W>c
    nnoremap <C-c> <C-W>c
    nnoremap zx :bd<CR>
    nnoremap <M-,> <C-W><
    nnoremap <M-.> <C-W>>
    nnoremap <M--> <C-W>-
    nnoremap <M-=> <C-W>+
    nnoremap <silent> <C-W>t :tabe %<CR>
    "}}}
"   Complex Remapping & Scripts {{{
    vnoremap <silent> * :<C-U>
      \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
      \gvy/<C-R><C-R>=substitute(
      \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
      \gV:call setreg('"', old_reg, old_regtype)<CR>

    vnoremap <Leader>q1 :call AddAroundSelected()<CR>
        func! AddAroundSelected()
            let tempReg1 = @"
            let tempReg2 = @-
            let tempReg3 = @*

            call inputsave()
            let addChar = input('Please type 2 characters to add around selected text(q: quit): ')
            call inputrestore()
            if addChar[0] == 'q' || addChar[0] == 'Q'
                return
            endif
            exe "normal gvxi".addChar[0].addChar[1]."\eP"

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
"}}}
