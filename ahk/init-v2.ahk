#Requires AutoHotkey v2.0
; Create shortcut to this file under: C:\Users\<YOURUSERNAME>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup

; # Win (Windows logo key)
; ! Alt
; ^ Control
; + Shift
; & An ampersand may be used between any two keys or mouse buttons to combine them into a custom hotkey.

; https://github.com/ahkscript/awesome-AutoHotkey
; https://autohotkey.com/docs/KeyList.htm
; ------------------------------------------------------------------------------
; https://stackoverflow.com/questions/15706534/hotkey-to-restart-autohotkey-script
#SingleInstance Force
InstallKeybdHook()
; #Persistent removed here -- v2 dropped the directive form entirely
; (Persistent() is a runtime function now), and it's unneeded anyway: v2
; auto-persists any script that responds to hotkeys, which this one does.
TraySetIcon("Shell32.dll", 25, 1)
TrayTip("Started", "AutoHotKey", 1)
SoundBeep(300, 150)
; Moved here from QuakeTerminal.ahk: any top-level statement in an
; #Include'd file is unreachable once an earlier #Include's own hotkeys
; have already ended the script's top-level execution flow, regardless of
; where the statement sits within its own file. Script-wide settings like
; these belong in the entry point for exactly this reason.
SendMode "Input"  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.
Return
; ------------------------------------------------------------------------------
#Include v2\include\AdvancedWindowSnap.ahk
#Include v2\include\AlwaysOnTop.ahk
#Include v2\include\CapsLockTapEscapeHoldControl.ahk
; #Include v2\include\Media.ahk
#Include v2\include\Screenshots.ahk
#Include v2\include\Spotlight.ahk
#Include v2\include\TabModifier.ahk
#Include v2\include\TouchCursor.ahk
#Include v2\include\QuakeTerminal.ahk
#Include v2\include\Misc.ahk
; ------------------------------------------------------------------------------
; LockWorkStation and turn monitor off
#+^Tab:: {
  Sleep 200
  DllCall("LockWorkStation")
  Sleep 1000

  ; Turn off monitor
  ; 0x112 == WM_SYSCOMMAND, 0xF170 == SC_MONITORPOWER
; SendMessage(0x112, 0xF170, 2, , "Program Manager")

  ; Sleep/Suspend:
  DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)

  ; Hibernate:
; DllCall("PowrProf\SetSuspendState", "int", 1, "int", 0, "int", 0)
}
; ------------------------------------------------------------------------------
; Reload this script (Ctrl+Win+Alt+R)
^#!r::Reload
