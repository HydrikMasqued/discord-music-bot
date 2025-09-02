# PowerShell script to download the latest JMusicBot release

Write-Host "====================================" -ForegroundColor Green
Write-Host "    JMusicBot Downloader" -ForegroundColor Green  
Write-Host "====================================" -ForegroundColor Green
Write-Host ""

try {
    Write-Host "Fetching latest release information..." -ForegroundColor Yellow
    
    # Get the latest release from GitHub API
    $releaseInfo = Invoke-RestMethod -Uri "https://api.github.com/repos/jagrosh/MusicBot/releases/latest"
    $latestVersion = $releaseInfo.tag_name
    
    Write-Host "Latest version: $latestVersion" -ForegroundColor Cyan
    
    # Find the JAR asset
    $jarAsset = $releaseInfo.assets | Where-Object { $_.name -like "*.jar" }
    
    if ($jarAsset) {
        $downloadUrl = $jarAsset.browser_download_url
        $fileName = $jarAsset.name
        
        Write-Host "Downloading: $fileName" -ForegroundColor Yellow
        Write-Host "From: $downloadUrl" -ForegroundColor Gray
        Write-Host ""
        
        # Download the file
        $progressPreference = 'SilentlyContinue'
        Invoke-WebRequest -Uri $downloadUrl -OutFile $fileName -UseBasicParsing
        $progressPreference = 'Continue'
        
        Write-Host "✅ Successfully downloaded: $fileName" -ForegroundColor Green
        Write-Host ""
        Write-Host "Next steps:" -ForegroundColor Cyan
        Write-Host "1. Edit config.txt with your bot token and owner ID"
        Write-Host "2. Run run_bot.bat to start the bot"
        Write-Host ""
    }
    else {
        Write-Host "❌ No JAR file found in the latest release." -ForegroundColor Red
    }
}
catch {
    Write-Host "❌ Error downloading: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "Manual download:" -ForegroundColor Yellow
    Write-Host "Visit: https://github.com/jagrosh/MusicBot/releases"
    Write-Host "Download the latest .jar file and place it in this folder."
}

Write-Host ""
Write-Host "Press any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
