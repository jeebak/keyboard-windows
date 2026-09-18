#Requires AutoHotkey v2.0
; Tab as a chord-prefix key (same pattern as Space in TouchCursor.ahk)

; Tab+t -> repeatable Tab
Tab & t:: Send "{Tab}"

; Tab+v -> Ditto's own default hotkey (Ctrl+`), since Ditto listens for
; that rather than a raw keypress. No-op on machines where Ditto isn't
; running (this script runs on more than one).
Tab & v:: {
  if ProcessExist("Ditto.exe")
    Send "{Ctrl Down}``{Ctrl Up}"
}

Tab:: Send "{Tab}"
