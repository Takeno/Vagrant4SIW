@ECHO OFF

ECHO Suspending Vagrant VM...
vagrant suspend

IF errorlevel 1 (
	ECHO FAILURE! Vagrant VM unresponsive...
) ELSE (
	ECHO Vagrant is suspended!
)

ECHO Press a key to continue...
pause > nul