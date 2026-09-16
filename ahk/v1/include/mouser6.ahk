;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         Adam Pash <adam.pash@gmail.com>
;
; Script Function:
;	Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)
;
; https://lifehacker.com/212816/hack-attack-operate-your-mouse-with-your-keyboard
; http://web.archive.org/web/20101208231257/http://www.lifehacker.com/assets/resources/2006/11/mouser6.ahk
; https://autohotkey.com/board/topic/12793-mouser-by-adam-pash-a-new-concept-for-a-keyboard-mouse/
;
#SingleInstance,Force 
SetWinDelay,0 

Gosub,INI
Gosub,TRAYMENU


visualizations := visualizations
color := Ceil(color)
transparency:=transparency
locator := locator
comma = ","


^+Enter::
Click
return

START:
CoordMode, Mouse
MouseGetPos, current_x, current_y
if locator = 1
{
	GoSub, Locate
}
first_y = "y"
first_x = "y"
SysGet, resolution, Monitor
half_x := Ceil(resolutionRight/2)
move_x := current_x
move_y := current_y
full_y := Ceil(resolutionBottom)
floor := Ceil(resolutionBottom)
ceiling := 0
right := Ceil(resolutionRight)
left := 0
box_w := 0
box_y := 0


Loop
{
	;MsgBox, New Coordinates: %move_x% x %move_y%
	MouseGetPos, current_x, current_y
	Input, UserInput, T5 L1, {Enter}{Escape}{Left}{Right}{Up}{Down}, i,%comma%,j,l
	IfInString, ErrorLevel, EndKey:Up
	{
		if first_y = ""
		{
			box_w_t := resolutionBottom - half_y
			move_y := Ceil(current_y - half_y)
			floor := current_y
		}
		if first_y = "y"
		{
			half_y := current_y/2
			floor := current_y
			move_y := Ceil(current_y - (half_y))
			box_w_t := resolutionBottom
		}
		half_y := half_y/2
		MouseMove, %move_x%, %move_y%
		if visualizations = 1
		{
			;;; Create Window ;;;
			Gui,4: +AlwaysOnTop -Caption +LastFound +ToolWindow
			Gui,4: Color, Ceil(color)
			WinSet, TransColor, EEAAEE %transparency%
			Gui,4: Show, x0 y%floor% w%resolutionRight% h%box_w_t% noactivate
		}
		first_y = ""
	}
	IfInString, ErrorLevel, EndKey:Down
	{
		if first_y = "y"
		{
			half_y := (resolutionBottom - current_y)/2
			ceiling := current_y
			move_y := Ceil(current_y + half_y)
			box_y := ceiling
		}
		;
		if first_y = ""
		{
			ceiling := current_y
			move_y := Ceil(half_y + current_y)
			box_y := current_y
		}
		half_y := half_y/2
		MouseMove, %move_x%, %move_y%
		if visualizations = 1
		{
			;;; Create Window ;;;
			Gui,3: +AlwaysOnTop -Caption +LastFound +ToolWindow
			Gui,3: Color, Ceil(color)
			WinSet, TransColor, EEAAEE %transparency%
			Gui,3: Show, x0 y0 w%resolutionRight% h%box_y% noactivate
		}
		first_y = ""
		;MsgBox, %move_y%
	}
	IfInString, ErrorLevel, EndKey:Left
	{
		if first_x = "y"
		{
			half_x := current_x/2
			right := current_x
			move_x := Ceil(current_x - (half_x))
			box_w_r := resolutionRight
			;floor := floor - half_y/2
		}
		if first_x = ""
		{
			box_w_r := resolutionRight - half_x
			right := right - half_x
			half_x := half_x/2
			move_x := Ceil(right - half_x)
		}
		MouseMove, %move_x%, %move_y%
		if visualizations = 1
		{
			;;; Create Window ;;;
			Gui,2: +AlwaysOnTop -Caption +LastFound +ToolWindow
			Gui,2: Color, Ceil(color)
			WinSet, TransColor, %color% %transparency%
			Gui,2: Show, x%right% y0 w%box_w_r% h%resolutionBottom% noactivate
		}
		first_x = ""
	}
	IfInString, ErrorLevel, EndKey:Right
	{
		if first_x = "y"
		{
			half_x := (resolutionRight - current_x)/2
			left := current_x
			move_x := Ceil(current_x + half_x)
			box_w := left
		}
		if first_x = ""
		{
			box_w := box_w + half_x
			left := left + half_x
			half_x := half_x/2
			move_x := Ceil(left + half_x)
		}
		MouseMove, %move_x%, %move_y%
		if visualizations = 1
		{		
			;;; Create Window ;;;
			Gui,1: +AlwaysOnTop -Caption +LastFound +ToolWindow
			Gui,1: Color, Ceil(color)
			WinSet, TransColor, EEAAEE %transparency%
			Gui,1: Show, x0 y0 w%box_w% h%resolutionBottom% noactivate
		}
		first_x = ""
	}
		IfInString, ErrorLevel, EndKey:Escape
	{
		Gosub, Quit
	}
	IfInString, ErrorLevel, EndKey:Enter
	{
		Gosub, ClickMouse
	}
	IfInString, ErrorLevel, EndKey:q
	{
		Gosub, Quit
	}

	if UserInput=i
	{
		if first_y = ""
		{
			box_w_t := resolutionBottom - half_y
			move_y := Ceil(current_y - half_y)
			floor := current_y
		}
		if first_y = "y"
		{
			half_y := current_y/2
			floor := current_y
			move_y := Ceil(current_y - (half_y))
			box_w_t := resolutionBottom
		}
		half_y := half_y/2
		MouseMove, %move_x%, %move_y%
		if visualizations = 1
		{
			;;; Create Window ;;;
			Gui,4: +AlwaysOnTop -Caption +LastFound +ToolWindow
			Gui,4: Color, Ceil(color)
			WinSet, TransColor, EEAAEE %transparency%
			Gui,4: Show, x0 y%floor% w%resolutionRight% h%box_w_t% noactivate
		}
		first_y = ""
	}
	else if UserInput =,
	{
		if first_y = "y"
		{
			half_y := (resolutionBottom - current_y)/2
			ceiling := current_y
			move_y := Ceil(current_y + half_y)
			box_y := ceiling
		}
		;
		if first_y = ""
		{
			ceiling := current_y
			move_y := Ceil(half_y + current_y)
			box_y := current_y
		}
		half_y := half_y/2
		MouseMove, %move_x%, %move_y%
		if visualizations = 1
		{
			;;; Create Window ;;;
			Gui,3: +AlwaysOnTop -Caption +LastFound +ToolWindow
			Gui,3: Color, Ceil(color)
			WinSet, TransColor, EEAAEE %transparency%
			Gui,3: Show, x0 y0 w%resolutionRight% h%box_y% noactivate
		}
		first_y = ""
	}
	else if UserInput =j
	{
		if first_x = "y"
		{
			half_x := current_x/2
			right := current_x
			move_x := Ceil(current_x - (half_x))
			box_w_r := resolutionRight
			;floor := floor - half_y/2
		}
		if first_x = ""
		{
			box_w_r := resolutionRight - half_x
			right := right - half_x
			half_x := half_x/2
			move_x := Ceil(right - half_x)
		}
		MouseMove, %move_x%, %move_y%
		if visualizations = 1
		{
			;;; Create Window ;;;
			Gui,2: +AlwaysOnTop -Caption +LastFound +ToolWindow
			Gui,2: Color, Ceil(color)
			WinSet, TransColor, %color% %transparency%
			Gui,2: Show, x%right% y0 w%box_w_r% h%resolutionBottom% noactivate
		}
		first_x = ""
	}
	else if UserInput =l
	{
		if first_x = "y"
		{
			half_x := (resolutionRight - current_x)/2
			left := current_x
			move_x := Ceil(current_x + half_x)
			box_w := left
		}
		if first_x = ""
		{
			box_w := box_w + half_x
			left := left + half_x
			half_x := half_x/2
			move_x := Ceil(left + half_x)
		}
		MouseMove, %move_x%, %move_y%
		if visualizations = 1
		{		
			;;; Create Window ;;;
			Gui,1: +AlwaysOnTop -Caption +LastFound +ToolWindow
			Gui,1: Color, Ceil(color)
			WinSet, TransColor, EEAAEE %transparency%
			Gui,1: Show, x0 y0 w%box_w% h%resolutionBottom% noactivate
		}
		first_x = ""
	}
	else if UserInput =k
	{
		GoSub, ClickMouse
	}
	else if UserInput =r
	{
		GoSub, RightClickMouse
		Exit
	}

	if ErrorLevel = Max
	{
				
	}
	if ErrorLevel = NewInput
		return
}
return

Quit:
Gui,1: Destroy
Gui,2: Destroy
Gui,3: Destroy
Gui,4: Destroy
Exit
return

ClickMouse:
Click
Gui,1: Destroy
Gui,2: Destroy
Gui,3: Destroy
Gui,4: Destroy
Exit
return

RightClickMouse:
Click right
Gui,1: Destroy
Gui,2: Destroy
Gui,3: Destroy
Gui,4: Destroy
Exit
return

Locate:
delay := 200
x_pos := Ceil(current_x - 50)
y_pos := Ceil(current_y - 50)
Gui, 5: +AlwaysOnTop -Caption +LastFound +ToolWindow
Gui, 5: Color, FF3333
WinSet, TransColor, %color% %transparency%
Gui,5: Show, x%x_pos% y%y_pos% w100 h100 noactivate
Loop, 1
{
	Sleep, %delay%
	WinHide
	Sleep, %delay%
	WinShow
}
Sleep, %delay%
Gui, 5: Destroy
return

INI:
IfNotExist,Mouser.ini
{
  IniWrite,^M,Mouser.ini,Settings,hotkey
  IniWrite,1,Mouser.ini,Settings,visualizations
  IniWrite,FF3333,Mouser.ini,Settings,color
  IniWrite,70,Mouser.ini,Settings,transparency
  IniWrite,1,Mouser.ini,Settings,locator

}
IniRead,hotkey,Mouser.ini,Settings,hotkey
IniRead,visualizations,Mouser.ini,Settings,visualizations
IniRead,color,Mouser.ini,Settings,color
IniRead,transparency,Mouser.ini,Settings,transparency
IniRead,locator,Mouser.ini,Settings,locator
HotKey,%hotkey%,START
Return

TRAYMENU:
Menu,Tray,NoStandard 
Menu,Tray,DeleteAll 
Menu,Tray,Add,Mouser,ABOUT
Menu,Tray,Add,
Menu,Tray,Add,&Settings...,SETTINGS
Menu,Tray,Add,&About...,ABOUT
Menu,Tray,Add,E&xit,EXIT
Menu,Tray,Default,Mouser
Menu,Tray,Tip,Mouser
Return

SETTINGS:
HotKey,%hotkey%,Off
Gui,8: Destroy
Gui,8: Add,GroupBox,xm ym w400 h70,&Hotkey
Gui,8: Add,Hotkey,xp+10 yp+20 w380 vshotkey
StringReplace,current,hotkey,+,Shift +%A_Space%
StringReplace,current,current,^,Ctrl +%A_Space%
StringReplace,current,current,!,Alt +%A_Space%
Gui,8: Add,Text,,Current hotkey: %current%
Gui,8: Add, Checkbox, xp+10 yp+28 vslocator_cbox Checked%locator%, Locator (flashes location of mouse when hotkey is pressed)
Gui,8: Add, Checkbox, vsvisualizations_cbox Checked%visualizations%, Screen visualizations (displays area of screen that has been ruled out)
Gui,8: Add,GroupBox,xm y+10 w400 h75,&Visualization Transparency (0 to 250; default:70; currently:%transparency%):
Gui,8: Add, Slider, xp+10 yp+20 w380 vstransparency Range0-250 ToolTipRight TickInterval25, %transparency%
Gui,8: Add,Button,xm y+30 w75 GSETTINGSOK,&OK
Gui,8: Add,Button,x+5 w75 GSETTINGSCANCEL,&Cancel
Gui,8: Show,,Mouser Settings
Return

SETTINGSOK:
Gui,8: Submit
If shotkey<>
{
  hotkey:=shotkey
  HotKey,%hotkey%,START
}
HotKey,%hotkey%,On
If stransparency<>
  transparency:=stransparency
If slocator<>
  locator = %slocator%
if slocator_cbox<>
  locator := slocator_cbox
if svisualizations_cbox<>
  visualizations := svisualizations_cbox
IniWrite,%hotkey%,Mouser.ini,Settings,hotkey
IniWrite,%visualizations%,Mouser.ini,Settings,visualizations
IniWrite,%transparency%,Mouser.ini,Settings,transparency
IniWrite,%locator%,Mouser.ini,Settings,locator
IniWrite,%checkbox%, Mouser.ini, Settings,checkbox
Gui, 8: Destroy
Return

SETTINGSCANCEL:
HotKey,%hotkey%,START,On
HotKey,%hotkey%,On
Gui,8: Destroy
Return


ABOUT:
Gui,Destroy
Gui,Font,Bold
Gui,Add,Text,x+10 yp+10,Mouser v1.0 - by Adam Pash
Gui,Font
Gui,Add,Text,xm,Press Ctrl+M to locate and move the mouse.
Gui,Add,Text,xm,To change the settings, choose Settings in the tray menu.
Gui,Add,Text,xm y+15,Made using AutoHotkey 
Gui,Font
Gui,Font
Gui,Add,Text,xm,For more Autohotkey love, check out:
Gui, Font, Bold
Gui,Add,Text,xm,http://lifehacker.com/software/autohotkey
Gui,Show,,ShiftOff About
about=
Return

EXIT:
ExitApp