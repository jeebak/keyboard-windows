#Requires AutoHotkey v2.0
; Tab key as Modifier

; "Hyper"
$Tab:: {
  global tDown
  Send "{Blind}{Alt Down}{Ctrl Down}{Shift Down}"
  tDown := A_TickCount
}

$Tab up:: {
  global tDown
  if (A_TickCount - tDown) < 200  ; Modify press time as needed (milliseconds)
    Send "{Blind}{Alt Up}{Ctrl Up}{Shift Up}{Tab}"
  else
    Send "{Blind}{Alt Up}{Ctrl Up}{Shift Up}"
}
