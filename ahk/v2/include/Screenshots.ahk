#Requires AutoHotkey v2.0
; Mac-like screenshots bindings, mapped for Greenshot

; Select window
!+2:: Send "{AltDown}{PrintScreen}{AltUp}}"

; Entire screen
!+3:: Send "{CtrlDown}{PrintScreen}{CtrlUp}"

; Select area
!+4:: Send "{PrintScreen}"
