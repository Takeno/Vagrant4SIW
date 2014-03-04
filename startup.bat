@ECHO OFF
ECHO ""

ECHO Starting Vagrant VM...
vagrant up


IF errorlevel 1 (
	ECHO FAILURE! Vagrant VM unresponsive...
) ELSE (
	ECHO Vagrant is running!
)

ECHO Press a key to continue...
pause > nul