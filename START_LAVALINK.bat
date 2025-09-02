@echo off
title Lavalink Audio Server
color 0B
echo.
echo ===============================================
echo        🎵 STARTING LAVALINK SERVER 🎵
echo ===============================================
echo.
echo Lavalink provides updated YouTube support for music bots
echo This server runs separately and handles all audio processing
echo.
echo Starting Lavalink v4.1.1...
echo - Updated YouTube extractors
echo - Multiple client support (MUSIC, ANDROID, WEB)
echo - Better anti-bot circumvention
echo.
echo Server will run on: localhost:2333
echo Password: youshallnotpass
echo.
echo ===============================================
echo.

REM Check if Java is available
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Java not found!
    pause
    exit /b 1
)

echo Starting Lavalink server...
echo.
echo NOTE: Keep this window open while using the music bot
echo The bot will connect to this server for YouTube support
echo.
echo Press Ctrl+C to stop the server
echo ===============================================
echo.

"C:\Program Files\Eclipse Adoptium\jdk-17.0.16.8-hotspot\bin\java.exe" -jar Lavalink.jar

echo.
echo ===============================================
echo Lavalink server has stopped.
echo The music bot will not work without this server running.
echo ===============================================
pause
