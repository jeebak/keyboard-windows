;DockWin v0.3 - Save and Restore window positions when docking/undocking (using hotkeys)
; Paul Troiano, 6/2014
; Updated by Ashley Dawson 7/2015
; Updated by Matthew Jewett 2/8/2017
;
; Hotkeys: ^ = Control; ! = Alt; + = Shift; # = Windows key; * = Wildcard;
;          & = Combo keys; Others include ~, $, UP (see "Hotkeys" in Help)

;#InstallKeybdHook
#SingleInstance, Force
SetTitleMatchMode, 2		; 2: A window's title can contain WinTitle anywhere inside it to be a match. 
SetTitleMatchMode, Fast		;Fast is default
DetectHiddenWindows, off	;Off is default

EnvGet, APPD, APPDATA
wd := APPD . "\DockWinData"

IfNotExist, %wd%
{
	FileCreateDir, %wd%
}

SetWorkingDir %wd%  ; Ensures a consistent starting directory.

;Win-Shift-0 (Save current windows to file)
#+0::
FName = WinPos-0.txt
saveWindows(FName)
RETURN

;Win-CTRL-0 (Restore window positions from file)
#^0::
FName = WinPos-0.txt
restoreWindows(FName)
RETURN

;Win-Shift-1 (Save current windows to file)
#+1::
FName = WinPos-1.txt
saveWindows(FName)
RETURN

;Win-CTRL-1 (Restore window positions from file)
#^1::
FName = WinPos-1.txt
restoreWindows(FName)
RETURN

;Win-Shift-2 (Save current windows to file)
#+2::
FName = WinPos-2.txt
saveWindows(FName)
RETURN

;Win-CTRL-2 (Restore window positions from file)
#^2::
FName = WinPos-2.txt
restoreWindows(FName)
RETURN

;Win-Shift-3 (Save current windows to file)
#+3::
FName = WinPos-3.txt
saveWindows(FName)
RETURN

;Win-CTRL-3 (Restore window positions from file)
#^3::
FName = WinPos-3.txt
restoreWindows(FName)
RETURN

;Win-Shift-4 (Save current windows to file)
#+4::
FName = WinPos-4.txt
saveWindows(FName)
RETURN

;Win-CTRL-4 (Restore window positions from file)
#^4::
FName = WinPos-4.txt
restoreWindows(FName)
RETURN

;Win-Shift-5 (Save current windows to file)
#+5::
FName = WinPos-5.txt
saveWindows(FName)
RETURN

;Win-CTRL-5 (Restore window positions from file)
#^5::
FName = WinPos-5.txt
restoreWindows(FName)
RETURN

;Win-Shift-6 (Save current windows to file)
#+6::
FName = WinPos-6.txt
saveWindows(FName)
RETURN

;Win-CTRL-6 (Restore window positions from file)
#^6::
FName = WinPos-6.txt
restoreWindows(FName)
RETURN

;Win-Shift-7 (Save current windows to file)
#+7::
FName = WinPos-7.txt
saveWindows(FName)
RETURN

;Win-CTRL-7 (Restore window positions from file)
#^7::
FName = WinPos-7.txt
restoreWindows(FName)
RETURN

;Win-Shift-8 (Save current windows to file)
#+8::
FName = WinPos-8.txt
saveWindows(FName)
RETURN

;Win-CTRL-8 (Restore window positions from file)
#^8::
FName = WinPos-8.txt
restoreWindows(FName)
RETURN

;Win-Shift-9 (Save current windows to file)
#+9::
FName = WinPos-9.txt
saveWindows(FName)
RETURN

;Win-CTRL-9 (Restore window positions from file)
#^9::
FName = WinPos-9.txt
restoreWindows(FName)
RETURN

restoreWindows(FileName)
{
  WinGetActiveTitle, SavedActiveWindow
  ParmVals:="Title x y height width maximized path"
  SectionToFind:= SectionHeader()
  SectionFound:= 0
 
  Loop, Read, %FileName%
  {
    if !SectionFound
    {
      ;Read through file until correct section found
      If (A_LoopReadLine<>SectionToFind) 
		Continue
    }	  

		;Exit if another section reached
		If ( SectionFound and SubStr(A_LoopReadLine,1,8)="SECTION:")
			Break

		SectionFound:=1
		
		Win_Title:="", Win_x:=0, Win_y:=0, Win_width:=0, Win_height:=0, Win_maximized:=0

		Loop, Parse, A_LoopReadLine, CSV 
		{
			EqualPos:=InStr(A_LoopField,"=")
			Var:=SubStr(A_LoopField,1,EqualPos-1)
			Val:=SubStr(A_LoopField,EqualPos+1)
			IfInString, ParmVals, %Var%
			{
				;Remove any surrounding double quotes (")
				If (SubStr(Val,1,1)=Chr(34)) 
				{
					StringMid, Val, Val, 2, StrLen(Val)-2
				}
				Win_%Var%:=Val  
			}
		}
		
		;Check if program is already running, if not, start it
		If  (!WinExist(Win_Title) and (Win_path<>""))
		{
			Try
			{
				Run %Win_path%	
				sleep 1000		;Give some time for the program to launch.	
			}
		}

		If ( (Win_maximized = 1) and WinExist(Win_Title) )
		{	
			WinRestore
			WinActivate
			WinMove, A,,%Win_x%,%Win_y%,%Win_width%,%Win_height%
			WinMaximize, A
		} Else If ((Win_maximized = -1) and (StrLen(Win_Title) > 0) and WinExist(Win_Title) )		; Value of -1 means Window is minimised
		{	
			WinRestore
			WinActivate
			WinMove, A,,%Win_x%,%Win_y%,%Win_width%,%Win_height%
			WinMinimize, A
		} Else If ( (StrLen(Win_Title) > 0) and WinExist(Win_Title) )
		{	
			WinRestore
			WinActivate
			WinMove, A,,%Win_x%,%Win_y%,%Win_width%,%Win_height%
		}
  }

  if !SectionFound
  {
    msgbox,,Dock Windows, Section does not exist in %FileName% `nLooking for: %SectionToFind%`n`nTo save a new section, use Win-Shift-0 (zero key above letter P on keyboard)
  }

  ;Restore window that was active at beginning of script
  WinActivate, %SavedActiveWindow%
RETURN
}

saveWindows(FileName)
{
MsgBox, 4,Dock Windows,Save window positions?
 IfMsgBox, NO, Return
 
 if FileExist(FileName)
{
	FileDelete, %FileName%
}

 WinGetActiveTitle, SavedActiveWindow

 file := FileOpen(FileName, "a")
 if !IsObject(file)
 {
	MsgBox, Can't open "%FileName%" for writing.
	Return
 }

  line:= SectionHeader() . "`r`n"
  file.Write(line)

  ; Loop through all windows on the entire system
  WinGet, id, list,,, Program Manager
  Loop, %id%
  {
    this_id := id%A_Index%
    WinActivate, ahk_id %this_id%
    WinGetPos, x, y, Width, Height, A ;Wintitle
    WinGetClass, this_class, ahk_id %this_id%
    WinGetTitle, this_title, ahk_id %this_id%
    WinGet, win_maximized, minmax, %this_title%

	if ( (StrLen(this_title)>0) and (this_title<>"Start") and (this_title<>"Outlook"))
	{
		line=Title="%this_title%"`,x=%x%`,y=%y%`,width=%width%`,height=%height%`,maximized=%win_maximized%,path=""`r`n
		file.Write(line)
   	}
	
	if(win_maximized = -1)		;Re-minimize any windows that were minimised before we started.
	{
		WinMinimize, A
	}
  }

  file.write("`r`n")  ;Add blank line after section
  file.Close()

  ;Restore active window
  WinActivate, %SavedActiveWindow%
RETURN
}
; -------

;Create standardized section header for later retrieval
SectionHeader()
{
	SysGet, MonitorCount, MonitorCount
	SysGet, MonitorPrimary, MonitorPrimary
	line=SECTION: Monitors=%MonitorCount%,MonitorPrimary=%MonitorPrimary%

        WinGetPos, x, y, Width, Height, Program Manager
	line:= line . "; Desktop size:" . x . "," . y . "," . width . "," . height 

	Return %line%
}

;<EOF>