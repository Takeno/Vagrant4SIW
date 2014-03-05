@echo off

echo Shutting down Vagrant VM...
vagrant halt

if errorlevel 1 (
	echo FAILURE! Vagrant VM unresponsive...
) else (
	echo Yessir! Vagrant is down.
)


echo Press a key to continue...
pause > nul