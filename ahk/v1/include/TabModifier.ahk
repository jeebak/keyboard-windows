; Tab key as Modifier

; "Hyper"
$Tab::
  Send {Blind}{Alt Down}{Ctrl Down}{Shift Down}
  tDown := A_TickCount
Return

$Tab up::
  If ((A_TickCount-tDown)<200)  ; Modify press time as needed (milliseconds)
    Send {Blind}{Alt Up}{Ctrl Up}{Shift Up}{Tab}
  Else
    Send {Blind}{Alt Up}{Ctrl Up}{Shift Up}
Return