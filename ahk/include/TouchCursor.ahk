; AHK script implementing TouchCursor
;   http://martin-stone.github.io/touchcursor/
;   https://autohotkey.com/boards/viewtopic.php?t=6525

Space & Esc::Send, {Media_Prev}
Space & `::Send, {Media_Prev}
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
Space & BS::Send, {Media_Next}

Space & Tab::AltTab
Space & w::Send, {Ctrl Down}{Tab}{Ctrl Up}

Space & [::Send, {Volume_Down}
Space & ]::Send, {Volume_Up}
Space & \::Send, {Media_Play_Pause}

Space & i::Send, {Up}
Space & j::Send, {Left}
Space & k::Send, {Down}
Space & l::Send, {Right}

Space & p::Send, {Backspace}
Space & m::Send, {Delete}

Space & y::Send, {Insert}

Space & h::Send, {PgUp}
Space & n::Send, {PgDn}
Space & u::Send, {Home}
Space & o::Send, {End}

Space & d::
  If WinActive("ahk_exe Code.exe") {
    Send ^{F4}
  } Else If WinActive("ahk_class Notepad") {
    Send !{F4}
  } Else {
    Send ^w
  }
Return

Space & s::Send, {Space}
Space & f::Send, {Ctrl Down}f{Ctrl Up}

Space & LShift::Send, {Alt Down}{Space}{Alt Up}
<+Space::Send, {Alt Down}{Space}{Alt Up}

Space & z::Send, {Ctrl Down}z{Ctrl Up}
Space & x::Send, {Ctrl Down}x{Ctrl Up}
Space & c::Send, {Ctrl Down}c{Ctrl Up}
Space & v::Send, {Ctrl Down}v{Ctrl Up}

Space & ,::Send, {Ctrl Down}t{Ctrl Up}
Space & .::Send, {Ctrl Down}{Shift Down}t{Ctrl Up}{Shift Up}

Space & RShift::Send, {LWin Down}{Tab}{LWin Up}

Space & b::Send, ``
Space & t::Send, `~

; Desktop Navigation
Space & `;::Send, {Ctrl Down}{LWin Down}{Left}{Ctrl Up}{LWin Up}
Space &  '::Send, {Ctrl Down}{LWin Down}{Right}{Ctrl Up}{LWin Up}

Space & Enter::Send, {LWin Down}{Tab}{LWin Up}

; For Cmder Quake toggle
Space & /::Send, {Alt Down}/{Alt Up}

Space::Send, {Space}
Return
