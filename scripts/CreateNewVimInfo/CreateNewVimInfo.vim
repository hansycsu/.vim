let s:SPath = expand('<sfile>:p:h')
let s:hFile = s:SPath . '/header'
let s:tFile = s:SPath . '/tail'
let s:rFile = s:SPath . '/reg.viminfo'
echo "Processing ... Registers part of ".expand("%:t")
call cursor(1,1)
let [s:lineBegin,s:x] = searchpos('^"[a-z]')
let [s:lineEnd,s:x] = searchpos('^#')
if s:lineEnd > 0
    let s:lineEnd = s:lineEnd - 1
endif
let s:regs = getline(s:lineBegin,s:lineEnd)
echo "Processing ... Read 'header' in ".s:SPath
call writefile(readfile(s:hFile,'b'), s:rFile, 'b')
call writefile(readfile(s:rFile,'b')+s:regs, s:rFile, 'b')
echo "Processing ... Read 'tail'   in ".s:SPath
call writefile(readfile(s:rFile,'b')+readfile(s:tFile,'b'), s:rFile, 'b')
echo "'reg.viminfo' file created in ".s:SPath
