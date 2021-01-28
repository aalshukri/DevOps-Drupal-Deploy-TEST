echo off

goto(){
    #Linux
    uname -o
}

goto $@
exit

:(){
    rem Windows
    echo %OS%
    rem exit
}