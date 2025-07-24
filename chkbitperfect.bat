@echo OFF

REM // build the ROM
call build

REM  // run fc against a Sonic 1 Rev 01 ROM
echo -------------------------------------------------------------
if exist s3built.bin ( fc /b s3built.bin Sonic_3_Proto.md
) else echo s3built.bin does not exist, probably due to an assembly error

REM // if someone ran this from Windows Explorer, prevent the window from disappearing immediately
pause

