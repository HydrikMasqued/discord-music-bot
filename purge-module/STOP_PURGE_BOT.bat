@echo off
title Stop Purge Bot Module
color 0C

echo ===============================================
echo         🛑 STOPPING PURGE BOT MODULE 🛑     
echo ===============================================
echo.
echo This will terminate the Discord Purge Bot Module...
echo.

REM Find and kill Java processes running the purge bot
echo 🔍 Looking for running Purge Bot processes...

REM Use WMIC to find Java processes with purge-bot in command line
for /f "tokens=2" %%i in ('wmic process where "name='java.exe' and commandline like '%%purge-bot%%'" get processid /value ^| find "ProcessId"') do (
    echo ✅ Found Purge Bot process ID: %%i
    echo 🛑 Terminating process...
    taskkill /PID %%i /F
    if !ERRORLEVEL! equ 0 (
        echo ✅ Successfully stopped Purge Bot Module
    ) else (
        echo ❌ Failed to stop process %%i
    )
)

REM Alternative method - find Java processes running from purge-module directory
echo.
echo 🔍 Checking for Java processes in purge-module directory...
for /f "tokens=2" %%i in ('wmic process where "name='java.exe' and commandline like '%%purge-module%%'" get processid /value ^| find "ProcessId"') do (
    echo ✅ Found process ID: %%i
    echo 🛑 Terminating process...
    taskkill /PID %%i /F
)

echo.
echo ===============================================
echo           🧹 MODULE CLEANUP COMPLETE 🧹      
echo ===============================================
echo.
echo ✅ Purge Bot Module processes have been terminated
echo.
echo The module is now fully stopped and can be safely:
echo • Restarted using START_PURGE_BOT.bat
echo • Completely removed by deleting purge-module folder
echo • Updated by rebuilding with BUILD_PURGE_BOT.bat
echo.
echo Your main Music Bot is unaffected by this action.
echo.
pause
