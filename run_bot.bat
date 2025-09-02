@echo off
title Discord Music Bot
echo.
echo ===================================
echo      Discord Music Bot Launcher
echo ===================================
echo.

REM Check if Java is installed
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Java is not installed or not in PATH!
    echo Please install Java 11 or higher from:
    echo https://www.oracle.com/java/technologies/downloads/
    echo.
    pause
    exit /b 1
)

echo Java detected. Starting bot...
echo.

REM Look for JMusicBot jar files
for %%f in (JMusicBot*.jar) do (
    echo Found: %%f
    echo Starting bot...
    REM Try Java 17 first, then fall back to system Java
    "C:\Program Files\Eclipse Adoptium\jdk-17.0.16.8-hotspot\bin\java.exe" -jar "%%f" 2>nul || java -jar "%%f"
    goto :found
)

REM If no jar found, provide instructions
echo ERROR: No JMusicBot jar file found!
echo.
echo Please do one of the following:
echo 1. Download JMusicBot jar from: https://github.com/jagrosh/MusicBot/releases
echo 2. Or compile from source by running: compile_bot.bat
echo.
pause
exit /b 1

:found
pause
