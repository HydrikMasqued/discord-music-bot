@echo off
title Building Purge Bot Module
color 0E

echo ===============================================
echo        🔨 BUILDING PURGE BOT MODULE 🔨      
echo ===============================================
echo.
echo This will compile the Discord purge bot module...
echo.
echo Requirements:
echo - Java 17 or higher
echo - Maven (will try to download if not found)
echo.
pause

echo ✅ Starting build process...
echo.

REM Check if Maven is available
mvn --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ❌ Maven not found on system PATH
    echo.
    echo Please install Maven or use the provided Maven wrapper
    echo Download from: https://maven.apache.org/download.cgi
    echo.
    pause
    exit /b 1
)

echo ✅ Maven found, proceeding with build...
echo.

REM Clean and compile
echo 🧹 Cleaning previous builds...
call mvn clean

if %ERRORLEVEL% neq 0 (
    echo ❌ Clean failed
    pause
    exit /b 1
)

echo.
echo 🏗️ Compiling and packaging...
call mvn package -DskipTests

if %ERRORLEVEL% neq 0 (
    echo ❌ Build failed
    pause
    exit /b 1
)

echo.
echo ===============================================
echo           🎉 BUILD SUCCESSFUL! 🎉           
echo ===============================================
echo.
echo ✅ Purge bot module has been built successfully!
echo ✅ JAR file location: target\purge-bot-1.0.0.jar
echo.
echo Next steps:
echo 1. Configure your Discord token in purge-config.properties
echo 2. Run START_PURGE_BOT.bat to start the module
echo 3. Use STOP_PURGE_BOT.bat to stop the module
echo.
echo The module is ready to use!
echo.
pause
