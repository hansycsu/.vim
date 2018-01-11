func! My_WrapCurrLine()
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
