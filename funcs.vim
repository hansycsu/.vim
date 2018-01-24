func! My_wrapCurrLine()
  while 1
    normal $
    if virtcol('.') > &tw
      exe ":normal! 0".&tw."|i\n"
    else
      break
    endif
  endwhile
endfunc

func! My_dumpCmd(cmd)
  redir => message
  silent execute a:cmd
  redir END
  if empty(message)
    echoerr "no output"
  else
    tabnew
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
    silent put=message
  endif
endfunc

func! My_searchInAllBuffer(pattern)
  call setqflist([])
  silent! exe 'bufdo vimgrepadd '.a:pattern.' %'
  cwindow
endfunc

func! My_toggleNERDTreeF()
  if exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) == 1
    NERDTreeClose
  else
    NERDTreeFind
  endif
endfunc

if !exists('*My_editOrSaveVimrc')
func! My_editOrSaveVimrc()
  if expand('%:p') == expand(expand('$MYVIMRC'))
    write
    source %
  else
    edit $MYVIMRC
  endif
endfunc
endif

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
