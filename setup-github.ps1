# GitHub Setup Helper Script
# This will help you configure the repository with your actual GitHub username

param(
    [Parameter(Mandatory=$true)]
    [string]$GitHubUsername
)

Write-Host "🐙 Setting up GitHub repository for username: $GitHubUsername" -ForegroundColor Green

# Update git remote URL
$newUrl = "https://github.com/$GitHubUsername/discord-music-bot.git"
Write-Host "📡 Updating remote URL to: $newUrl" -ForegroundColor Blue

git remote set-url origin $newUrl

# Update documentation files with correct username
Write-Host "📝 Updating documentation files..." -ForegroundColor Blue

# Update GitHub setup guide
(Get-Content "GITHUB_SETUP.md") -replace "HydrikMasqued", $GitHubUsername | Set-Content "GITHUB_SETUP.md"

# Update deployment files
(Get-Content "deploy.sh") -replace "hydrikmasqued", $GitHubUsername.ToLower() | Set-Content "deploy.sh"
(Get-Content ".github/workflows/deploy.yml") -replace "hydrikmasqued", $GitHubUsername.ToLower() | Set-Content ".github/workflows/deploy.yml"

# Update docker-compose if needed
(Get-Content "docker-compose.yml") -replace "hydrikmasqued", $GitHubUsername.ToLower() | Set-Content "docker-compose.yml"

Write-Host "✅ Configuration updated!" -ForegroundColor Green
Write-Host ""
Write-Host "🎯 Next steps:" -ForegroundColor Yellow
Write-Host "1. Go to: https://github.com/new" -ForegroundColor White
Write-Host "2. Repository name: discord-music-bot" -ForegroundColor White
Write-Host "3. Make it public" -ForegroundColor White
Write-Host "4. Don't initialize with anything" -ForegroundColor White
Write-Host "5. Create repository" -ForegroundColor White
Write-Host "6. Run: git push -u origin main" -ForegroundColor White
Write-Host ""
Write-Host "🔗 Your repository will be at:" -ForegroundColor Cyan
Write-Host "   https://github.com/$GitHubUsername/discord-music-bot" -ForegroundColor White
