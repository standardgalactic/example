;menu Toggle Fullscreen
#SingleInstance, Force
x:=Studio()
WinGet, style, Style, % x.hwnd([1])
WinSet, Style, % (SubStr(style,5,1)="C"?"-":"+") "0xC00000", % x.hwnd([1])
ExitApp
