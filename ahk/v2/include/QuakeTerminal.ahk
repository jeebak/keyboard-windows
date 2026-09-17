#Requires AutoHotkey v2.0
; Based on: https://gist.github.com/andrewgodwin/89920ee02501ab12d09b02500897066c
; Simpler than: https://github.com/lonepie/mintty-quake-console

; #NoEnv removed here -- v2 always behaves as if it were set (no fallback
; to environment variables for blank vars), so the directive doesn't exist.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode "Input"  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.

; Alt-/
!/::ToggleTerminal()

ShowTerminal() {
    WinShow "ahk_class CASCADIA_HOSTING_WINDOW_CLASS"
    WinActivate "ahk_class CASCADIA_HOSTING_WINDOW_CLASS"
}

PositionTerminal(Fullscreen:=True)
{
    MonitorGetWorkArea(, &WorkAreaLeft, &WorkAreaTop, &WorkAreaRight, &WorkAreaBottom)
    ; MsgBox("Left: " WorkAreaLeft " -- Top: " WorkAreaTop " -- Right: " WorkAreaRight " -- Bottom " WorkAreaBottom ".")

    ; MsgBox("A_ScreenHeight: " A_ScreenHeight " -- A_ScreenWidth: " A_ScreenWidth)
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

    ; Fudge factor for my current monitor
    Fudge := 9

    Width := Width + 2 * Fudge
    Height := Height + Fudge
    X := X - Fudge

    ; WinMove(X, Y, Width, Height, WinTitle, WinText, ExcludeTitle, ExcludeText)
    WinMove(X, Y, Width, Height, "ahk_class CASCADIA_HOSTING_WINDOW_CLASS")
}

ToggleTerminal()
{
    WinMatcher := "ahk_class CASCADIA_HOSTING_WINDOW_CLASS"

    DetectHiddenWindows true

    if WinExist(WinMatcher)
    ; Window Exists
    {
        ; This was causing weirdness in virtual desktops
        ; DetectHiddenWindows false

        ; Check if its hidden
        if !WinExist(WinMatcher) || !WinActive(WinMatcher)
        {
            ShowTerminal()
        }
        else if WinExist(WinMatcher)
        {
            ; Script sees it without detecting hidden windows, so..
            WinHide "ahk_class CASCADIA_HOSTING_WINDOW_CLASS"
            Send "!{Esc}"
        }
    }
    else
    {
        ; There doesn't seem to be a A_LocalAppData built-in variable
        wt_exe := "C:\Users\" A_UserName "\AppData\Local\Microsoft\WindowsApps\wt.exe"
        Run wt_exe
        Sleep 1000
        PositionTerminal()
        ShowTerminal()
    }
}
