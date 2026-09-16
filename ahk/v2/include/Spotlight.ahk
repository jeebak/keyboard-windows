#Requires AutoHotkey v2.0
; ------------------------------------------------------------------------------
; https://autohotkey.com/board/topic/47476-problem-with-remapping-altspace-to-winkey/
!Space:: Send "^{Esc}"

; Map Alt-; to System Menu
!;:: {
  Hotkey("!Space", , "Off")
  Send "!{Space}"
  ih := InputHook("L1")
  ih.Start()
  ih.Wait()
  Hotkey("!Space", , "On")
}
