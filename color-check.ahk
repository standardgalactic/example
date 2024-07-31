#Persistent  ; Keeps the script running

Gui, New  ; Create a new GUI window
Gui, Color, Blue  ; Set the initial GUI window's background color to blue
Gui, Add, Text, w320 h220 gToggleColor  ; Add a large Text control to capture clicks
Gui, Show, w320 h220, Click to Toggle Color  ; Show the GUI window

isBlue := true  ; Boolean to track color state

ToggleColor:
    if (isBlue)
    {
        Gui, Color, Green  ; Change the background color to green
        isBlue := false  ; Update the color state
    }
    else
    {
        Gui, Color, Blue  ; Change the background color back to blue
        isBlue := true  ; Update the color state
    }
return

GuiClose:
    ExitApp  ; Close the application when GUI is closed
return
