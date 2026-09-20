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
TraySetIcon("Shell32.dll", 25, 1)
TrayTip("Started", "AutoHotKey", 1)
SoundBeep(300, 150)
; Script-wide setup must run before any hotkey is defined -- reaching a
; hotkey ends v2's top-level execution flow, so anything here has to run
; before the #Include'd files' own hotkeys do.
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
#Include v2\include\HomeRowModifiers.ahk
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
