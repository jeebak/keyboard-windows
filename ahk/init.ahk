; Create shortcut to this file under: C:\Users\<YOURUSERNAME>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup

; # Win (Windows logo key)
; ! Alt
; ^ Control
; + Shift
; & An ampersand may be used between any two keys or mouse buttons to combine them into a custom hotkey.

; https://github.com/ahkscript/awesome-AutoHotkey
; https://autohotkey.com/docs/KeyList.htm

#Include include\AdvancedWindowSnap.ahk
#Include include\AlwaysOnTop.ahk
#Include include\CapsLockTapEscapeHoldControl.ahk
; #Include include\Media.ahk
#Include include\Screenshots.ahk
#Include include\Spotlight.ahk
#Include include\TabModifier.ahk
#Include include\TouchCursor.ahk
; ------------------------------------------------------------------------------
; Custom "Mission Control"
^!;::
  Send,^#{left}
Return

^!'::
  Send,^#{right}
Return

^!p::
  Send,#{tab}
Return

#+^Tab::
  Send,#l
Return
; ------------------------------------------------------------------------------
