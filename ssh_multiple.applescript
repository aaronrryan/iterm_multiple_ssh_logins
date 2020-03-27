-- manual array
-- set hostnames to {"admcld501", "admcld502", "admcld503", "admcld504"}

-- or read from file
set hostnames to paragraphs of (do shell script "/bin/cat $HOME/serverlist")

if application "iTerm" is running then
	tell application "iTerm"
		create window with default profile
		tell current tab of current window
			select
			tell current session
				-- make the window fullscreen
				tell application "System Events" to key code 36 using command down
				
				split horizontally with default profile
				
				tell application "System Events" to keystroke "]" using command down
				
				
				set num_hosts to count of hostnames
				repeat with n from 1 to num_hosts
					if n mod 4 is 0 then
						-- move to lower split make new row, then go back up
						tell application "System Events" to keystroke "]" using command down
						tell application "System Events" to keystroke "D" using {command down, shift down}
						tell application "System Events" to keystroke "[" using command down
					else
						-- split vertically
						tell application "System Events" to keystroke "d" using command down
					end if
					delay 1
					write text "ssh root@" & (item n of hostnames)
				end repeat
			end tell
		end tell
	end tell
else
	activate application "iTerm"
	
end if
