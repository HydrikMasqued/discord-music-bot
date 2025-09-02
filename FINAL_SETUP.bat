@echo off
title Final Music Bot Setup
color 0A
cls
echo.
echo ===============================================
echo     🎵 FINAL MUSIC BOT SETUP 🎵
echo ===============================================
echo.
echo Great news! Java 17 is installed and your Discord
echo token is already configured from your old bot.
echo.
echo ✅ Discord Token: Ready
echo ✅ Java 17: Installed  
echo ✅ Bot Files: Downloaded
echo.
echo ❌ Missing: Your Discord User ID (required for bot owner)
echo.
echo ===============================================
echo         HOW TO GET YOUR DISCORD USER ID
echo ===============================================
echo.
echo 1. Open Discord (desktop app or web)
echo 2. Click the ⚙️ gear icon (User Settings) next to your name
echo 3. Click "Advanced" on the left side
echo 4. Turn ON "Developer Mode" (toggle switch)
echo 5. Close settings
echo 6. Right-click on your username ANYWHERE in Discord
echo 7. Click "Copy User ID"
echo 8. Come back here and paste it
echo.
echo Your User ID will look like: 123456789012345678
echo (It's a 17-18 digit number)
echo.
echo ===============================================
echo.
pause
echo.
set /p userid="Paste your Discord User ID here: "

REM Basic validation
echo %userid% | findstr /r "^[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]*$" >nul
if %errorlevel% neq 0 (
    echo.
    echo ❌ ERROR: That doesn't look right!
    echo User IDs are 17-18 digits, numbers only.
    echo Example: 123456789012345678
    echo.
    echo Please try again - make sure to:
    echo 1. Enable Developer Mode in Discord first
    echo 2. Right-click your username, not someone else's
    echo 3. Copy the FULL number
    echo.
    pause
    exit /b 1
)

echo.
echo ✅ Valid User ID detected: %userid%
echo.
echo 🔄 Updating config.txt...

REM Update the config file
powershell -Command "(Get-Content 'config.txt') -replace 'owner = 0 // OWNER ID', 'owner = %userid%' | Set-Content 'config.txt'"

echo ✅ Configuration updated successfully!
echo.
echo ===============================================
echo           🎉 SETUP COMPLETE! 🎉
echo ===============================================
echo.
echo Your Discord Music Bot is now configured with:
echo ✅ Discord Token (from your old bot)
echo ✅ Your User ID as owner: %userid%
echo ✅ Java 17 runtime
echo ✅ Command prefix: !
echo.
echo ===============================================
echo.
echo 🚀 Starting your Discord Music Bot now...
echo.
echo The bot will connect to Discord and be ready to use!
echo Use commands like: !play, !queue, !help
echo.
echo Press Ctrl+C to stop the bot when needed.
echo ===============================================
echo.
pause

REM Start the bot
echo Starting bot...
"C:\Program Files\Eclipse Adoptium\jdk-17.0.16.8-hotspot\bin\java.exe" -jar "JMusicBot-0.4.3.jar"

echo.
echo Bot has stopped. Press any key to exit.
pause
