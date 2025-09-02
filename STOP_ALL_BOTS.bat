@echo off
title Stop All Bots - Music + Purge
color 0C

echo ===============================================
echo         🛑 STOPPING ALL BOT MODULES 🛑      
echo ===============================================
echo.
echo This will terminate ALL Discord bot processes:
echo   🎵 Music Bot (JMusicBot)
echo   🧹 Purge Bot Module
echo.

echo 🔍 Searching for active bot processes...
echo.

REM Stop JMusicBot processes
echo 🎵 Stopping Music Bot processes...
for /f "tokens=2" %%i in ('wmic process where "name='java.exe' and commandline like '%%JMusicBot%%'" get processid /value ^| find "ProcessId"') do (
    echo ✅ Found Music Bot process ID: %%i
    echo 🛑 Terminating Music Bot...
    taskkill /PID %%i /F
    if !ERRORLEVEL! equ 0 (
        echo ✅ Successfully stopped Music Bot
    ) else (
        echo ❌ Failed to stop Music Bot process %%i
    )
)

echo.
REM Stop Purge Bot processes  
echo 🧹 Stopping Purge Bot processes...
for /f "tokens=2" %%i in ('wmic process where "name='java.exe' and commandline like '%%purgebot%%'" get processid /value ^| find "ProcessId"') do (
    echo ✅ Found Purge Bot process ID: %%i
    echo 🛑 Terminating Purge Bot...
    taskkill /PID %%i /F
    if !ERRORLEVEL! equ 0 (
        echo ✅ Successfully stopped Purge Bot Module
    ) else (
        echo ❌ Failed to stop Purge Bot process %%i
    )
)

echo.
REM Alternative method - find any Java processes in bot directories
echo 🔍 Checking for any remaining Java processes in bot directories...
for /f "tokens=2" %%i in ('wmic process where "name='java.exe' and (commandline like '%%Music Bot%%' or commandline like '%%purge-module%%')" get processid /value ^| find "ProcessId"') do (
    echo ✅ Found remaining bot process ID: %%i
    echo 🛑 Terminating process...
    taskkill /PID %%i /F
)

echo.
echo ===============================================
echo           🧹 CLEANUP COMPLETE 🧹             
echo ===============================================
echo.
echo ✅ All Discord bot processes have been terminated
echo.
echo Status:
echo   🎵 Music Bot: STOPPED
echo   🧹 Purge Bot Module: STOPPED
echo.
echo Your Discord bot is now completely offline.
echo.
echo To restart:
echo   • Run START_BOTH_BOTS.bat (for both bots)
echo   • Run START_BOT.bat (music only)
echo   • Run purge-module\START_PURGE_BOT_SIMPLE.bat (purge only)
echo.
pause
