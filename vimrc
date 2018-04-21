"-------- Set First ---------
let $VIMFILES = '~/.vim'
let $MYVIMRC  = '~/.vim/vimrc'
let s:VundlePath = '$VIMFILES/bundle/Vundle.vim'
let s:BundlePath = '$VIMFILES/bundle'
let s:ColorScheme     = 'synic'
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


" Encoding & Interface {{{
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,taiwan,prc,japan,latin1
set wildmenu
set laststatus=2
set statusline=[%t%r]\ [%{&ff}\|%{&fenc}]
              \%=(%c,\ %l)\ --\ %P\ --\ \ [lines:\ %L]
if !has('gui_running')
  set t_Co=256
  language en_US.utf8
endif
"}}}
" Vundle & Plugins {{{
" Vundle Initialization {{{
  set nocompatible
  filetype off
  exe "set rtp+=" . s:VundlePath
  "call vundle#begin(s:BundlePath)
  exe "call vundle#begin('" . expand(s:BundlePath) . "')"
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
Plugin 'mattn/emmet-vim'
"------ Install Manually ------
Plugin 'manually_VisIncr', {'pinned': 1}
Plugin 'manually_taglist', {'pinned': 1}
"------------------------------
" Vundle Initialization Finish {{{
  call vundle#end()
  filetype plugin indent on
  "}}}
" Airline Setting {{{
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
" CtrlP Setting {{{
  let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'line']
  let g:ctrlp_working_path_mode = 0
  nnoremap zp :CtrlP
  nnoremap zpt :CtrlPTag<CR>
  nnoremap zpb :CtrlPBufTag<CR>
  nnoremap zpq :CtrlPQuickfix<CR>
  nnoremap zpl :CtrlPLine<CR>
  nnoremap <silent> <M-p> :CtrlPLastMode<CR>
  "}}}
" NERDTree Setting {{{
  let g:NERDTreeMapChangeRoot = "CC"
  nnoremap <silent> <Leader>e :call My_toggleNERDTreeF()<CR>
  "}}}
" NERDCommenter Setting {{{
  map <Leader>cN <plug>NERDCommenterNested
  map <Leader>cC <plug>NERDCommenterComment
  "}}}
" TagList Setting {{{
  nnoremap <silent> <F3> :TlistToggle<CR>
  "}}}
" Emmet Setting {{{
  let g:user_emmet_leader_key='<C-\>'
  imap <expr> <Tab> emmet#expandAbbrIntelligent("\<Tab>")
  vmap <Tab> <C-\>,
  let g:emmet_html5 = 0
  "}}}
"}}}
" ****** Basic Setting****** {{{
set nonumber rnu
set autoindent
set tabstop=2 expandtab
set shiftwidth=2
syntax on
set hls
set hidden
set listchars+=tab:>-
set sessionoptions-=options
set sessionoptions+=localoptions
set ignorecase smartcase
set textwidth=80
set backspace=indent,start
set foldmethod=marker
set incsearch
set virtualedit=block
set diffopt+=vertical
set tags=./tags;,tags
set ttimeoutlen=0
set showcmd
set nowrap
set linebreak
set breakat-=_
set sidescroll=1
exe "colo " . s:ColorScheme
"}}}
" Mappings {{{
" Simple Remapping {{{
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
  if has('unix')
    vnoremap <C-c> "+y
    vnoremap <C-v> "+p
  else
    vnoremap <C-c> "*y
    vnoremap <C-v> "*p
  endif
  cmap <C-a> <Home>
  imap <C-a> <C-o>^
  imap <C-e> <End>
  noremap ' "
  noremap " '
  if has('unix')
    noremap '' "+
  else
    noremap '' "*
  endif
  nmap <Left> zh
  nmap <Right> zl
  "}}}
" Commands {{{
  if has('unix')
    command! CopyAllInBuffer normal gg'+yG<c-o><c-o>
  else
    command! CopyAllInBuffer normal gg'*yG<c-o><c-o>
  endif
  command! CD cd %:p:h
  command! -nargs=1 SearchBuf call My_searchInAllBuffer(<f-args>)
  command! -register CopyMatches call My_copyMatches(<q-reg>)
  "}}}
" Function Key {{{
  nnoremap <F1> :tab h 
  nnoremap <silent> <F2> :se hls!<CR>
  inoremap <silent> <F2> <C-o>:se hls!<CR>
  nnoremap <silent> <F4> :call My_editOrSaveVimrc()<CR>
  nnoremap <silent> <C-F4> :tabe $MYVIMRC<CR>
  nnoremap <silent> <S-F4> :tabe $MYVIMRC<CR>
  nnoremap <silent> <F6> :exe &nu?'se nu! rnu':'se nu nornu'<CR>
  inoremap <silent> <F6> <C-o>:exe &nu?'se nu! rnu':'se nu nornu'<CR>
    "God like ( :exe 'set nu!' &nu ? 'rnu!' : '' )
  nnoremap <F7> :mks! ~/Session.vim<CR>
  nnoremap <F8> :so ~/Session.vim<CR>
  nmap <silent><F12> :call My_toggleMouse()<CR>
  vmap <silent><F12> :<C-u>call My_toggleMouse()<CR>gv
  "}}}
" Buffer Control {{{
  nnoremap <C-q> <C-^>
  nnoremap <silent> <C-h> :bp<CR>
  nnoremap <silent> <C-l> :bn<CR>
  nnoremap <silent> <M-d> :let hans_varY=@#\|bp\|bd!#\|let @#=hans_varY\|unlet hans_varY<CR>
  nnoremap <silent> <Leader>bp :bp<CR>
  nnoremap <silent> <Leader>bn :bn<CR>
  nnoremap <silent> <Leader>bo :%bd\|e#\|bd#<CR>
  nnoremap <Leader>bd :ls<CR>:bd<Space>
  nnoremap <Leader>bw :ls<CR>:bw<Space>
  nnoremap <Leader>bb :ls<CR>:b<Space>
  "}}}
" Window & Tab Control {{{
  nnoremap gw <C-w>w
  nnoremap gW <C-w>W
  nnoremap gp <C-w>p
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
" Quick Fix {{{
  nnoremap <silent><Leader>cw :cw<CR>
  nnoremap <silent><Leader>cn :cn<CR>
  nnoremap <silent><Leader>cp :cp<CR>
  nnoremap <silent><Leader>cc :call setqflist([])<CR>
  "}}}
" Complex Remapping & Scripts {{{
  vnoremap <silent> * :<C-u>
      \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
      \gvy/<C-r><C-r>=substitute(
      \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
      \gV:call setreg('"', old_reg, old_regtype)<CR>

  vnoremap <Leader>q1 :call My_addAroundSelected()<CR>
  "}}}
"}}}
" Matching color and mapping {{{
  hi MyMatch ctermbg=DarkGreen guibg=DarkGreen ctermfg=White guifg=White
  hi MyMatch2 ctermbg=DarkBlue guibg=DarkGreen ctermfg=White guifg=White
  hi MyMatch3 ctermbg=DarkRed guibg=DarkGreen ctermfg=White guifg=White
  nmap <silent> <Leader>mm :match MyMatch /\<<C-r>=expand('<cword>')<CR>\>/<CR>
  nmap <silent> <Leader>m1 :match MyMatch /\<<C-r>=expand('<cword>')<CR>\>/<CR>
  nmap <silent> <Leader>m2 :match MyMatch2 /\<<C-r>=expand('<cword>')<CR>\>/<CR>
  nmap <silent> <Leader>m3 :match MyMatch3 /\<<C-r>=expand('<cword>')<CR>\>/<CR>
  nmap <silent> <Leader>mc :match<CR>
"}}}
" Others {{{
" Backup & Swap
  set directory-=.
  set backupdir-=.
  set directory+=.
  set backupdir+=.
  exe 'set directory^=' . expand('$VIMFILES/.tmp')
  exe 'set backupdir^=' . expand('$VIMFILES/.tmp')
" Packages
  packadd! matchit
" Change viminfo path
  let &viminfo .= ',n' . $VIMFILES . '/viminfo'
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

  " GUI settings
  "   Get gvimrc example here:
  "   https://gist.github.com/f456e042d7c9926684ced7c0af1aa017
  "   or use git:
  "   $ git clone https://gist.github.com/f456e042d7c9926684ced7c0af1aa017.git
  if has('gui_running') && filereadable(expand(expand("$VIMFILES/gvimrc")))
    source $VIMFILES/gvimrc
  endif

  " Functions
  if filereadable(expand(expand("$VIMFILES/funcs.vim")))
    source $VIMFILES/funcs.vim
  endif
"}}}
