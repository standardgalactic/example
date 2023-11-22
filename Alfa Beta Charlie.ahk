#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^q::
arr := ["Alfa", "Beta", "Charlie"]
arr.Push("Delta")

Loop, read, C:\Users\Mechachleopteryx\OneDrive\Desktop\Blank\Extended radio alphabet.txt
arr.Push(A_LoopReadLine)

for index, element in arr
MsgBox % element . " is number " . index

return