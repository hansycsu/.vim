func! ASM_jumpToBlock()
  let bNum = str2nr(expand('<cword>'))
  call search('\cblock\s\+0*' . bNum . '\>', 'ws')
endfunc

nnoremap <buffer> <silent> gb :call ASM_jumpToBlock()<CR>
