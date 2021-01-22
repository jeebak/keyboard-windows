; Based on: https://gist.github.com/andrewgodwin/89920ee02501ab12d09b02500897066c
; Simpler than: https://github.com/lonepie/mintty-quake-console

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Alt-/
!/::ToggleTerminal()

ShowAndPositionTerminal(Fullscreen:=True)
{
    WinShow ahk_class CASCADIA_HOSTING_WINDOW_CLASS
    WinActivate ahk_class CASCADIA_HOSTING_WINDOW_CLASS

    SysGet, WorkArea, MonitorWorkArea
    ; MsgBox, Left: %WorkAreaLeft% -- Top: %WorkAreaTop% -- Right: %WorkAreaRight% -- Bottom %WorkAreaBottom%.

    ; MsgBox, A_ScreenHeight: %A_ScreenHeight% -- A_ScreenWidth: %A_ScreenWidth%
    if Fullscreen {
        X := 0
        Y := WorkAreaTop - 2
        Width := A_ScreenWidth
        Height := A_ScreenHeight - WorkAreaTop + 2
    } else {
        TerminalWidth := A_ScreenWidth * 0.9
        if (A_ScreenWidth / A_ScreenHeight) > 1.5 {
            TerminalWidth := A_ScreenWidth * 0.6
        }

        X := (A_ScreenWidth - TerminalWidth) / 2
        Y := WorkAreaTop - 2
        Width := TerminalWidth
        Height := A_ScreenHeight * 0.5
    }

    ; WinMove, WinTitle, WinText, X, Y , Width, Height, ExcludeTitle, ExcludeText
    WinMove, ahk_class CASCADIA_HOSTING_WINDOW_CLASS,, X, Y, Width, Height,,
}

ToggleTerminal()
{
    WinMatcher := "ahk_class CASCADIA_HOSTING_WINDOW_CLASS"

    DetectHiddenWindows, On

    if WinExist(WinMatcher)
    ; Window Exists
    {
        ; This was causing weirdness in virtual desktops
        ; DetectHiddenWindows, Off

        ; Check if its hidden
        if !WinExist(WinMatcher) || !WinActive(WinMatcher)
        {
            ShowAndPositionTerminal()
        }
        else if WinExist(WinMatcher)
        {
            ; Script sees it without detecting hidden windows, so..
            WinHide ahk_class CASCADIA_HOSTING_WINDOW_CLASS
            Send !{Esc}
        }
    }
    else
    {
        ; There doesn't seem to be a A_LocalAppData built-in variable
        wt_exe := "C:\Users\" A_UserName "\AppData\Local\Microsoft\WindowsApps\wt.exe"
        Run, %wt_exe%
        Sleep, 1000
        ShowAndPositionTerminal()
    }
}
