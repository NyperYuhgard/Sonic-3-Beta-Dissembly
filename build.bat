@echo off
asm68k.exe /p /o ae- S303111993.asm,s3built.bin
rompad.exe s3built.bin 0 0
fixheadr.exe s3built.bin
pause
