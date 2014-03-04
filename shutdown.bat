@ECHO OFF

ECHO Shutting down Vagrant VM...
vagrant halt

IF errorlevel 1 (
	ECHO FAILURE! Vagrant VM unresponsive...
) ELSE (
	ECHO Yessir! Vagrant is down.
)


ECHO Press a key to continue...
pause > nul