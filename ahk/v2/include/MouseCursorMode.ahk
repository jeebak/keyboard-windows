#Requires AutoHotkey v2.0
; MouseCursor Mode: q+m pressed together toggles a mode where the keyboard
; drives the pointer. Windows counterpart of the "MouseCursor Mode" rule in
; the Karabiner personal_jeebak.json.
;
;   i / j / k / l   move up / left / down / right (a = faster, f = finer)
;   h / n / u / o   scroll up / down / left / right
;   Space / p / m   left / right / middle button (hold Space to drag)
;   ; / '           button 4 / 5
;   y               double-click
;   z / x / c / v   Ctrl+Z / X / C / V, then leave the mode
;   Esc / Enter     leave the mode (the real keys: a CapsLock-tap Esc is
;                   sent by AutoHotkey itself and never reaches these)
;
; Karabiner holds q and m back to spot the pair; here both are typed as
; usual and the chord then backspaces them (q+m inside a terminal editor
; will have acted on them first). While the mode is on, q is swallowed and m
; is the middle button, so to leave with q+m press q first; m first has
; already middle-clicked. Esc / Enter always work.
;
; While the mode is on, the Space chords, home-row and number-row modifiers
; step aside (they ask MouseCursorActive()), the way the Karabiner rules are
; gated on its mode variable. State lives in MouseCursorState() because an
; include's top-level assignments never run.

MouseCursorState() {
    static s := {on: false, down: Map(), consumed: Map(), held: Map()}
    return s
}

MouseCursorActive() {
    return MouseCursorState().on
}

; Map.Delete throws when the key is absent, and a release with no recorded
; press is normal here (every ordinary q or m typed while the mode is off).
MouseCursorForget(m, key) {
    if m.Has(key)
        m.Delete(key)
}

MouseCursorEnter() {
    s := MouseCursorState()
    s.on := true
    SetTimer(MouseCursorTick, 10)
    CoordMode "ToolTip", "Screen"
    ToolTip "MouseCursor Mode", A_ScreenWidth - 180, 8
}

MouseCursorExit() {
    s := MouseCursorState()
    s.on := false
    SetTimer(MouseCursorTick, 0)
    ToolTip()
    ; A button still held when the mode ends would otherwise stay down.
    for btn in ["Left", "Right", "Middle", "X1", "X2"] {
        if s.held.Has(btn)
            Click btn " Up"
    }
    s.held.Clear()
}

; Runs every 10ms while the mode is on: 8px per tick is 800px/s, x2 with a,
; x0.3 with f. Scrolling fires a notch every 5th tick (50ms).
MouseCursorTick() {
    static n := 0

    speed := 8
    if GetKeyState("a", "P")
        speed *= 2.0
    else if GetKeyState("f", "P")
        speed *= 0.3

    dx := (GetKeyState("l", "P") - GetKeyState("j", "P")) * speed
    dy := (GetKeyState("k", "P") - GetKeyState("i", "P")) * speed
    if dx || dy
        MouseMove(Round(dx), Round(dy), 0, "R")

    n += 1
    if n < 5
        return
    n := 0
    if GetKeyState("h", "P")
        Click "WheelUp"
    if GetKeyState("n", "P")
        Click "WheelDown"
    if GetKeyState("u", "P")
        Click "WheelLeft"
    if GetKeyState("o", "P")
        Click "WheelRight"
}

MouseCursorButton(btn, dir) {
    s := MouseCursorState()
    if dir = "Down" {
        if s.held.Has(btn)  ; auto-repeat
            return
        s.held[btn] := true
    } else {
        MouseCursorForget(s.held, btn)
    }
    Click btn " " dir
}

MouseCursorDoubleClick() {
    Click "Left"
    Click "Left"
}

MouseCursorCtrlKeyAndExit(key) {
    MouseCursorExit()
    Send "^" key
}

; q and m: called for the first press of each key, both while the mode is
; off (typed as usual, hence the backspaces) and while it is on.
MouseCursorTriggerDown(key) {
    s := MouseCursorState()
    if WinActive("ahk_exe mstsc.exe") || s.down.Has(key)
        return
    other := key = "q" ? "m" : "q"
    s.down[key] := A_TickCount
    if !s.down.Has(other) || A_TickCount - s.down[other] >= 50
        return

    ; Both keys belong to the chord until released, so their auto-repeat and
    ; release don't trigger anything.
    s.consumed["q"] := true
    s.consumed["m"] := true
    if s.on {
        MouseCursorExit()
    } else {
        Send "{BackSpace 2}"
        MouseCursorEnter()
    }
}

MouseCursorTriggerUp(key) {
    s := MouseCursorState()
    MouseCursorForget(s.down, key)
    MouseCursorForget(s.consumed, key)
}

MouseCursorMiddleDown() {
    s := MouseCursorState()
    if s.consumed.Has("m")
        return
    MouseCursorTriggerDown("m")
    if !s.consumed.Has("m")
        MouseCursorButton("Middle", "Down")
}

; Also the release of an m that opened the mode: its down was typed, so the
; hotkey that swallows this release must pass it on.
MouseCursorMiddleUp() {
    s := MouseCursorState()
    if s.consumed.Has("m")
        Send "{Blind}{m Up}"
    else
        MouseCursorButton("Middle", "Up")
    MouseCursorTriggerUp("m")
}

#HotIf MouseCursorActive()
*j:: return
*k:: return
*i:: return
*l:: return
*h:: return
*n:: return
*u:: return
*o:: return
*a:: return
*f:: return
*q:: MouseCursorTriggerDown("q")
*y:: MouseCursorDoubleClick()
*z:: MouseCursorCtrlKeyAndExit("z")
*x:: MouseCursorCtrlKeyAndExit("x")
*c:: MouseCursorCtrlKeyAndExit("c")
*v:: MouseCursorCtrlKeyAndExit("v")
*Escape:: MouseCursorExit()
*Enter:: MouseCursorExit()
*Space:: MouseCursorButton("Left", "Down")
*Space up:: MouseCursorButton("Left", "Up")
*p:: MouseCursorButton("Right", "Down")
*p up:: MouseCursorButton("Right", "Up")
*m:: MouseCursorMiddleDown()
*m up:: MouseCursorMiddleUp()
*`;:: MouseCursorButton("X1", "Down")
*`; up:: MouseCursorButton("X1", "Up")
*':: MouseCursorButton("X2", "Down")
*' up:: MouseCursorButton("X2", "Up")
#HotIf

; Trigger detection while the mode is off. ~ keeps q and m typing normally.
; While it is on, *q and *m above take over; q's release still lands here.
~*q:: MouseCursorTriggerDown("q")
~*m:: MouseCursorTriggerDown("m")
~*q up:: MouseCursorTriggerUp("q")
~*m up:: MouseCursorTriggerUp("m")
