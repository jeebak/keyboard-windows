#Requires AutoHotkey v2.0
; Use WinKey+A  for Always-On-Top of Active Window.
;   https://autohotkey.com/board/topic/53249-transparent-andor-always-on-top/?p=573906

#a:: WinSetAlwaysOnTop(-1, "A")

; Sticky to all Desktops
;   https://superuser.com/questions/950960/pin-applications-to-multiple-desktops-in-windows-10
; Currently not working, so run:
;   WinKey-Tab, then: Show this window on all desktops
;
; Shift+middle click
; Control+middle click
; 0x80 = WS_EX_TOOLWINDOW, inlined rather than a top-level constant: once
; this file is #Include'd after another file whose own hotkeys come first
; (ahk/init-v2.ahk does exactly this), a top-level statement here is
; unreachable regardless of where it sits *within this file* -- reaching
; any hotkey anywhere earlier in the assembled script already ended v2's
; top-level execution flow. A literal has no such reachability dependency.
+MButton:: WinSetExStyle("^" . 0x80, "A")
^MButton:: WinSetAlwaysOnTop(-1, "A")
