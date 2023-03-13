#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%
#Include, auth.ahk

result:=auth(1100585)

if(result!=0){
    MsgBox, , login success,  login success,
}else{
    MsgBox, , fail
}
