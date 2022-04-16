;#NoTrayIcon              ;if you don't want a tray icon for this AutoHotkey program.
#NoEnv                   ;Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force    ;Skips the dialog box and replaces the old instance automatically
;;SendMode Input           ;I discovered this causes MouseMove to jump as if Speed was 0. (was Recommended for new scripts due to its superior speed and reliability.)
SetKeyDelay, 90          ;Any number you want (milliseconds)
CoordMode,Mouse,Screen   ;Initial state is Relative
CoordMode,Pixel,Screen   ;Initial state is Relative. Frustration awaits if you set Mouse to Screen and then use GetPixelColor because you forgot this line. There are separate ones for: Mouse, Pixel, ToolTip, Menu, Caret
MouseGetPos, xpos, ypos  ;Save initial position of mouse
WinGet, SavedWinId, ID, A     ;Save our current active window

;; Control-Alt-g
;; open standardgalactic github repository


Gui, Add, Edit, vMySearch
Gui, Add, Button, Default gSearch, Search
Return

^!g::
  Gui, Show
Return

Search:
  Gui, Submit, Nohide
  Run, http://github.com/standardgalactic/%MySearch%
Return