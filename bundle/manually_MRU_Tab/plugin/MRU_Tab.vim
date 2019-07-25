let g:MRU_Tab_index = 0

func! MRU_Tab_save()
  let g:MRU_Tab_index = tabpagenr()
endfunc

func! MRU_Tab_switch()
  if g:MRU_Tab_index == 0
    return
  endif
  let s:lastTab = tabpagenr("$")
  let s:currTab = tabpagenr()
  if (g:MRU_Tab_index <= s:lastTab) && (g:MRU_Tab_index != s:currTab)
    exe 'tabn' g:MRU_Tab_index
  endif
endfunc

autocmd TabLeave * call MRU_Tab_save()
nnoremap <silent>gt :call MRU_Tab_switch()<CR>
