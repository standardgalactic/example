/*
This AutoHotkey script is designed to facilitate reading subtitles along with a movie in Vim, a popular text editor.
It allows the user to page forward and backward within the Vim editor, making it easier to synchronize text (like subtitles) with the movie playback.
The script can be toggled on and off with Alt+I, which activates or deactivates special hotkeys:

- Pressing 'F' sends Ctrl+F to Vim, moving forward one full screen (page down).
- Pressing 'B' sends Ctrl+B to Vim, moving back one full screen (page up).
*/

#NoTrayIcon              ;if you don't want a tray icon for this AutoHotkey program.
#NoEnv                   ;Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force    ;Skips the dialog box and replaces the old instance automatically
;;SendMode Input           ;I discovered this causes MouseMove to jump as if Speed was 0. (was Recommended for new scripts due to its superior speed and reliability.)
SetKeyDelay, 90          ;Any number you want (milliseconds)
CoordMode,Mouse,Screen   ;Initial state is Relative
CoordMode,Pixel,Screen   ;Initial state is Relative. Frustration awaits if you set Mouse to Screen and then use GetPixelColor because you forgot this line. There are separate ones for: Mouse, Pixel, ToolTip, Menu, Caret
MouseGetPos, xpos, ypos  ;Save initial position of mouse
WinGet, SavedWinId, ID, A     ;Save our current active window

;Set Up a Log File:
SetWorkingDir, %A_ScriptDir%  ;Set default directory to where this script file is located. (Note %% because it's expecting an unquoted string)
LogFile := "MyLog.txt"
FileAppend,    `n, %LogFile%  ;     ``. (Note %% because it's expecting an unquoted string)

#Persistent
Toggle := False

!i:: ; Alt+i to toggle the script on and off
    Toggle := !Toggle
    If (Toggle)
        Tooltip, Hotkey Script Activated
    Else
        Tooltip, Hotkey Script Deactivated
    SetTimer, RemoveTooltip, 1500 ; Show tooltip for 1.5 seconds
return

RemoveTooltip:
    SetTimer, RemoveTooltip, Off
    Tooltip
return

#If (Toggle) ; The following hotkeys work only when Toggle is True

    f:: ; When F is pressed
        Send, ^f ; Send Ctrl+F
    return

    b:: ; When B is pressed
        Send, ^b ; Send Ctrl+B
    return

#If ; End of conditional hotkeys

