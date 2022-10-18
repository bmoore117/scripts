SETLOCAL EnableDelayedExpansion
reg load HKLM\TEMP c:\windows\system32\config\sam
for /f "tokens=3" %%a in ('reg query HKLM\TEMP\SAM\Domains\Account\Users\000001F4 /v F') do (
	set str=%%a
	set str=!str:2000011=2000010!
	echo !str!
	reg add HKLM\TEMP\SAM\Domains\Account\Users\000001F4 /v F /t REG_BINARY /d !str! /f
)
reg unload HKLM\TEMP
