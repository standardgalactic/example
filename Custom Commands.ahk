#Persistent  ; Keeps the script running
SetTimer, ChangeBrightness, 2000  ; Adjust the brightness every 2000 milliseconds (2 seconds)

currentBrightness := 50  ; Start at a mid-range brightness level
delta := 10  ; Amount to increase or decrease brightness

ChangeBrightness:
    ; Adjust brightness
    currentBrightness := currentBrightness + delta
    
    ; Reverse direction if reaching limits
    if (currentBrightness >= 100 or currentBrightness <= 10)
    {
        delta := -delta
    }

    ; Command to change brightness (using DDC/CI command via NirCmd)
    Run, nircmd.exe setbrightness %currentBrightness%
return
