@echo off
title Music Bot + Purge Bot - FULL SYSTEM
color 0B

echo ===============================================
echo      🎵 + 🧹 FULL BOT SYSTEM STARTUP 🧹 + 🎵
echo ===============================================
echo.
echo ✅ Starting BOTH bots for complete functionality:
echo   🎵 JMusicBot - Music streaming and playback
echo   🧹 PurgeBot - Message management and cleanup  
echo.
echo Both bots use the same Discord token and appear as ONE bot
echo with COMBINED functionality!
echo.
echo 📋 Available Commands After Startup:
echo.
echo 🎵 MUSIC COMMANDS:
echo   !play [song]     - Play music
echo   !queue          - Show music queue
echo   !skip           - Skip current song
echo   !stop           - Stop music
echo   !help           - Music bot help
echo.
echo 🧹 PURGE COMMANDS:
echo   !purge [number]           - Purge X messages
echo   !purge [keyword]          - Purge messages with keyword  
echo   !purge [number] [keyword] - Purge X messages with keyword
echo   !purgehelp               - Purge bot help
echo.
echo ===============================================
echo.
pause

echo 🚀 Starting Music Bot (JMusicBot)...
echo.
start "Music Bot" /D "%CD%" "C:\Program Files\Eclipse Adoptium\jdk-17.0.16.8-hotspot\bin\java.exe" -jar "JMusicBot-0.4.3.jar"

echo ⏳ Waiting 5 seconds for Music Bot to initialize...
timeout /t 5 /nobreak >nul

echo.
echo 🧹 Starting Purge Bot Module...
echo.
start "Purge Bot Module" /D "%CD%\purge-module" "C:\Program Files\Eclipse Adoptium\jdk-17.0.16.8-hotspot\bin\java.exe" -cp "purge-bot-simple.jar;lib\JDA-5.0.0-beta.21-withDependencies.jar" com.purgebot.PurgeBot

echo.
echo ===============================================
echo           🎉 BOTH BOTS ARE STARTING! 🎉       
echo ===============================================
echo.
echo ✅ Music Bot: Starting in separate window
echo ✅ Purge Bot: Starting in separate window
echo.
echo Your Discord bot now has COMPLETE functionality:
echo   🎵 Music streaming (!play, !queue, !skip, etc.)
echo   🧹 Message purging (!purge 10, !purge spam, etc.)
echo.
echo 🛑 TO STOP BOTH BOTS:
echo   - Close both terminal windows, OR
echo   - Run STOP_ALL_BOTS.bat
echo.
echo 🎯 Both bots are now running independently!
echo    Check the separate windows for their status.
echo.
pause
