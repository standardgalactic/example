#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance Force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

#Numpad8:: ; Landscape Mode - WinLogo + Number pad 8
IfWinExist, Screen Resolution
{
    WinActivate, Screen Resolution
}
else
{
    run "desk.cpl"
}	
WinWait, Screen Resolution
if ErrorLevel
{
	MsgBox, WinWait timed out.
	return
}
Send, {Tab}
sleep 500

send, {Alt Down}
send, {o}
send, {Alt Up}

sleep 500
send, {Up} ; Send Up 4 times to make sure we are at the start of the dropdown
send, {Up}
send, {Up}
send, {Up}
sleep 500
send, {Alt Down}
send, {a}
send, {Alt Up}
WinWait, Display Settings
if ErrorLevel
{
	MsgBox, WinWait timed out for display settings.
	return
}
send, {Alt Down}
send, {k}
send, {Alt Up}
WinWait, Screen Resolution
if ErrorLevel
{
	MsgBox, WinWait timed out.
	return
}
send, {Alt Down}
send, {F4}
send, {Alt Up}
return

#Numpad4:: ; Portrait Mode - WinLogo + Number pad 4
IfWinExist, Screen Resolution
{
    WinActivate, Screen Resolution
}
else
{
    run "desk.cpl"
}	
WinWait, Screen Resolution
if ErrorLevel
{
	MsgBox, WinWait timed out.
	return
}
Send, {Tab}
sleep 500

send, {Alt Down}
send, {o}
send, {Alt Up}
;return
sleep 500
send, {Up} ; Send Up 4 times to make sure we are at the start of the dropdown
send, {Up}
send, {Up}
send, {Up}
send, {Down}
sleep 500
send, {Alt Down}
send, {a}
send, {Alt Up}
WinWait, Display Settings
if ErrorLevel
{
	MsgBox, WinWait timed out for display settings.
	return
}
send, {Alt Down}
send, {k}
send, {Alt Up}
WinWait, Screen Resolution
if ErrorLevel
{
	MsgBox, WinWait timed out.
	return
}
send, {Alt Down}
send, {F4}
send, {Alt Up}
return



#Numpad6:: ; Portrait Mode (Flipped) - WinLogo + Number pad 6
IfWinExist, Screen Resolution
{
    WinActivate, Screen Resolution
}
else
{
    run "desk.cpl"
}	
WinWait, Screen Resolution
if ErrorLevel
{
	MsgBox, WinWait timed out.
	return
}
Send, {Tab}
sleep 500

send, {Alt Down}
send, {o}
send, {Alt Up}

sleep 500
send, {Down} ; Send Up 4 times to make sure we are at the end of the dropdown
send, {Down}
send, {Down}
send, {Down}
sleep 500
send, {Alt Down}
send, {a}
send, {Alt Up}
WinWait, Display Settings
if ErrorLevel
{
	MsgBox, WinWait timed out for display settings.
	return
}
send, {Alt Down}
send, {k}
send, {Alt Up}
WinWait, Screen Resolution
if ErrorLevel
{
	MsgBox, WinWait timed out.
	return
}
send, {Alt Down}
send, {F4}
send, {Alt Up}
return

#Numpad2:: ; Landscape Mode (Flipped) - WinLogo + Number pad 2
IfWinExist, Screen Resolution
{
    WinActivate, Screen Resolution
}
else
{
    run "desk.cpl"
}	
WinWait, Screen Resolution
if ErrorLevel
{
	MsgBox, WinWait timed out.
	return
}
Send, {Tab}
sleep 500

send, {Alt Down}
send, {o}
send, {Alt Up}

sleep 500
send, {Up} ; Send Up 4 times to make sure we are at the start of the dropdown
send, {Up}
send, {Up}
send, {Up}
send, {Down}
send, {Down}

sleep 500
send, {Alt Down}
send, {a}
send, {Alt Up}
WinWait, Display Settings
if ErrorLevel
{
	MsgBox, WinWait timed out for display settings.
	return
}
send, {Alt Down}
send, {k}
send, {Alt Up}
WinWait, Screen Resolution
if ErrorLevel
{
	MsgBox, WinWait timed out.
	return
}
send, {Alt Down}
send, {F4}
send, {Alt Up}
return
