#Requires AutoHotkey v2.0
; AHK script implementing TouchCursor
;   http://martin-stone.github.io/touchcursor/
;   https://autohotkey.com/boards/viewtopic.php?t=6525

; Suppress the whole Space-chord layer during an active Remote Desktop
; session so Space reaches the remote host unmodified.
#HotIf !WinActive("ahk_exe mstsc.exe")

; Function keys
Space & 1:: Send "{F1}"
Space & 2:: Send "{F2}"
Space & 3:: Send "{F3}"
Space & 4:: Send "{F4}"
Space & 5:: Send "{F5}"
Space & 6:: Send "{F6}"
Space & 7:: Send "{F7}"
Space & 8:: Send "{F8}"
Space & 9:: Send "{F9}"
Space & 0:: Send "{F10}"
Space & -:: Send "{F11}"
Space & =:: Send "{F12}"

; Multimedia
Space & Esc:: Send "{Media_Prev}"
Space & `:: Send "{Media_Prev}"
Space & BS:: Send "{Media_Next}"

Space & y:: Send "{Volume_Mute}"
Space & [:: Send "{Volume_Down}"
Space & ]:: Send "{Volume_Up}"
Space & \:: Send "{Media_Play_Pause}"

; Task switching
Space & Tab::AltTab
Space & q:: Send "{Alt Down}{Tab}{Alt Up}"
Space & w:: Send "{Ctrl Down}{Tab}{Ctrl Up}"

; New, Refresh
; Tap for the shortcut; hold to act as a transient Alt modifier for
; chaining into other Space-chord keys (see j/l/p/m below) or ad hoc app
; shortcuts, mirroring Karabiner's a/e/r tap-vs-hold (300ms threshold
; matches its own to_if_alone_timeout_milliseconds).
Space & e:: {
  global eDown
  Send "{Blind}{Ctrl Down}"
  eDown := A_TickCount
}
Space & e up:: {
  global eDown
  if IsSet(eDown) && (A_TickCount - eDown) < 300
    Send "{Blind}{Ctrl Up}{Ctrl Down}n{Ctrl Up}"
  else
    Send "{Blind}{Ctrl Up}"
}
Space & r:: {
  global rDown
  Send "{Blind}{Shift Down}"
  rDown := A_TickCount
}
Space & r up:: {
  global rDown
  if IsSet(rDown) && (A_TickCount - rDown) < 300
    Send "{Blind}{Shift Up}{F5}"
  else
    Send "{Blind}{Shift Up}"
}

; TouchCursor (minus "insert" ["y" is used to Volume_Mute])
Space & i:: Send "{Up}"
Space & k:: Send "{Down}"

; j/l/p/m: word-wise variant when Alt is also held (checked at runtime,
; since custom "&" combo hotkeys can't require an extra modifier on the
; suffix key) — this catches both the transient Alt from holding 'a'
; above and a real physical Alt key. Ctrl+Arrow/Backspace/Delete are
; native Windows word-nav shortcuts, so this works everywhere, not just
; terminals. Alt is released around the Send to avoid it turning into
; Ctrl+Alt+Arrow, then restored after (harmless if 'a' already released
; it, needed if 'a' is still held).
Space & j:: {
  if GetKeyState("Alt")
    Send "{Alt Up}{Ctrl Down}{Left}{Ctrl Up}{Alt Down}"
  else
    Send "{Left}"
}
Space & l:: {
  if GetKeyState("Alt")
    Send "{Alt Up}{Ctrl Down}{Right}{Ctrl Up}{Alt Down}"
  else
    Send "{Right}"
}

Space & p:: {
  if GetKeyState("Alt")
    Send "{Alt Up}{Ctrl Down}{Backspace}{Ctrl Up}{Alt Down}"
  else
    Send "{Backspace}"
}
Space & m:: {
  if GetKeyState("Alt")
    Send "{Alt Up}{Ctrl Down}{Delete}{Ctrl Up}{Alt Down}"
  else
    Send "{Delete}"
}

Space & h:: Send "{PgUp}"
Space & n:: Send "{PgDn}"
Space & u:: Send "{Home}"
Space & o:: Send "{End}"

; Select all, Space, Close tab, Find, Again
; Tap for Ctrl+A; hold to act as a transient Alt modifier (see the e/r
; pair above, and j/l/p/m's word-wise variant, for the same pattern)
Space & a:: {
  global aDown
  Send "{Blind}{Alt Down}"
  aDown := A_TickCount
}
Space & a up:: {
  global aDown
  if IsSet(aDown) && (A_TickCount - aDown) < 300
    Send "{Blind}{Alt Up}{Ctrl Down}a{Ctrl Up}"
  else
    Send "{Blind}{Alt Up}"
}
Space & s:: Send "{Space}"
Space & d:: {
  if WinActive("ahk_exe Code.exe") {
    Send "^{F4}"
  } else if WinActive("ahk_exe VSCodium.exe") {
    Send "^{F4}"
  } else if WinActive("ahk_exe ConEmu64.exe") {
    Send "^d"
  } else if WinActive("ahk_exe mintty.exe") {
    Send "^d"
  } else if WinActive("ahk_class Notepad") {
    Send "!{F4}"
  } else if WinActive("ahk_exe WindowsTerminal.exe") {
    Send "{Ctrl Down}{Shift Down}w{Ctrl Up}{Shift Up}"
  } else {
    Send "^w"
  }
}
Space & f:: Send "{Ctrl Down}f{Ctrl Up}"
Space & g:: Send "{F3}"

; Too distracting
; Space & LShift:: Send "{Alt Down}{Space}{Alt Up}"
; <+Space:: Send "{Alt Down}{Space}{Alt Up}"

; Undo, Cut, Copy and Paste
Space & z:: Send "{Ctrl Down}z{Ctrl Up}"
Space & x:: Send "{Ctrl Down}x{Ctrl Up}"
Space & c:: {
  if WinActive("ahk_exe mintty.exe") {
    Send "{Ctrl Down}{Insert}{Ctrl Up}"
  } else if WinActive("ahk_exe WindowsTerminal.exe") {
    Send "{Ctrl Down}{Insert}{Ctrl Up}"
  } else {
    Send "{Ctrl Down}c{Ctrl Up}"
  }
}
Space & v:: {
  if WinActive("ahk_exe ConEmu64.exe") {
    Send "{LShift Down}{Insert}{LShift Up}"
  } else if WinActive("ahk_exe mintty.exe") {
    Send "{LShift Down}{Insert}{LShift Up}"
  } else if WinActive("ahk_exe WindowsTerminal.exe") {
    Send "{LShift Down}{Insert}{LShift Up}"
  } else {
    Send "{Ctrl Down}v{Ctrl Up}"
  }
}

; Tab New/Reopen
Space & ,:: {
  if WinActive("ahk_exe WindowsTerminal.exe") {
    Send "{Ctrl Down}{Shift Down}t{Ctrl Up}{Shift Up}"
  } else {
    Send "{Ctrl Down}t{Ctrl Up}"
  }
}
Space & .:: Send "{Ctrl Down}{Shift Down}t{Ctrl Up}{Shift Up}"

; Backtick and tilde (The New Adventures of...)
Space & b:: Send "``"
Space & t:: Send "`~"

; Desktop Navigation
Space & `;:: Send "{Ctrl Down}{LWin Down}{Left}{Ctrl Up}{LWin Up}"
Space &  ':: Send "{Ctrl Down}{LWin Down}{Right}{Ctrl Up}{LWin Up}"

; Open Task view
Space & RShift:: Send "{LWin Down}{Tab}{LWin Up}"
Space & Enter:: Send "{LWin Down}{Tab}{LWin Up}"

; For Cmder Quake toggle
Space & /:: Send "{Alt Down}/{Alt Up}"

Space:: Send "{Space}"

#HotIf
