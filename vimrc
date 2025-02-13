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
if v:version >= 900
  set wildoptions+=pum
endif
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
  " g:ctrlp_working_path_mode
  "   r: Search project root dir (which contains .git)
  "   a: If no .git dir, use current file path
  "   w: Search project root from cwd, not file path
  "   Disable these: let g:ctrlp_working_path_mode = 0
  let g:ctrlp_working_path_mode = 'raw'
  " MpSdk2015 Ignore files for CtrlP
  " let g:ctrlp_custom_ignore = {'dir':  '\v[\/](Release)$', 'file': '\v\.(resx|user|sln|rc|ncb|suo|dll)$'}
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
  nnoremap <silent> <F3> :TlistToggle \| call Inline_initCscope()<CR>
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
" cscope Setting {{{
  func! Inline_initCscope()
    if has("cscope") && !exists('g:cscope#isLoaded')
      set cscopetag
      set cscopetagorder=0
      let g:cscope#dbpath = findfile('.ycsu/cscope.out', '.;')
      if !empty(g:cscope#dbpath)
        let g:cscope#dbpath = fnamemodify(g:cscope#dbpath, ':p')
        exe 'cd ' . fnamemodify(g:cscope#dbpath, ':h')
        cs add cscope.out
      elseif !empty($CSCOPE_DB)
        cs add $CSCOPE_DB
        let g:cscope#dbpath = fnamemodify($CSCOPE_DB, ':p')
      endif
      nmap <silent> <Leader>xh :cs help<CR>:echo ',xk  : Toggle connection'<CR>
      nmap <Leader>xs :cs find s <C-R>=expand("<cword>")<CR><CR>
      nmap <Leader>xg :cs find g <C-R>=expand("<cword>")<CR><CR>
      nmap <Leader>xc :cs find c <C-R>=expand("<cword>")<CR><CR>
      nmap gc         :cs find c <C-R>=expand("<cword>")<CR><CR>
      nmap <Leader>xt :cs find t <C-R>=expand("<cword>")<CR><CR>
      nmap <Leader>xe :cs find e <C-R>=expand("<cword>")<CR><CR>
      nmap <Leader>xf :cs find f <C-R>=expand("<cfile>")<CR><CR>
      nmap <Leader>xi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
      nmap <Leader>xd :cs find d <C-R>=expand("<cword>")<CR><CR>
      nmap <silent> <Leader>xk :call Inline_toggleCscopeConnection()<CR>
      let g:cscope#isLoaded = 1
      let g:cscope#isConnected = 1
    endif
  endfunc

  func! Inline_toggleCscopeConnection()
    if exists('g:cscope#isConnected')
      if g:cscope#isConnected
        cs kill 0
      else
        exe 'cs add ' . g:cscope#dbpath
      endif
      let g:cscope#isConnected = !g:cscope#isConnected
      cs show
    endif
  endfunc
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
set scrolloff=0
set foldtext=My_foldText()
"}}}
" Mappings {{{
" Simple Remapping {{{
  if !empty(maparg('Q'))
    unmap Q
  endif
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
  noremap <C-2> @@
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
  noremap zZ zszH
  inoremap <C-q> <C-r>+
  cnoremap <C-q> <C-r>+
  cnoreabbrev cvim vim//j **/*.c **/*.h **/*.cpp **/*.hpp<Home><Right><Right><Right>
  "}}}
" Commands {{{
  if has('unix')
    command! CopyAllInBuffer %yank +
    command! CopyFilePath let @+=expand('%:p')
  else
    command! CopyAllInBuffer %yank *
    command! CopyFilePath let @*=expand('%:p')
  endif
  command! CD cd %:p:h
  command! DiffIgnoreWhite set diffopt+=iwhite
  command! ShowFileModificationTime echo strftime('%Y-%m-%d %H:%M:%S',getftime(expand('%')))
  command! -nargs=1 SearchBuf call My_searchInAllBuffer(<f-args>)
  command! -register CopyMatches call My_copyMatches(<q-reg>)
  command! -nargs=1 FindDefinition call My_findDefinitionAll(<f-args>)
  command! -nargs=1 Vgrep vimgrep /<args>/j % | cw
  command! -nargs=+ -complete=command Windo call My_windo(<q-args>)
  command! -nargs=+ -complete=command Windofast noautocmd call My_windo(<q-args>)
  command! -nargs=+ -complete=command Bufdo call My_bufdo(<q-args>)

  " Usage: Grep <pattern> <filename>
  "          if <pattern> and <filename> contains whitespace, they must be
  "          surrounded by single quotes
  "          e.g. Grep 'abc de' '/abc de/my filelist.txt'
  "          (No, we do NOT handle pattern with single quotes)
  command! -nargs=+ Grep call My_GrepFunc(<q-args>)

  " Usage: Ps <pattern>
  "          You do not have to surround <pattern> with / ... /
  "          There must be create_filelist.py in pwd
  "          What create_filelist.py do:
  "            1. Create filelist of project in a file (unix newline separated)
  "            2. Print the path of file contains filelist
  command! -nargs=1 Ps call My_projectSearch(<f-args>)

  autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>
  autocmd Filetype * setlocal formatoptions-=c
  autocmd BufRead,BufNewFile *.cmm set filetype=cmm
  "}}}
" Function Key {{{
  nnoremap <F1> :tab h 
  nnoremap <silent> <F2> :se hls!<CR>
  vnoremap <silent> <F2> :<C-u>se hls!<CR>gv
  inoremap <silent> <F2> <C-o>:se hls!<CR>
  nnoremap <silent> <F4> :call My_editOrSaveVimrc()<CR>
  nnoremap <silent> <C-F4> :tabe $MYVIMRC<CR>
  nnoremap <silent> <S-F4> :tabe $VIMFILES/local.vimrc<CR>
  nnoremap <silent> <F6> :exe &rnu?'se nu nornu':'se nonu rnu'<CR>
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
  hi MyMatch1 ctermbg=DarkGreen guibg=DarkGreen ctermfg=White guifg=White
  hi MyMatch2 ctermbg=DarkBlue guibg=DarkBlue  ctermfg=White guifg=White
  hi MyMatch3 ctermbg=DarkRed guibg=DarkRed  ctermfg=White guifg=White
  nmap <Leader>mm :Windo call matchadd('MyMatch1', '')<Left><Left>
  nmap <Leader>md :call Inline_showAllMatches()<CR>:call matchdelete()<Left>
  nmap <silent> <Leader>m1 :Windo call matchadd('MyMatch1', '\<<C-r><C-w>\>')<CR>
  nmap <silent> <Leader>m2 :Windo call matchadd('MyMatch2', '\<<C-r><C-w>\>')<CR>
  nmap <silent> <Leader>m3 :Windo call matchadd('MyMatch3', '\<<C-r><C-w>\>')<CR>
  nmap <silent> <Leader>mc :Windo call clearmatches()<CR>
  nmap <silent> <Leader>ml :call Inline_showAllMatches()<CR>
    func! Inline_showAllMatches()
      let l:matches = getmatches()
      for i in l:matches
        if has_key(i, 'pattern')
          echo i.id . "\t/" . i.pattern . '/'
        endif
      endfor
    endfunc
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
