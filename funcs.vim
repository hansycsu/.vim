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

func! My_toggleMouse()
  if &mouse != ''
    set mouse=
    echo 'Mouse disabled'
  else
    set mouse=a
    echo 'Mouse enabled'
  endif
endfunc

func! My_copyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
  let reg = empty(a:reg) ? '*' : a:reg
  exe 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunc

func! My_reindent(old, new)
  exe 'set ts=' . a:old . ' sts=' . a:old . ' noet'
  retab!
  exe 'set ts=' . a:new . ' sts=' . a:new . ' et'
  retab!
endfunc

func! My_toggleVirtualEdit()
  if &virtualedit == 'all'
    set virtualedit=block
    echo 'Virtual Edit off'
  else
    set virtualedit=all
    echo 'Virtual Edit on'
  endif
endfunc

func! My_findDefinition(name)
  call search('\v^[\t ]*(\w+[\t <>*:,&^]+)*\w+[\t >*&^]+' . a:name, 'csw')
endfunc

func! My_findDefinitionAll(name)
  let pattern = '\v^[\t ]*(\w+[\t <>*:,&^]+)*\w+[\t >*&^]+' . a:name
  exe 'vimgrep /' . pattern . '/j %'
  cwindow
endfunc

func! My_whichFunction()
  if search('\v^[\t ]*(\w+[\t <>*:,&^]+)*\w+[\t >*&^]+\w+\s*\(', 'bcn')
    if g:whichFunctionOpenNewWindow
      split
    else
      " record current state
      let winPosCurr = winnr()
      let lineNum = line('.')
      let fileCurr = @%

      " try to jump to the above window
      wincmd k

      " if no window above (no move)
      if winPosCurr == winnr()
        split

      " now focus on above window
      else
        " if the file window opens is not current file
        if @% != fileCurr
          exe 'edit ' . fileCurr
        endif
        " let view window jump to current line
        exe lineNum
      endif
    endif
    resize 1
    call search('\v^[\t ]*(\w+[\t <>*:,&^]+)*\w+[\t >*&^]+\w+\(', 'bc')
    wincmd p
  endif
endfunc
