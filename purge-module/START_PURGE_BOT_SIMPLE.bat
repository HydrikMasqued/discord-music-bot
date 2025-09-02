@echo off
title Discord Purge Bot Module - RUNNING (Simple Build)
color 0A

echo ===============================================
echo         🧹 STARTING PURGE BOT MODULE 🧹     
echo ===============================================
echo.
echo ✅ Modular Discord message purging functionality
echo ✅ Can be easily stopped/removed without affecting music bot
echo ✅ Uses same Discord token as your main music bot
echo.

REM Check if the JAR file exists
if not exist "purge-bot-simple.jar" (
    echo ❌ Purge bot JAR not found!
    echo.
    echo Please build the module first by running:
    echo SIMPLE_BUILD.bat
    echo.
    pause
    exit /b 1
)

REM Check if JDA library exists
if not exist "lib\JDA-5.0.0-beta.21-withDependencies.jar" (
    echo ❌ JDA library not found!
    echo.
    echo Please build the module first by running:
    echo SIMPLE_BUILD.bat
    echo.
    pause
    exit /b 1
)

REM Check if config file exists
if not exist "purge-config.properties" (
    echo ❌ Configuration file not found!
    echo.
    echo Please ensure purge-config.properties exists and contains your Discord token.
    echo.
    pause
    exit /b 1
)

echo 📋 Available Purge Commands:
echo   !purge [number]           - Purge X messages
echo   !purge [keyword]          - Purge messages with keyword
echo   !purge [number] [keyword] - Purge X messages with keyword
echo   !purgehelp               - Show detailed help
echo.
echo ⚠️  Requirements:
echo   • MANAGE_MESSAGES permission (for users)
echo   • Bot needs MANAGE_MESSAGES + MESSAGE_HISTORY permissions
echo.
echo ===============================================
echo.
echo 🚀 Starting Purge Bot Module...
echo Use Ctrl+C to stop the bot
echo.

REM Start the bot using Java 17 with JDA on classpath
"C:\Program Files\Eclipse Adoptium\jdk-17.0.16.8-hotspot\bin\java.exe" -cp "purge-bot-simple.jar;lib\JDA-5.0.0-beta.21-withDependencies.jar" com.purgebot.PurgeBot

echo.
echo ===============================================
echo Purge Bot Module has stopped.
echo.
echo Common reasons for stopping:
echo • Manually stopped with Ctrl+C
echo • Token expired/invalid  
echo • Network connection issues
echo • Bot not invited to servers
echo.
echo To restart: Run START_PURGE_BOT_SIMPLE.bat again
echo To remove module: Delete the purge-module folder
echo ===============================================
pause
