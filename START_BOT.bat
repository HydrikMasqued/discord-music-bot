@echo off
title Discord Music Bot - Ready to Launch
color 0A
echo.
echo ===============================================
echo        🎵 MUSIC BOT IS READY! 🎵
echo ===============================================
echo.
echo ✅ CONFIGURATION COMPLETE:
echo   • Discord Token: Configured from your old bot
echo   • Owner User ID: 181143017619587073 (YOU)
echo   • Java Version: Java 17 ✅
echo   • Command Prefix: ! (exclamation mark)
echo   • Bot Files: JMusicBot-0.4.3.jar ready
echo.
echo ===============================================
echo            🎮 BOT COMMANDS
echo ===============================================
echo.
echo Basic Music Commands:
echo   !play [song name]     - Play music
echo   !queue               - Show song queue  
echo   !skip                - Skip current song
echo   !stop                - Stop music
echo   !pause               - Pause music
echo   !resume              - Resume music
echo   !volume [0-100]      - Set volume
echo   !help                - Show all commands
echo.
echo Owner Commands (Only you can use):
echo   !shutdown            - Stop the bot
echo   !settings            - Bot settings
echo.
echo ===============================================
echo.
echo 🚀 STARTING YOUR DISCORD MUSIC BOT...
echo.
echo The bot will connect to Discord servers where it's invited.
echo Use Ctrl+C to stop the bot when needed.
echo.
echo If the bot stops immediately, check:
echo 1. Your Discord token is still valid
echo 2. The bot is invited to at least one Discord server
echo 3. The bot has proper permissions in your server
echo.
echo ===============================================
echo.
pause

REM Start the bot with Java 17
"C:\Program Files\Eclipse Adoptium\jdk-17.0.16.8-hotspot\bin\java.exe" -jar "JMusicBot-0.4.3.jar"

echo.
echo ===============================================
echo Bot has stopped running.
echo.
echo Common reasons:
echo • Token expired/invalid
echo • Bot not invited to any servers
echo • No internet connection
echo • Manually stopped with Ctrl+C
echo.
echo To restart: Run START_BOT.bat again
echo ===============================================
pause
