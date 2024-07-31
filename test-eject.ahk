#Persistent
SetTimer, OpenCloseCDTray, 6000  ; Open and close CD tray every 6000 milliseconds (6 seconds)

OpenCloseCDTray:
    ; Open the CD tray
    Run, nircmd.exe cdrom open
    Sleep, 3000  ; Wait for 3 seconds
    ; Close the CD tray
    Run, nircmd.exe cdrom close
return
