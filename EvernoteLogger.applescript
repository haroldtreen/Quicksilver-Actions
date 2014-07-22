property notebook_title : "Today I Learned"

using terms from application "Quicksilver"
	on process text _text
	if _text is not "" then
		CreateDailyEvernote(_text)
	end if
	end process text
end using terms from

on CreateDailyEvernote(txt)
	set note_title to do shell script "date +'%A, %B %d'"
	set timeStr to time string of (current date)
	
	tell application "Evernote"
		if (not (notebook named notebook_title exists)) then
			make notebook with properties { name: notebook_title }
		end if

		set foundNotes to find notes "notebook:\"" & notebook_title & "\"" & " intitle:\"" & note_title & "\""
		set found to ((length of foundNotes) is not 0)
		if found then
			repeat with curnote in foundNotes
				tell curnote to append html "<b>" & timeStr & "</b>"
				tell curnote to append html "<p>" & txt & "</p>"
				tell curnote to append html "<br>"
			end repeat
		else
			set curnote to create note with html "<h1>On " & note_title & "<br>I learned:</h1>" title note_title notebook notebook_title
			tell curnote to append html "<b>" & timeStr & "</b>"
			tell curnote to append html "<p>" & txt & "</p>"
			tell curnote to append html "<br>"
		end if
	end tell
end CreateDailyEvernote
