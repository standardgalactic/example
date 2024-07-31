#Persistent
SetTimer, ToggleMute, 4000  ; Toggle mute every 4000 milliseconds (4 seconds)

ToggleMute:
    ; Toggle system mute status
    Run, nircmd.exe mutesysvolume 2
return
