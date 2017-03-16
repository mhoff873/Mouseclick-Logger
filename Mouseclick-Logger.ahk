#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;start time of script
global last := A_TickCount

;arrays and their associated count
global Pauses := []
global PauseCount := 0

;arrays and their associated count
global Presses := []
global PressCount := 0

;Persistent loop recording
loop
	~LButton::pressed()
	
pressed(){
	;time since last click
	pause:= A_TickCount - last

	down := A_TickCount
	KeyWait, LButton
	up := A_TickCount
	
	;set last to click up event
	last := up
	
	;Increase the press array
	PressCount += 1  ; Keep track of how many items are in the array.
	Presses[PressCount] := up - down  ; Store this line in the next array element.
	
	;increase the pause array
	PauseCount += 1  ; Keep track of how many items are in the array.
        Pauses[PauseCount] := pause  ; Store this line in the next array element.

	return
}

;Escape Sequence
;Print Arrays to Msgboxes
kill(){
	Loop % PauseCount{
	    value := Pauses[A_Index]
	    FileAppend, %value%`,,C:\Users\Mason\Desktop\pauses.txt
	    ;MsgBox % "Press " . A_Index . " is " . Presses[A_Index]
	}

	Loop % PressCount{
	    value := Presses[A_Index]
	    FileAppend, %value%`,,C:\Users\Mason\Desktop\presses.txt
	    ;MsgBox % "Press " . A_Index . " is " . Presses[A_Index]
	    }

	exitapp
}

;Escape character is Ctrl+a
^a::kill()