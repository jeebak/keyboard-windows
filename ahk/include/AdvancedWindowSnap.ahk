/**
 * Forked from: https://gist.github.com/AWMooreCO/1ef708055a11862ca9dc
 *
 * Advanced Window Snap
 * Snaps the Active Window to one of nine different window positions.
 *
 * @author Andrew Moore <andrew+github@awmoore.com>
 * @version 1.0
 */

/**
 * SnapActiveWindow resizes and moves (snaps) the active window to a given position.
 * @param {string} winPlaceVertical   The vertical placement of the active window.
 *                                    Expecting "bottom" or "middle", otherwise assumes
 *                                    "top" placement.
 * @param {string} winPlaceHorizontal The horizontal placement of the active window.
 *                                    Expecting "left" or "right", otherwise assumes
 *                                    window should span the "full" width of the monitor.
 * @param {string} winSizeHeight      The height of the active window in relation to
 *                                    the active monitor's height. Expecting "half" size,
 *                                    otherwise will resize window to a "third".
 */
SnapActiveWindow(winPlaceVertical, winPlaceHorizontal, winSizeHeight) {
    WinGet activeWin, ID, A
    activeMon := GetMonitorIndexFromWindow(activeWin)

    SysGet, MonitorWorkArea, MonitorWorkArea, %activeMon%

    ; ToolTip, Debug: %MonitorWorkAreaBottom% %MonitorWorkAreaTop% %MonitorWorkAreaRight% %MonitorWorkAreaLeft%
    ;                 1440                    40                   3440                   0

    if (winSizeHeight == "half") {
        height := (MonitorWorkAreaBottom - MonitorWorkAreaTop)/2
    } else if (winSizeHeight == "full") {
        height := (MonitorWorkAreaBottom - MonitorWorkAreaTop)
    } else {
        height := (MonitorWorkAreaBottom - MonitorWorkAreaTop)/3
    }

    if (winPlaceHorizontal == "left") {
        posX  := MonitorWorkAreaLeft
        width := (MonitorWorkAreaRight - MonitorWorkAreaLeft)/2
    } else if (winPlaceHorizontal == "right") {
        posX  := MonitorWorkAreaLeft + (MonitorWorkAreaRight - MonitorWorkAreaLeft)/2
        width := (MonitorWorkAreaRight - MonitorWorkAreaLeft)/2
    } else if (winPlaceHorizontal == "left-third") {
        posX  := MonitorWorkAreaLeft
        width := (MonitorWorkAreaRight - MonitorWorkAreaLeft)/3
    } else if (winPlaceHorizontal == "middle-third") {
        posX  := (MonitorWorkAreaRight - MonitorWorkAreaLeft)/3
        width := posX
    } else if (winPlaceHorizontal == "right-third") {
        posX  := MonitorWorkAreaLeft + (MonitorWorkAreaRight - MonitorWorkAreaLeft)/1.5
        width := (MonitorWorkAreaRight - MonitorWorkAreaLeft)/3
    } else if (winPlaceHorizontal == "one-fourth") {
        width := (MonitorWorkAreaRight - MonitorWorkAreaLeft)/4
        posX  := MonitorWorkAreaLeft
    } else if (winPlaceHorizontal == "two-fourth") {
        width := (MonitorWorkAreaRight - MonitorWorkAreaLeft)/4
        posX  := width
    } else if (winPlaceHorizontal == "three-fourth") {
        width := (MonitorWorkAreaRight - MonitorWorkAreaLeft)/4
        posX  := MonitorWorkAreaLeft + (MonitorWorkAreaRight - MonitorWorkAreaLeft)/2
    } else if (winPlaceHorizontal == "four-fourth") {
        width := (MonitorWorkAreaRight - MonitorWorkAreaLeft)/4
        posX  := MonitorWorkAreaRight - width
    } else {
        posX  := MonitorWorkAreaLeft
        width := MonitorWorkAreaRight - MonitorWorkAreaLeft
    }

    if (winPlaceVertical == "bottom") {
        posY := MonitorWorkAreaBottom - height
    } else if (winPlaceVertical == "middle") {
        posY := MonitorWorkAreaTop + height
    } else {
        posY := MonitorWorkAreaTop
    }

;   ToolTip, Debug: X: %posX% Y: %posY% W: %width% H: %height%

    WinMove,A,,%posX%,%posY%,%width%,%height%
}

/**
 * SnapWiarae takes current window resizing it to half and move up or down
 * @param {string} direction   Up or Down
 */
SnapWiarae(direction) {
    WinGet activeWin, ID, A
    activeMon := GetMonitorIndexFromWindow(activeWin)

    SysGet, MonitorWorkArea, MonitorWorkArea, %activeMon%

    ; ToolTip, Debug: %MonitorWorkAreaBottom% %MonitorWorkAreaTop% %MonitorWorkAreaRight% %MonitorWorkAreaLeft%
    ;                 1440                    40                   3440                   0

    height := (MonitorWorkAreaBottom - MonitorWorkAreaTop)/2

    if (direction == "up") {
        posY := MonitorWorkAreaTop
    } else if (direction == "down") {
        posY := MonitorWorkAreaBottom - height
    }

;   ToolTip, Debug: Y: %posY% H: %height%

    WinMove,A,,,%posY%,,%height%
}

/**
 * GetMonitorIndexFromWindow retrieves the HWND (unique ID) of a given window.
 * @param {Uint} windowHandle
 * @author shinywong
 * @link http://www.autohotkey.com/board/topic/69464-how-to-determine-a-window-is-in-which-monitor/?p=440355
 */
GetMonitorIndexFromWindow(windowHandle) {
    ; Starts with 1.
    monitorIndex := 1

    VarSetCapacity(monitorInfo, 40)
    NumPut(40, monitorInfo)

    if (monitorHandle := DllCall("MonitorFromWindow", "uint", windowHandle, "uint", 0x2))
        && DllCall("GetMonitorInfo", "uint", monitorHandle, "uint", &monitorInfo) {
        monitorLeft   := NumGet(monitorInfo,  4, "Int")
        monitorTop    := NumGet(monitorInfo,  8, "Int")
        monitorRight  := NumGet(monitorInfo, 12, "Int")
        monitorBottom := NumGet(monitorInfo, 16, "Int")
        workLeft      := NumGet(monitorInfo, 20, "Int")
        workTop       := NumGet(monitorInfo, 24, "Int")
        workRight     := NumGet(monitorInfo, 28, "Int")
        workBottom    := NumGet(monitorInfo, 32, "Int")
        isPrimary     := NumGet(monitorInfo, 36, "Int") & 1

        SysGet, monitorCount, MonitorCount

        Loop, %monitorCount% {
            SysGet, tempMon, Monitor, %A_Index%

            ; Compare location to determine the monitor index.
            if ((monitorLeft = tempMonLeft) and (monitorTop = tempMonTop)
                and (monitorRight = tempMonRight) and (monitorBottom = tempMonBottom)) {
                monitorIndex := A_Index
                break
            }
        }
    }

    return %monitorIndex%
}

; https://autohotkey.com/docs/Hotkeys.htm
; # Win, ! Alt, ^ Control, + Shift
; -----------------------------------------------------------------------------
; Control+Shift+Win
; -----------------------------------------------------------------------------
; Three rows
^+#7::SnapActiveWindow("top",       "full",         "third")
^+#8::SnapActiveWindow("middle",    "full",         "third")
^+#9::SnapActiveWindow("bottom",    "full",         "third")
; Three columns
^+#y::SnapActiveWindow("top",       "left-third",   "full")
^+#h::SnapActiveWindow("top",       "middle-third", "full")
^+#n::SnapActiveWindow("top",       "right-third",  "full")
; Two rows
^+#i::SnapActiveWindow("top",       "full",         "half")
^+#k::SnapActiveWindow("bottom",    "full",         "half")
; Two columns
^+#j::SnapActiveWindow("top",       "left",         "full")
^+#l::SnapActiveWindow("top",       "right",        "full")
; 4-corners
^+#u::SnapActiveWindow("top",       "left",         "half")
^+#o::SnapActiveWindow("top",       "right",        "half")
^+#m::SnapActiveWindow("bottom",    "left",         "half")
^+#.::SnapActiveWindow("bottom",    "right",        "half")
; Center
^+#,::SnapActiveWindow("top",       "full",         "full")
; Maximize
^+#;::SnapActiveWindow("top",       "full",         "full")
; -----------------------------------------------------------------------------
; Control+Shift+Alt
; -----------------------------------------------------------------------------
; Three columns (top half)
^+!j::SnapActiveWindow("top",       "left-third",   "half")
^+!k::SnapActiveWindow("top",       "middle-third", "half")
^+!l::SnapActiveWindow("top",       "right-third",  "half")
; Three columns (bottom half)
^+!m::SnapActiveWindow("bottom",    "left-third",   "half")
^+!,::SnapActiveWindow("bottom",    "middle-third", "half")
^+!.::SnapActiveWindow("bottom",    "right-third",  "half")
; Four columns
^+!u::SnapActiveWindow("top",       "one-fourth",   "full")
^+!i::SnapActiveWindow("top",       "two-fourth",   "full")
^+!o::SnapActiveWindow("top",       "three-fourth", "full")
^+!p::SnapActiveWindow("top",       "four-fourth",  "full")
; Current Width and Position Snapped Up/Down
^+!h::SnapWiarae("up")
^+!n::SnapWiarae("down")