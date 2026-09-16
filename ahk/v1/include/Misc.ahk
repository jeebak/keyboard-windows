; Misc catch all AHK script

; Middle-click Paste
;   https://github.com/microsoft/terminal/issues/1553
#IfWinActive ahk_exe WindowsTerminal.exe
MButton::
  Send {LShift Down}{Insert}{LShift Up}
  Return
#If

; https://autohotkey.com/board/topic/53613-left-and-right-mouse-cord-middle-mouse-button/
~LButton & RButton::
MouseClick, Middle
Click up left
return

~RButton & LButton::
MouseClick, Middle
Click up right
return
