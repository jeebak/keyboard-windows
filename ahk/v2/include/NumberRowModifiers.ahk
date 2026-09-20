#Requires AutoHotkey v2.0
; Number Row Modifiers: the number row types its digit when tapped and acts
; as a modifier when held -- 4-9 as Ctrl, 1-3 / 0 / - / = as Alt. Windows
; counterpart of the "Number Row Modifiers" rule in the Karabiner
; personal_jeebak.json, where the holds are Cmd and Option.
;
; The modifier engages the instant the key goes down (Karabiner's 0ms hold
; threshold), so whatever is pressed while it's held is chorded with it. A
; release inside 300ms with nothing else pressed types the digit instead.
; Shift+<key> skips all of this so symbols (! @ # ...) type without delay.
;
; Unlike ; and ' (HomeRowModifiers.ahk) there is no delay window: chording
; instantly is the point of this rule, at the cost of a rolled pair of digits
; reading as a chord. State lives in NumberRowState() for the same reason as
; there: an include's top-level assignments never run.

NumberRowState() {
    static st := Map()
    return st
}

; Off inside a Space/Tab chord (Space & 1 is F1), in Remote Desktop, and
; while Ctrl, Alt or Win is down, so Ctrl+1 tab switching and the Win/Alt
; snap and screenshot hotkeys on number keys reach their own handlers.
NumberRowCanStart() {
    return !GetKeyState("Space", "P") && !GetKeyState("Tab", "P")
        && !GetKeyState("Ctrl") && !GetKeyState("Alt")
        && !GetKeyState("LWin") && !GetKeyState("RWin")
        && !WinActive("ahk_exe mstsc.exe")
}

NumberRowAnyTracking() {
    return NumberRowState().Count > 0
}

; A click or scroll while the key is held is a chord too, so releasing it
; afterwards must not also type the digit.
NumberRowMarkChorded() {
    for , s in NumberRowState()
        s.chorded := true
}

NumberRowKeyDown(s, ih, vk, sc) {
    s.chorded := true
}

NumberRowDown(key, holdKey) {
    st := NumberRowState()
    if st.Has(key) {
        ; Auto-repeat: only the Shift bypass repeats, like a plain key.
        if st[key].bypass
            Send "{Blind}{" key " Down}"
        return
    }

    if GetKeyState("Shift", "P") {
        st[key] := {bypass: true}
        Send "{Blind}{" key " Down}"
        return
    }

    ; V keeps the watcher from swallowing the keys it is only observing.
    ih := InputHook("V L0")
    s := {bypass: false, chorded: false, t: A_TickCount, ih: ih}
    st[key] := s

    ih.KeyOpt("{All}", "+N")
    ih.KeyOpt("{" key "}", "-N")  ; its own auto-repeat is not a chord
    ih.OnKeyDown := NumberRowKeyDown.Bind(s)
    ih.Start()
    Send "{Blind}{" holdKey " Down}"
}

NumberRowUp(key, holdKey) {
    st := NumberRowState()
    if !st.Has(key)
        return
    s := st[key]
    st.Delete(key)

    if s.bypass {
        Send "{Blind}{" key " Up}"
        return
    }

    s.ih.Stop()
    ; vkE8 is an unassigned key; sent between Alt down and up it stops the
    ; release from being read as a bare Alt tap (menu-bar focus).
    Send "{Blind}{vkE8}{" holdKey " Up}"
    if !s.chorded && A_TickCount - s.t < 300
        Send "{Blind}{" key "}"
}

; Hotkeys are named by key, not scan code, so they share a table with the
; Space & <key> chords in TouchCursor.ahk (an SC hotkey shadows those).
; = is spelled vkBB because *=:: reads as the *= operator.
#HotIf NumberRowCanStart()
*1:: NumberRowDown("1", "LAlt")
*2:: NumberRowDown("2", "LAlt")
*3:: NumberRowDown("3", "LAlt")
*4:: NumberRowDown("4", "LCtrl")
*5:: NumberRowDown("5", "LCtrl")
*6:: NumberRowDown("6", "LCtrl")
*7:: NumberRowDown("7", "LCtrl")
*8:: NumberRowDown("8", "LCtrl")
*9:: NumberRowDown("9", "LCtrl")
*0:: NumberRowDown("0", "LAlt")
*-:: NumberRowDown("-", "LAlt")
*vkBB:: NumberRowDown("vkBB", "LAlt")
#HotIf

; Release handlers are ungated and pass the native key-up through (~), so a
; key that was never tracked can't have its release swallowed.
~*1 up:: NumberRowUp("1", "LAlt")
~*2 up:: NumberRowUp("2", "LAlt")
~*3 up:: NumberRowUp("3", "LAlt")
~*4 up:: NumberRowUp("4", "LCtrl")
~*5 up:: NumberRowUp("5", "LCtrl")
~*6 up:: NumberRowUp("6", "LCtrl")
~*7 up:: NumberRowUp("7", "LCtrl")
~*8 up:: NumberRowUp("8", "LCtrl")
~*9 up:: NumberRowUp("9", "LCtrl")
~*0 up:: NumberRowUp("0", "LAlt")
~*- up:: NumberRowUp("-", "LAlt")
~*vkBB up:: NumberRowUp("vkBB", "LAlt")

#HotIf NumberRowAnyTracking()
~*LButton:: NumberRowMarkChorded()
~*RButton:: NumberRowMarkChorded()
~*MButton:: NumberRowMarkChorded()
~*WheelUp:: NumberRowMarkChorded()
~*WheelDown:: NumberRowMarkChorded()
#HotIf
