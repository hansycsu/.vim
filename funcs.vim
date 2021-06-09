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

let g:MyDef_PreFunctionRegex = '\v^[\t ]*(\w+[\t <>*:,&^]+)*\w+[\t >*&^]+(\w+::)?'
let g:MyDef_FunctionNameRegex = '\w+(if)@<!\s*\('

func! My_findDefinition(name)
  call search(g:MyDef_PreFunctionRegex . a:name . '\s*\(', 'csw')
endfunc

func! My_findDefinitionAll(name)
  let pattern = g:MyDef_PreFunctionRegex . a:name
  exe 'vimgrep /' . pattern . '/j %'
  cwindow
endfunc

func! My_whichFunction()
  if search(g:MyDef_PreFunctionRegex . g:MyDef_FunctionNameRegex, 'bcn')
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
    call search(g:MyDef_PreFunctionRegex . g:MyDef_FunctionNameRegex, 'bc')
    wincmd p
  endif
endfunc

" Just like windo, but restore the current window when done.
func! My_windo(command)
  let currwin=winnr()
  exe 'windo ' . a:command
  exe currwin . 'wincmd w'
endfunc

" Just like bufdo, but restore the current buffer when done.
func! My_bufdo(command)
  let currBuff=bufnr("%")
  exe 'bufdo ' . a:command
  exe 'buffer ' . currBuff
endfunc

func! My_GrepFunc(...)
  " Parse args
  let qstr = a:1
  if qstr !~ "'"
    let args = split(qstr, '\s\+')
  else
    let args = split(qstr, "'")
    let args = filter(args, 'v:val !~ "^\s\+$"')
    let args[1] = trim(args[1])
  endif
  let pattern = args[0]
  let filename = args[1]
  call My_grepInFileList(args[0], args[1])
endfunc

" Call vimgrep with <pattern> in files listed in <filename>
func! My_grepInFileList(pattern, filename)
  " Process file list
  if !filereadable(a:filename)
    echoerr 'File not found: ' . a:filename
    return
  endif
  let original_list = readfile(a:filename)
  let readable_list = filter(original_list, 'v:val !=# "" && filereadable(v:val)')
  let escaped_list = map(readable_list, 'fnameescape(v:val)')

  " Run vimgrep
  let file_list = join(escaped_list)
  exec 'vimgrep /' . a:pattern . '/j ' . file_list
  copen
endfunc

" Project search (need create_filelist.py)
"   What create_filelist.py do:
"     1. Create filelist of project in a file (unix newline separated)
"     2. Print the path of file contains filelist
func! My_projectSearch(pattern)
  let filename = system('python3 create_filelist.py')
  call My_grepInFileList(a:pattern, filename)
endfunc
