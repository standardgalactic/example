#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance force

F1::MsgBox Script is running!

; Set a one-time timer for 30 seconds to test 

;; not working ;;
SetTimer, SendUndo, -250  ; Negative means it runs once after 30s
return

SendUndo:
Send, ^z
TrayTip, Sent, Sent Ctrl+Z!, 2
return

F3::Send, ^z
