; Mac-like screenshots bindings, mapped for Greenshot

; Select window
!+2::
  Send,{AltDown}{PrintScreen}{AltUp}}
Return

; Entire screen
!+3::
  Send,{CtrlDown}{PrintScreen}{CtrlUp}
Return

; Select area
!+4::
  Send, {PrintScreen}
Return