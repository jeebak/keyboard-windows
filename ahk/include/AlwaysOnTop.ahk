; Use WinKey+A  for Always-On-Top of Active Window.
;   https://autohotkey.com/board/topic/53249-transparent-andor-always-on-top/?p=573906
#a:: WinSet, AlwaysOnTop, Toggle, A

; Sticky to all Desktops
;   https://superuser.com/questions/950960/pin-applications-to-multiple-desktops-in-windows-10
; Currently not working, so run:
;   WinKey-Tab, then: Show this window on all desktops
;
; Shift+middle click
; Control+middle click
WS_EX_TOOLWINDOW := 0x00000080
+MButton::WinSet, ExStyle, ^%WS_EX_TOOLWINDOW%, A
^MButton::WinSet, AlwaysOnTop, toggle, A