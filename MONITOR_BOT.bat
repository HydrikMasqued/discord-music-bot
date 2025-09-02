@echo off
title Music Bot Monitor
color 0E
echo.
echo ===============================================
echo         🎵 MUSIC BOT MONITORING 🎵
echo ===============================================
echo.

:LOOP
echo [%TIME%] Checking bot status...

REM Check if bot process is running
tasklist /FI "IMAGENAME eq java.exe" /FO CSV | find /I "java.exe" >nul
if %errorlevel% equ 0 (
    echo ✅ Bot process is RUNNING
    
    REM Get memory usage
    for /f "tokens=5" %%a in ('tasklist /FI "IMAGENAME eq java.exe" /FO TABLE ^| findstr java.exe') do (
        echo 📊 Memory usage: %%a
    )
    
    REM Check log files for activity
    if exist "bot_output.log" (
        echo 📋 Latest log entries:
        powershell -Command "Get-Content 'bot_output.log' -Tail 3 -ErrorAction SilentlyContinue"
    )
    
    if exist "bot_error.log" (
        for /f %%A in ('powershell -Command "Get-Content 'bot_error.log' -ErrorAction SilentlyContinue | Measure-Object -Line | Select-Object -ExpandProperty Lines"') do (
            if %%A gtr 0 (
                echo ⚠️ ERRORS DETECTED:
                powershell -Command "Get-Content 'bot_error.log' -Tail 5 -ErrorAction SilentlyContinue"
            )
        )
    )
    
) else (
    echo ❌ Bot process is NOT RUNNING
    echo.
    echo 🔄 Restarting bot...
    start /B "" "C:\Program Files\Eclipse Adoptium\jdk-17.0.16.8-hotspot\bin\java.exe" -jar "JMusicBot-0.4.3.jar" > bot_output.log 2> bot_error.log
    echo ✅ Bot restart initiated
)

echo.
echo ===============================================
echo         🎮 TESTING INSTRUCTIONS
echo ===============================================
echo.
echo To test your bot in Discord:
echo.
echo 1. Make sure the bot is invited to your server
echo 2. Join a voice channel
echo 3. In any text channel, type:
echo    !help           (to test basic response)
echo    !ping           (to check latency)
echo    !play test      (to test music functionality)
echo.
echo 4. Watch this monitor for bot activity
echo.
echo Press Ctrl+C to stop monitoring
echo ===============================================
echo.

REM Wait 30 seconds before next check
timeout /t 30 /nobreak
echo.
goto LOOP
