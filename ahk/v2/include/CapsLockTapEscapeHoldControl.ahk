#Requires AutoHotkey v2.0
; https://superuser.com/questions/581692/remap-caps-lock-in-windows-escape-and-control
;   Switched from SharpKeys remapping of CapsLock to Ctrl to this
*CapsLock:: {
  global cDown
  Send "{Blind}{Ctrl Down}"
  cDown := A_TickCount
}

*CapsLock up:: {
  global cDown
  if (A_TickCount - cDown) < 200  ; Modify press time as needed (milliseconds)
    Send "{Blind}{Ctrl Up}{Esc}"
  else
    Send "{Blind}{Ctrl Up}"
}
