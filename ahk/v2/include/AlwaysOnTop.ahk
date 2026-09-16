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
WS_EX_TOOLWINDOW := 0x00000080
+MButton:: WinSetExStyle("^" . WS_EX_TOOLWINDOW, "A")
^MButton:: WinSetAlwaysOnTop(-1, "A")
