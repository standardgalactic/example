#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;; forward slash to help ;;
;:*:/::help    

;; infinite ;;
/*  
{                                                                                                                                                                                                     
Loop
{
Sleep, 2
Send, {Space}
}
}
*/

/*                                                                              
!f:: 
If State=120
State=Off
else
State=120
SetTimer SendSpace, %State%
;Return ;uncoment if you don't want to send instantly

SendSpace:
Send {Space} ;; let's hope this works...
Return
*/
                                                                                                                                                                                                          
                                                                                                                                                                                                                                                                                                
;Send {Space} ;; let's hope this works...           ; next slide

;BreakLoop=9999
;a::BreakLoop=9999
                                                                                                                                                                                                                                                                                                                    
SetTimer, Loop, 1

s::BreakLoop=1
                                                                    
Loop:
Loop {
  if ( BreakLoop = 1 )
    exitApp
    Send {Space}
 ;; MsgBox Hello
  Sleep 1100 
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
/*
lar
*/


;; cistercian ;;   

                     
     


;; may interfere with Alt+x to convert unicode in libreoffice.. 533<alt>x

;; deploy / denounce script ;;
;; s::Suspend ; Press s to suspend, and         s again to resume ;; didn't work.
^!s:: Suspend   ;; windows cuit close autospace
