@echo off
title Discord Music Bot - Quick Setup
color 0A
echo.
echo =============================================
echo     Discord Music Bot - Quick Setup
echo =============================================
echo.
echo This will help you set up your Discord music bot quickly.
echo.
echo BEFORE STARTING, make sure you have:
echo 1. Created a Discord application and bot
echo 2. Copied your bot token
echo 3. Found your Discord User ID
echo.
echo Instructions for both are in SETUP_INSTRUCTIONS.md
echo.
pause

REM Check if config file exists
if not exist "config.txt" (
    echo ERROR: config.txt not found!
    pause
    exit /b 1
)

echo.
echo Opening config.txt for editing...
echo Please edit the following lines:
echo - Replace BOT_TOKEN_HERE with your bot token
echo - Replace 0 // OWNER ID with your Discord User ID
echo.
pause

REM Open config file in default text editor
notepad.exe config.txt

echo.
echo Configuration file opened. After saving your changes:
echo.
echo 1. Make sure you've invited the bot to your Discord server
echo 2. Run run_bot.bat to start the bot
echo.
echo For detailed instructions, see SETUP_INSTRUCTIONS.md
echo.
pause
