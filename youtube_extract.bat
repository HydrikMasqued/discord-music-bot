@echo off
title YouTube URL Extractor for Discord Bot
color 0C
echo.
echo ===============================================
echo    🎵 YOUTUBE URL EXTRACTOR FOR DISCORD 🎵
echo ===============================================
echo.
echo This tool extracts working YouTube URLs for your Discord bot
echo Uses yt-dlp (2025.08.11) - latest YouTube extraction
echo.

if "%~1"=="" (
    set /p search="Enter YouTube search term: "
) else (
    set search=%*
)

echo.
echo 🔍 Searching YouTube for: %search%
echo.

REM Get the audio URL using yt-dlp
for /f "delims=" %%i in ('.\yt-dlp.exe --get-url --format "bestaudio" "ytsearch:%search%" 2^>nul') do (
    set audio_url=%%i
    goto :found
)

echo ❌ No results found for: %search%
goto :end

:found
echo ✅ Found YouTube audio!
echo.
echo 📋 COPY THIS URL AND USE IN DISCORD:
echo.
echo !play %audio_url%
echo.
echo ===============================================
echo INSTRUCTIONS:
echo 1. Copy the URL above (starts with https://)
echo 2. In Discord, type: !play [paste URL here]
echo 3. The bot should play YouTube audio successfully!
echo ===============================================
echo.

:end
pause
