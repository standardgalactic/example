;Startup
;Menu MButton Scroll

/*
	Desc: Implements the scrolling up/down functionality via the middle mouse button in AHK Studio

	Written by Runar "RUNIE" Borge
	Plugin for AHK Studio by maestrith
	Forum topic: https://autohotkey.com/boards/viewtopic.php?f=62&t=300
	Plugin topic: https://autohotkey.com/boards/viewtopic.php?f=62&t=30107
	
*/

#NoTrayIcon
#SingleInstance,Force

; fasty fast
SetBatchLines -1

; settings
Key := "MButton" ; key to toggle the scrolling
DeadZone := 60 ; deadzone in pixels
MaxDiff := A_ScreenHeight/3.6 ; maximum up/down movement in pixels
MaxSleep := 50 ; maximum time between scroll calls in ms

; get studio object
x:=ComObjActive("AHK-Studio")

; close this script when studio closes
x.AutoClose(A_ScriptHwnd)

; get sc control handle
sc := x.sc()

; get hwnd of ahk studio window
hwnd := x.hwnd()

; bind key
Hotkey, IfWinActive, % "ahk_id" hwnd
Hotkey, % Key, StartScroll
return

StartScroll:
MouseGetPos,, StartY,, Control

; only apply to scintilla controls
if !InStr(Control, "Scintilla")
	return

; disable hotkey
Hotkey, % Key, Off

Loop {
	; get new pos
	MouseGetPos,, CurrentY
	; scroll up or down if outside deadzone
	if (CurrentY > StartY + DeadZone) ; scroll up
		sc.2342
	else if (CurrentY < StartY - DeadZone) ; scroll down
		sc.2343
	; sleep x amount depending on mouse position
	DllCall("Sleep", UInt, Abs(Limit(Abs(StartY-CurrentY)/MaxDiff, 0, 1) - 1) * MaxSleep)
} until GetKeyState(Key, "P") || GetKeyState("LButton", "P") || !WinActive("ahk_id" hwnd)

; enable the hotkey again
Hotkey, % Key, On
return

Limit(Var, Min, Max) {
	return (Var>Max?Max:(Var<Min?Min:Var))
}
