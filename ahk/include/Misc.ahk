; Misc catch all AHK script

; Middle-click Paste
;   https://github.com/microsoft/terminal/issues/1553
#IfWinActive ahk_exe WindowsTerminal.exe
MButton::
  Send {LShift Down}{Insert}{LShift Up}
  Return