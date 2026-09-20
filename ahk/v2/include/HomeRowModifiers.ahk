#Requires AutoHotkey v2.0
; Home Row Modifiers: the right-pinky ; and ' keys type themselves when
; tapped and act as Ctrl / Alt when held. Windows counterpart of the
; "Home Row Modifiers" rule in the Karabiner personal_jeebak.json, where
; ; holds as Cmd and ' as Option; Ctrl and Alt are what Windows apps use
; for those shortcuts.
;
; The hold engages after 200ms. Another key pressed inside that window
; cancels the hold and types the tap first, so fast rollover ("let's")
; isn't swallowed -- an instant hold eats the ' there. InputHook holds the
; other key back just long enough to type the tap before it. {All} leaves
; out modifier keys, so a held Shift still reaches the tap (Shift+; -> :).
;
; State lives in HomeRowState() because a hotkey definition ends v2's
; top-level flow, so an include's own top-level assignments never run.

HomeRowState() {
    static st := Map()
    return st
}

; Off inside a Space/Tab chord so Space & ; and friends keep working, in
; Remote Desktop, where the remote side owns the modifiers, and in
; MouseCursor Mode, where ; and ' are mouse buttons.
HomeRowCanStart() {
    return !GetKeyState("Space", "P") && !GetKeyState("Tab", "P")
        && !WinActive("ahk_exe mstsc.exe") && !MouseCursorActive()
}

; The release handler is gated on tracking, not on HomeRowCanStart(), so a
; Space pressed while a modifier is held can't strand the modifier down.
HomeRowTracking(sc) {
    return HomeRowState().Has(sc)
}

HomeRowOtherDown(s, ih, vk, sc) {
    s.keys.Push({vk: vk, up: false})
    ih.Stop()
}

HomeRowOtherUp(s, ih, vk, sc) {
    for k in s.keys {
        if k.vk = vk && !k.up {
            k.up := true
            break
        }
    }
}

HomeRowDown(sc, holdKey) {
    st := HomeRowState()
    if st.Has(sc)  ; auto-repeat of a press already being tracked
        return

    ih := InputHook("L0 T0.2")
    s := {phase: "pending", released: false, keys: [], ih: ih}
    st[sc] := s

    ih.KeyOpt("{All}", "+NS")
    ih.KeyOpt("{" sc "}", "-NS")  ; own key: the up hotkey handles its release
    ih.OnKeyDown := HomeRowOtherDown.Bind(s)
    ih.OnKeyUp := HomeRowOtherUp.Bind(s)
    ih.Start()
    ih.Wait()

    ; The up hotkey can fire the instant the timeout does; keep the
    ; decision below atomic against it.
    Critical

    if s.released || s.keys.Length {
        st.Delete(sc)
        Send "{Blind}{" sc "}"
        for k in s.keys {
            hex := Format("{:X}", k.vk)
            Send "{Blind}{vk" hex " down}"
            if k.up
                Send "{Blind}{vk" hex " up}"
        }
        return
    }

    s.phase := "held"
    Send "{Blind}{" holdKey " Down}"
}

HomeRowUp(sc, holdKey) {
    st := HomeRowState()
    if !st.Has(sc)
        return
    s := st[sc]

    if s.phase = "pending" {
        ; Released inside the window: HomeRowDown types the tap.
        s.released := true
        s.ih.Stop()
        return
    }

    ; vkE8 is an unassigned key; sent between Alt down and up it stops the
    ; release from being read as a bare Alt tap (menu-bar focus).
    st.Delete(sc)
    Send "{Blind}{vkE8}{" holdKey " Up}"
}

#HotIf HomeRowCanStart()
*;:: HomeRowDown("SC027", "LCtrl")
*':: HomeRowDown("SC028", "LAlt")

#HotIf HomeRowTracking("SC027")
*; up:: HomeRowUp("SC027", "LCtrl")

#HotIf HomeRowTracking("SC028")
*' up:: HomeRowUp("SC028", "LAlt")

#HotIf
