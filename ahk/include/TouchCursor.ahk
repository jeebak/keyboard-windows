; AHK script implementing TouchCursor
;   http://martin-stone.github.io/touchcursor/
;   https://autohotkey.com/boards/viewtopic.php?t=6525

; Function keys
Space & 1::Send, {F1}
Space & 2::Send, {F2}
Space & 3::Send, {F3}
Space & 4::Send, {F4}
Space & 5::Send, {F5}
Space & 6::Send, {F6}
Space & 7::Send, {F7}
Space & 8::Send, {F8}
Space & 9::Send, {F9}
Space & 0::Send, {F10}
Space & -::Send, {F11}
Space & =::Send, {F12}

; Multimedia
Space & Esc::Send, {Media_Prev}
Space & `::Send, {Media_Prev}
Space & BS::Send, {Media_Next}

Space & y::Send, {Volume_Mute}
Space & [::Send, {Volume_Down}
Space & ]::Send, {Volume_Up}
Space & \::Send, {Media_Play_Pause}

; Task switching
Space & Tab::AltTab
Space & q::Send, {Alt Down}{Tab}{Alt Up}
Space & w::Send, {Ctrl Down}{Tab}{Ctrl Up}

; New, Refresh
Space & e::Send, {Ctrl Down}n{Ctrl Up}
Space & r::Send, {F5}

; TouchCursor (minus "insert" ["y" is used to Volume_Mute])
Space & i::Send, {Up}
Space & j::Send, {Left}
Space & k::Send, {Down}
Space & l::Send, {Right}

Space & p::Send, {Backspace}
Space & m::Send, {Delete}

Space & h::Send, {PgUp}
Space & n::Send, {PgDn}
Space & u::Send, {Home}
Space & o::Send, {End}

; Select all, Space, Close tab, Find, Again
Space & a::Send, {Ctrl Down}a{Ctrl Up}
Space & s::Send, {Space}
Space & d::
  If WinActive("ahk_exe Code.exe") {
    Send ^{F4}
  } Else If WinActive("ahk_exe ConEmu64.exe") {
    Send ^d
  } Else If WinActive("ahk_exe mintty.exe") {
    Send ^d
  } Else If WinActive("ahk_class Notepad") {
    Send !{F4}
  } Else {
    Send ^w
  }
  Return
Space & f::Send, {Ctrl Down}f{Ctrl Up}
Space & g::Send, {F3}

; Too distracting
; Space & LShift::Send, {Alt Down}{Space}{Alt Up}
; <+Space::Send, {Alt Down}{Space}{Alt Up}

; Undo, Cut, Copy and Paste
Space & z::Send, {Ctrl Down}z{Ctrl Up}
Space & x::Send, {Ctrl Down}x{Ctrl Up}
Space & c::
  If WinActive("ahk_exe mintty.exe") {
    Send {Ctrl Down}{Insert}{Ctrl Up}
  } Else {
    Send, {Ctrl Down}c{Ctrl Up}
  }
  Return
Space & v::
  If WinActive("ahk_exe ConEmu64.exe") {
    Send {LShift Down}{Insert}{LShift Up}
  } Else If WinActive("ahk_exe mintty.exe") {
    Send {LShift Down}{Insert}{LShift Up}
  } Else {
    Send, {Ctrl Down}v{Ctrl Up}
  }
  Return

; Tab New/Reopen
Space & ,::Send, {Ctrl Down}t{Ctrl Up}
Space & .::Send, {Ctrl Down}{Shift Down}t{Ctrl Up}{Shift Up}

; Backtick and tilde (The New Adventures of...)
Space & b::Send, ``
Space & t::Send, `~

; Desktop Navigation
Space & `;::Send, {Ctrl Down}{LWin Down}{Left}{Ctrl Up}{LWin Up}
Space &  '::Send, {Ctrl Down}{LWin Down}{Right}{Ctrl Up}{LWin Up}

; Open Task view
Space & RShift::Send, {LWin Down}{Tab}{LWin Up}
Space & Enter::Send, {LWin Down}{Tab}{LWin Up}

; For Cmder Quake toggle
Space & /::Send, {Alt Down}/{Alt Up}

Space::Send, {Space}
Return
