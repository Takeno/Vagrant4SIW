@echo off

echo Starting Vagrant VM...
vagrant up


if errorlevel 1 (
	echo FAILURE! Vagrant VM unresponsive...
) else (
	echo Vagrant is running!
)

echo Press a key to continue...
pause > nul