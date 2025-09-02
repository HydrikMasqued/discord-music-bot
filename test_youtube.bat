@echo off
title YouTube Extraction Test
echo.
echo ===============================================
echo        🎵 YOUTUBE EXTRACTION TEST 🎵
echo ===============================================
echo.
echo Testing if yt-dlp can extract YouTube audio...
echo This will test the latest yt-dlp (2025.08.11) against YouTube
echo.

set /p search="Enter a YouTube search term or URL: "

echo.
echo 🔍 Searching YouTube...
.\yt-dlp.exe --get-title --get-url --format "bestaudio" "ytsearch:%search%"

echo.
echo ===============================================
echo.
echo If you see a title and URL above, yt-dlp is working!
echo This means YouTube extraction is possible with latest tools.
echo.
pause
