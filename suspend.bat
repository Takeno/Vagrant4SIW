@echo off

echo Suspending Vagrant VM...
vagrant suspend

if errorlevel 1 (
	echo FAILURE! Vagrant VM unresponsive...
) else (
	echo Vagrant is suspended!
)

echo Press a key to continue...
pause > nul