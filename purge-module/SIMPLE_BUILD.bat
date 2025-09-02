@echo off
title Building Purge Bot Module (Simple Build)
color 0E

echo ===============================================
echo     🔨 SIMPLE PURGE BOT BUILD (No Maven) 🔨  
echo ===============================================
echo.
echo This will compile the Discord purge bot without Maven...
echo.
echo Requirements:
echo - Java 17 or higher
echo - Internet connection (to download JDA library)
echo.
pause

echo ✅ Starting simple build process...
echo.

REM Create directories
echo 📁 Creating build directories...
if not exist "lib" mkdir "lib"
if not exist "build" mkdir "build"
if not exist "build\classes" mkdir "build\classes"

echo.
echo 📦 Downloading JDA library...
echo This may take a moment...

REM Download JDA JAR (using PowerShell)
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://github.com/DV8FromTheWorld/JDA/releases/download/v5.0.0-beta.21/JDA-5.0.0-beta.21-withDependencies.jar' -OutFile 'lib\JDA-5.0.0-beta.21-withDependencies.jar'}"

if %ERRORLEVEL% neq 0 (
    echo ❌ Failed to download JDA library
    echo Please check your internet connection and try again
    pause
    exit /b 1
)

echo ✅ JDA library downloaded successfully!
echo.

echo 🏗️ Compiling Java source code...

REM Compile with JDA on classpath
"C:\Program Files\Eclipse Adoptium\jdk-17.0.16.8-hotspot\bin\javac.exe" -cp "lib\JDA-5.0.0-beta.21-withDependencies.jar" -d "build\classes" "src\main\java\com\purgebot\PurgeBot.java"

if %ERRORLEVEL% neq 0 (
    echo ❌ Compilation failed
    pause
    exit /b 1
)

echo ✅ Compilation successful!
echo.

echo 📦 Creating executable JAR...

REM Create manifest file
echo Main-Class: com.purgebot.PurgeBot > build\MANIFEST.MF
echo Class-Path: lib/JDA-5.0.0-beta.21-withDependencies.jar >> build\MANIFEST.MF
echo. >> build\MANIFEST.MF

REM Create JAR file
"C:\Program Files\Eclipse Adoptium\jdk-17.0.16.8-hotspot\bin\jar.exe" cfm "purge-bot-simple.jar" "build\MANIFEST.MF" -C "build\classes" . 

if %ERRORLEVEL% neq 0 (
    echo ❌ JAR creation failed
    pause
    exit /b 1
)

echo ✅ JAR created successfully!
echo.

echo ===============================================
echo           🎉 BUILD SUCCESSFUL! 🎉           
echo ===============================================
echo.
echo ✅ Purge bot module has been built successfully!
echo ✅ JAR file: purge-bot-simple.jar
echo ✅ Dependencies: lib\JDA-5.0.0-beta.21-withDependencies.jar
echo.
echo Next steps:
echo 1. Configure your Discord token in purge-config.properties
echo 2. Run START_PURGE_BOT_SIMPLE.bat to start the module
echo.
echo The module is ready to use!
echo.
pause
