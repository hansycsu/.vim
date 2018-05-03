" For MS Windows
if has('win32')
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
endif

" For Unix like System
if has('unix') && !has('gui_running')
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
endif
