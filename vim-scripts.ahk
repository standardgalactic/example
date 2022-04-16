#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;; Example new autohotkey script ;;
;; vim commands that turn off and on with windows+v

#v::
Suspend
Return

!v::Run, notepad.exe "C:\Users\Mechachleopteryx\OneDrive\Desktop\Blank\Examples\vim-scripts.ahk" ; press Alt+v to open this file.

;; next document in vim ;;
::0:::n!
Return
::ozz::cd projects/zet  ;;Open Zettelkasten pleaZ

::read all::vim */READ*

::nobell::set vb t_vb=

::test::THE thousand injuries of Fortunato I had borne as I best could, but when he ventured upon insult I vowed revenge. ... A wrong is unredressed when retribution overtakes its redresser. It is equally unredressed when the avenger fails to make himself felt as such to him who has done the wrong.

