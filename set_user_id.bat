@echo off
title Set Discord User ID
color 0B
echo.
echo ===============================================
echo         Discord User ID Setup
echo ===============================================
echo.
echo To make you the owner of the bot, I need your Discord User ID.
echo This is a 17-18 digit number that Discord assigns to your account.
echo.
echo HOW TO GET YOUR DISCORD USER ID:
echo.
echo 1. Open Discord
echo 2. Click the gear icon (⚙️) next to your username
echo 3. Go to "Advanced" on the left side  
echo 4. Turn ON "Developer Mode"
echo 5. Right-click your username anywhere in Discord
echo 6. Click "Copy User ID"
echo.
echo Example User ID: 123456789012345678
echo.
echo ===============================================
echo.
set /p userid="Please paste your Discord User ID here: "

REM Validate the input
echo %userid% | findstr /r "^[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]*$" >nul
if %errorlevel% neq 0 (
    echo.
    echo ERROR: That doesn't look like a valid User ID.
    echo User IDs are 17-18 digit numbers only.
    echo Please try again.
    echo.
    pause
    goto :eof
)

echo.
echo ✅ Valid User ID format detected: %userid%
echo.
echo Updating config.txt...

REM Create a temporary PowerShell script to update the config
echo (Get-Content "config.txt") -replace "owner = 0 // OWNER ID", "owner = %userid%" ^| Set-Content "config.txt" > temp_update.ps1
powershell -ExecutionPolicy Bypass -File temp_update.ps1
del temp_update.ps1

echo ✅ Config updated successfully!
echo.
echo Your bot is now configured with:
echo - Discord Token: ✅ Already set
echo - Owner User ID: ✅ %userid%
echo - Java Version: ✅ Java 17 installed
echo.
echo ===============================================
echo.
echo 🚀 Ready to start your bot!
echo.
echo Would you like to start the bot now?
set /p start="Enter Y to start the bot, or any other key to exit: "
if /i "%start%"=="y" (
    echo.
    echo Starting your Discord Music Bot...
    echo.
    "C:\Program Files\Eclipse Adoptium\jdk-17.0.16.8-hotspot\bin\java.exe" -jar "JMusicBot-0.4.3.jar"
)
echo.
pause
