#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



#j::

SysGet, VirtualScreenWidth, 78
SysGet, VirtualScreenHeight, 79
SysGet, VirtualScreenLeft, 76
SysGet, VirtualScreenTop, 77
;msgbox , ,, VirtualScreen upper_left is %VirtualScreenLeft% %VirtualScreenTop%, 3
;msgbox , ,, VirtualScreen size is %VirtualScreenWidth% %VirtualScreenHeight%, 3

Loop 34 {
	ImageSearch, OutputVarX, OutputVarY, %VirtualScreenLeft%, %VirtualScreenTop%, %VirtualScreenWidth%, %VirtualScreenHeight%, *5 C:\Users\Mechachleopteryx\OneDrive\Pictures\bear.bmp
	if ErrorLevel = 2
		MsgBox Could not conduct the search.
	else if ErrorLevel = 1
	{
		MsgBox , 64,, ENABLED could not be found on the screen., 2
		;SoundBeep, 6000, 2000		; Play a higher pitch for 3 seconds.
		;ExitApp
	}
	else
	{	OutputVarX := OutputVarX + 20
		OutputVarY := OutputVarY + 20
		MsgBox , 64,, The icon was found at  %OutputVarX% x %OutputVarY%., 1
		MouseMove, OutputVarX, OutputVarY
		Click OutputVarX, OutputVarY	
		Sleep 1000
		Send {Enter}
		Sleep 1000
		Send {Enter}
	}

	; 图像搜索
	ImageSearch, OutputVarX, OutputVarY, %VirtualScreenLeft%, %VirtualScreenTop%, %VirtualScreenWidth%, %VirtualScreenHeight%, *50 c:\docx\youerweisheng_resize.bmp

	if ErrorLevel = 2
		MsgBox Could not conduct the search.
	else if ErrorLevel = 1
	{
		MsgBox , 64,, RESIZE could not be found on the screen., 2
		;SoundBeep, 750, 3000		; Play a higher pitch for 3 seconds.
		;ExitApp
	}
	else
	{	OutputVarX := OutputVarX + 10
		OutputVarY := OutputVarY + 10
		; MsgBox The icon was found at  %OutputVarX% x %OutputVarY%.
		Click %OutputVarX%, %OutputVarY%		; Click to Bring On
		Sleep 1000 * 3
	}
	
	ImageSearch, OutputVarX, OutputVarY, %VirtualScreenLeft%, %VirtualScreenTop%, %VirtualScreenWidth%, %VirtualScreenHeight%, *50 c:\docx\timeupdatebutton.bmp
	if ErrorLevel = 2 
	{
		MsgBox Could not conduct the search.
		;ExitApp
	}
	else if ErrorLevel = 1 
	{
		MsgBox , 64,, TIMEUPDATE could not be found on the screen., 2
		;SoundBeep, 750, 500		; Play a higher pitch for 1.5 seconds.
		;ExitApp
	}
	else
	{	
		OutputVarX := OutputVarX + 20
		OutputVarY := OutputVarY + 20
		MsgBox , 64,, The TIMEUPDATE was found at  %OutputVarX% x %OutputVarY%., 1
		;Mousemove, OutputVarX, OutputVarY
		Sleep 1000 * 60 * 11
		Click %OutputVarX%, %OutputVarY%	
		Sleep 1000
		Send {Enter}
		Sleep 1000
		Send {Enter}
		Sleep 1000 * 3		; paused for 3 seconds
	}
}

Return