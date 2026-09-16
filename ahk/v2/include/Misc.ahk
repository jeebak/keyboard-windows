#Requires AutoHotkey v2.0
; Misc catch all AHK script

; Middle-click Paste
;   https://github.com/microsoft/terminal/issues/1553
#HotIf WinActive("ahk_exe WindowsTerminal.exe")
MButton:: Send "{LShift Down}{Insert}{LShift Up}"
#HotIf

; https://autohotkey.com/board/topic/53613-left-and-right-mouse-cord-middle-mouse-button/
~LButton & RButton:: {
  MouseClick("Middle")
  Click("Up Left")
}

~RButton & LButton:: {
  MouseClick("Middle")
  Click("Up Right")
}
