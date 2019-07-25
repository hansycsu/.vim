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
set fileencodings=ucs-bom,utf-8,big5,cp950,taiwan,cp936,prc,cp932,japan,latin1
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
Plugin 'godlygeek/tabular'
Plugin 'Yggdroot/indentLine'
"------ Install Manually ------
Plugin 'manually_VisIncr', {'pinned': 1}
Plugin 'manually_taglist', {'pinned': 1}
Plugin 'manually_YCSign', {'pinned': 1}
Plugin 'manually_MRU_Tab', {'pinned': 1}
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
  "imap <expr> <Tab> emmet#expandAbbrIntelligent("\<Tab>")
  "vmap <Tab> <C-\>,
  let g:emmet_html5 = 0
  "}}}
" IndentLine Setting {{{
  let g:indentLine_char = '▏'
  let g:indentLine_enabled = 0
  nnoremap <silent> <F9> :IndentLinesToggle<CR>
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
set listchars+=space:.
set sessionoptions-=options
set sessionoptions+=localoptions
set ignorecase smartcase
set textwidth=80
set formatoptions-=t
set backspace=indent,start,eol
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
set nofixeol
set cinoptions=l1
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
  noremap zM zm
  noremap zR zr
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
  noremap! <C-r>' <C-r>"
  noremap! <C-r><C-o>' <C-r><C-o>"
  map <Leader><Space> s<Space><Space><Esc>P
  map <Leader>yg :CopyAllInBuffer<CR>
  "}}}
" Commands {{{
  if has('unix')
    command! CopyAllInBuffer %yank +
  else
    command! CopyAllInBuffer %yank *
  endif
  command! CD cd %:p:h
  command! -nargs=1 SearchBuf call My_searchInAllBuffer(<f-args>)
  command! -register CopyMatches call My_copyMatches(<q-reg>)
  command! -nargs=1 FindDefinition call My_findDefinitionAll(<f-args>)
  command! -nargs=1 Vgrep vimgrep /<args>/j % | cw
  command! -nargs=+ -complete=command Windo call My_windo(<q-args>)
  command! -nargs=+ -complete=command Windofast noautocmd call My_windo(<q-args>)
  command! -nargs=+ -complete=command Bufdo call My_bufdo(<q-args>)

  autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>
  "}}}
" Function Key {{{
  nnoremap <F1> :tab h 
  nnoremap <silent> <F2> :se hls!<CR>
  vnoremap <silent> <F2> :<C-u>se hls!<CR>gv
  inoremap <silent> <F2> <C-o>:se hls!<CR>
  nnoremap <silent> <F4> :call My_editOrSaveVimrc()<CR>
  nnoremap <silent> <C-F4> :tabe $MYVIMRC<CR>
  nnoremap <silent> <S-F4> :tabe $VIMFILES/local.vimrc<CR>
  nnoremap <silent> <F6> :exe &nu?'se nu! rnu':'se nu nornu'<CR>
  inoremap <silent> <F6> <C-o>:exe &nu?'se nu! rnu':'se nu nornu'<CR>
    "God like ( :exe 'set nu!' &nu ? 'rnu!' : '' )
  nnoremap <F7> :mks! ~/Session.vim<CR>
  nnoremap <F8> :so ~/Session.vim<CR>
  nmap <silent> <F12> :call My_toggleMouse()<CR>
  vmap <silent> <F12> :<C-u>call My_toggleMouse()<CR>gv
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
  nnoremap <silent> <Leader>cw :cw<CR>
  nnoremap <silent> <Leader>cn :cn<CR>
  nnoremap <silent> <Leader>cp :cp<CR>
  nnoremap <silent> <Leader>cc :call setqflist([])<CR>
  "}}}
" Complex Keymaps & Calling My_functions {{{
  vnoremap <silent> * :<C-u>
      \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
      \gvy/<C-r><C-r>=substitute(
      \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
      \gV:call setreg('"', old_reg, old_regtype)<CR>

  vnoremap <Leader>q1 :call My_addAroundSelected()<CR>
  nnoremap <silent> <Leader>ve :call My_toggleVirtualEdit()<CR>
  nnoremap <silent> <Leader>fd :call My_findDefinition(expand('<cword>'))<CR>
  let g:whichFunctionOpenNewWindow = 0
  nmap <silent> <Leader>wf :call My_whichFunction()<CR>
  nnoremap <silent> <CR> :<C-u>call Inline_addNewLines(v:count)<CR>
    func! Inline_addNewLines(count)
      if a:count == 0
        put = ''
      else
        let i = 0
        while i < a:count
          put = ''
          let i += 1
        endwhile
      endif
    endfunc
  "}}}
"}}}
" Matching color and mapping {{{
  hi MyMatch ctermbg=DarkGreen guibg=DarkGreen ctermfg=White guifg=White
  hi MyMatch2 ctermbg=DarkBlue guibg=DarkBlue  ctermfg=White guifg=White
  hi MyMatch3 ctermbg=DarkRed guibg=DarkRed  ctermfg=White guifg=White
  nmap <silent> <Leader>mm :Windo match MyMatch /\<<C-r><C-w>\>/<CR>
  nmap <silent> <Leader>m1 :Windo match MyMatch /\<<C-r><C-w>\>/<CR>
  nmap <silent> <Leader>m2 :Windo match MyMatch2 /\<<C-r><C-w>\>/<CR>
  nmap <silent> <Leader>m3 :Windo match MyMatch3 /\<<C-r><C-w>\>/<CR>
  nmap <silent> <Leader>mc :Windo match<CR>
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
" Load OS/Local Settings {{{
  " OS settings
  if filereadable(expand(expand("$VIMFILES/os.vimrc")))
    source $VIMFILES/os.vimrc
  endif

  " Local settings
  if filereadable(expand(expand("$VIMFILES/local.vimrc")))
    source $VIMFILES/local.vimrc
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
