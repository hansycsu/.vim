" *************************************************
" YCSign global variables
" *************************************************
let g:YCSignID = 1120
let g:YCSignList = {}
sign define YCSign text=⚑

" *************************************************
" YCSign commands
" *************************************************
command! YCSignToggle call YCSignToggle()
command! YCSignClear call YCSignClear()
command! YCSignList call YCSignList()
command! YCSignReset call YCSignReset()

" *************************************************
" Set SignColumn style equal to LineNr
" *************************************************
func! s:setHighlight()
  redir => hiLineNr | silent hi LineNr | redir end
  let hiLineNrList = split(hiLineNr)
  let exeStr = 'hi SignColumn'
  for i in hiLineNrList
    if (i =~ '\vctermfg|ctermbg|guifg|guibg')
      let exeStr .= ' ' . i
    endif
  endfor
  exe exeStr
endfunc
call s:setHighlight()

" *************************************************
" Set default mapping, if mapping has not set
" *************************************************
if ! hasmapto(':YCSignToggle<CR>')
  nmap <silent> <Leader>ss :YCSignToggle<CR>
endif
if ! hasmapto(':YCSignClear<CR>')
  nmap <silent> <Leader>sc :YCSignClear<CR>
endif
if ! hasmapto(':YCSignList<CR>')
  nmap <silent> <Leader>sl :YCSignList<CR>
endif

" *************************************************
" YCSign functions
" *************************************************
func! YCSignToggle()
  let lineNr = line('.')
  let bufNr = bufnr('%')
  if s:existSign(lineNr, bufNr)
    call YCSignRemove(lineNr, bufNr)
  else
    call YCSignAdd(lineNr, bufNr)
  endif
endfunc

func! YCSignAdd(lineNr, bufNr)
  exe 'sign place ' . g:YCSignID . ' line=' . a:lineNr . ' name=YCSign buffer=' . a:bufNr
  if has_key(g:YCSignList, a:bufNr)
    call add(g:YCSignList[a:bufNr], a:lineNr)
  else
    let g:YCSignList[a:bufNr] = [a:lineNr]
  endif
endfunc

func! YCSignRemove(lineNr, bufNr)
  let indexToRemove = index(g:YCSignList[a:bufNr], a:lineNr)
  call remove(g:YCSignList[a:bufNr], indexToRemove)
  call YCSignReset()
endfunc

func! YCSignReset()
  sign unplace *
  for [bufNr, lineNrList] in items(g:YCSignList)
    for lineNr in lineNrList
      exe 'sign place ' . g:YCSignID . ' line=' . lineNr . ' name=YCSign buffer=' . bufNr
    endfor
  endfor
endfunc

func! YCSignClear()
  sign unplace *
  let g:YCSignList={}
endfunc

func! YCSignList()
  echo printf('%-6s%s', 'Line', 'Content')
  echo '------------------------'
  let bufNr = bufnr('%')
  if ! has_key(g:YCSignList, bufNr)
    echo '(empty)'
    return
  endif
  for lineNr in g:YCSignList[bufNr]
    let lineStr = getline(lineNr)
    echo printf('%-6d%s', lineNr, lineStr)
  endfor
endfunc

func! s:existSign(lineNr, bufNr)
  if ! has_key(g:YCSignList, a:bufNr)
    return 0
  endif

  if index(g:YCSignList[a:bufNr], a:lineNr) == -1
    return 0
  else
    return 1
  endif
endfunc
