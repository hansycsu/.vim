" Get g:env
if !exists('g:env')
  if has('win64') || has('win32') || has('win16')
    let g:env = 'WINDOWS'
  else
    let g:env = toupper(substitute(system('uname'), '\n', '', ''))
  endif
endif

" For MS Windows
if g:env =~ 'WINDOWS'
  " These path can be override in local_vimrc
  let g:Git_VIMRUNTIME = '/c/Program Files/Git/usr/share/vim/vim80'
  let g:Git_EXE = 'C:\Program Files\Git\git-bash.exe'

  nnoremap <silent> <Leader>.7 :!start explorer.exe /select,%:p<CR>
  nnoremap <silent> <Leader>.6 :call OpenGitBashHere()<CR>
  func! OpenGitBashHere()
    let tmpVRT = $VIMRUNTIME
    let $VIMRUNTIME = g:Git_VIMRUNTIME
    exe "!start ".g:Git_EXE." --cd=%:p:h"
    let $VIMRUNTIME = tmpVRT
  endfunc
  map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>

" For Unix like System
elseif g:env =~ 'LINUX' && !has('gui_running')
  exe "set <M-c>=\ec"
  exe "set <M-d>=\ed"
  exe "set <M-p>=\ep"
  exe "set <M-o>=\eo"
  exe "set <M-,>=\e,"
  exe "set <M-.>=\e."
  exe "set <M-->=\e-"
  exe "set <M-=>=\e="
  exe "set <S-F4>=\e[1;2S"
  " No option <C-F4> and we don't want to map <Esc>,
  " so we have to magic tricks
  exe "set <F13>=\e[1;5S"
  map <F13> <C-F4>
  map! <F13> <C-F4>
  autocmd VimLeave * call system("xsel -ib", getreg('+'))
  autocmd VimLeave * call system("xsel -i", getreg('*'))

" For Cygwin
elseif g:env =~ 'CYGWIN'
  " Mapping for meta keys
  nnoremap <silent> p :CtrlPLastMode<CR>
  nnoremap <silent> d :let hans_varY=@#\|bp\|bd!#\|let @#=hans_varY\|unlet hans_varY<CR>
  nnoremap c <C-w>c
  nnoremap <silent> o :only<CR>
  nnoremap , <C-w><
  nnoremap . <C-w>>
  nnoremap - <C-w>-
  nnoremap = <C-w>+
endif
