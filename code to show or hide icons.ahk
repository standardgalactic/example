SetTitleMatchMode 2
#SingleInstance ignore
#NoTrayIcon

; Win + Alt + D
!#D::
ControlGet, HWND, Hwnd,, SysListView321, ahk_class WorkerW

If DllCall("IsWindowVisible", UInt, HWND)
	WinHide, ahk_id %HWND%
Else
	WinShow, ahk_id %HWND%