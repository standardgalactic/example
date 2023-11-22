#SingleInstance Force
AHKTitle := "Image Variation Finder"

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetControlDelay -1

CoordMode, Mouse
Coordmode, pixel

	; variables 
	w := 250
	xOff := 10
	yOff := 20

	; step 1 
	Gui, Add, GroupBox, section w%w% h45, Step 1) Select the picture you want to search for
	Gui, Add, Button, % "xs+" xOff " ys+" yOff - 3 " wp-" xOff * 2 " gSelectImg vStep1", Browse

	; step 2 
	Gui, Add, GroupBox, % "xs section w" w " h65 vStep2a", Step 2) Search for Picture on Screen:
	Gui, Add, Button, % "xs+" xOff " ys+" yOff " gSearchImg vStep2b wp-" xOff * 2, Click here to minimize this program `nand start searching for the image

	; step 3 
	Gui, Add, Edit, % "xs+" xOff " w" w " vStep3", Make sure the image you're searching for is visible on screen!

	; hides step 2 + 3 
	GuiControl, Hide, Step2a
	GuiControl, Hide, Step2b
	GuiControl, HIde, Step3

	; displays GUI 
	Gui, Show, , %AHKTitle%
return

GuiClose:
ExitApp

SelectImg:
{
	FileSelectFile, ImgFile, Options, %A_WorkingDir%, Select a picture to search for
	; if user didn't select any pictures, do nothing. 
	IF (ErrorLevel = 1) 
		return 

	; if file selected doesn't have an extension...
	if !(ImgFile ~= "(.*?)\.(.{3,})")
	{
		MsgBox, 53, Error!, Please include both the name`n AND extension of the file!
		IfMsgBox, Retry
			Goto, SelectImg
		return
	}

	; splits the file path to get the filename 
	SplitPath, ImgFile, outName

	; show the second step 
	GuiControl, Show, Step2a
	GuiControl, Show, Step2b

	; sets keyboard on the next step 
	GuiControl, Focus, Step2b

	; shows tip 
	GuiControl, Show, Step3
	GuiControl, Disable, Step3

	; changes the text on the button to the name of the file. 
	GuiControl, Text, Step1, %outName%
	
	return
}

SearchImg:
{
	Gui, Submit, NoHide

	; if there's no image file, or if the extension is less than 3 characters...
	; probably overly redundant due to above if-check. 
	if (ImgFile = "") || !(ImgFile ~= "(.*?)\.(.*?){3,}")
	{
		; display an error message. 
		MsgBox, 1, Error!, Please select an image first! 
		
		; if the user selects "Ok"
		IfMsgBox, OK
			GoTo SelectImg
		return 
	}

	; Minimize the GUI 
	WinMinimize, %AHKTitle%
	; small wait window 
	Sleep, 500

	While (A_Index < 256)
	{
		; imagesearch through one variation at a time. From 0 to 255. 
		Imagesearch, outX, outY, 0, 0, A_ScreenWidth, A_ScreenHeight, *%A_Index% %ImgFile%
		If errorLevel = 0
		{
			if (A_Index = 255)
			{
				MsgBox Image could not be found on the screen. 
				return
			}

			Clipboard := ""
		    Clipboard := "Imagesearch, outX, outY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *" . A_Index . " " ImgFile . "`n"
		   				. "If errorLevel = 0" . "`n"
						. "{" . "`n"
						. "	`;~ MouseMove, " . OutX . ", " . OutY  . "`n"
						. "	MouseMove, %outX%, %outY%" . "`n"
						. "	`;~ MouseClick, Left, %outX%, %outY%" . "`n"
						. "}" . "`n"
						. "return " . "`n"
			ClipWait
			Sleep, -1

			VarString := "Image located at (" . OutX . ", " . OutY . ") with variation of (" . A_Index . ")"

			; moves the mouse there 
			MouseMove, %outX%, %outY%

			; re-activates the GUI 
			WinActivate, %AHKTitle%

			; Sets the text 
			GuiControl, Text, Step3, %VarString%
			GuiControl, Enable, Step3
			
			; displays tooltip 
			ToolTip, The code to search for this image in AHK is copied to your clipboard!`n`n%clipboard%

			; small wait before hiding tooltip 
			Sleep, 4000

			; hides tooltip 
			ToolTip
			break
		}
		If ErrorLevel = 1
			ToolTip, varrrr = %A_Index%
	}
	return
}

F11::Reload

^Esc::ExitApp