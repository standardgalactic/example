#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^t::
InputBox, name, Input name dialogue, Please write your name (Message will self-destruct after 10 seconds), , 750, 378, , , locale,10
Switch ErrorLevel
{
case 0:
MsgBox, Thank you, %name%
case 1:
MsgBox,Bye for now
case 2:
MsgBox, Too Late. 
}
return
