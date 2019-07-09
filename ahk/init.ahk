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
; LockWorkStation and turn monitor off
#+^Tab::
{
  Sleep, 200
  DllCall("LockWorkStation")
  Sleep, 1000

  ; Turn off monitor
  ; 0x112 == WM_SYSCOMMAND, 0xF170 == SC_MONITORPOWER
; SendMessage,0x112,0xF170,2,,Program Manager

  ; Sleep/Suspend:
  DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)

  ; Hibernate:
; DllCall("PowrProf\SetSuspendState", "int", 1, "int", 0, "int", 0)

  Return
}
Return
; ------------------------------------------------------------------------------
; Reload this script
Tab & q::
  MsgBox,,,Reloading %A_ScriptName%, 2
  Reload
