@echo off
title Java Update Helper
color 0E
echo.
echo ===============================================
echo         Java Update Helper for MusicBot
echo ===============================================
echo.
echo Current Java version detected:
java -version
echo.
echo ===============================================
echo.
echo ERROR: JMusicBot requires Java 11 or higher!
echo Your current Java version (8) is too old.
echo.
echo To fix this, please download and install a newer Java version:
echo.
echo 1. RECOMMENDED - Eclipse Temurin (OpenJDK):
echo    https://adoptium.net/
echo    - Choose Java 17 or 21 (LTS versions)
echo    - Download the Windows x64 MSI installer
echo.
echo 2. Oracle Java:
echo    https://www.oracle.com/java/technologies/downloads/
echo    - Choose Java 17 or 21
echo    - May require Oracle account for newer versions
echo.
echo 3. Using Windows Package Manager (if you have winget):
echo    winget install EclipseAdoptium.Temurin.17.JDK
echo.
echo ===============================================
echo.
echo After installing newer Java:
echo 1. Restart this command prompt
echo 2. Run: java -version (to verify)
echo 3. Run: run_bot.bat (to start the music bot)
echo.
echo ===============================================
echo.
echo Would you like to open the Java download page?
set /p choice="Enter Y to open download page, or any other key to exit: "
if /i "%choice%"=="y" (
    start https://adoptium.net/
    echo.
    echo Download page opened in your browser.
    echo Install Java 17 or 21, then restart your command prompt.
)
echo.
pause
