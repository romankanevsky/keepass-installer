#Requires -RunAsAdministrator
# KeePass + plugins installer (auto-fetches latest releases from GitHub API)

# Установка KeePass
winget install DominikReichl.KeePass -e --accept-package-agreements --accept-source-agreements

# Плагины: repo owner/name + фильтр для .plgx файла
$plugins = @(
    @{ Repo = "xatupal/KeeTheme";                    Pattern = "KeeTheme.plgx" }
    @{ Repo = "sirAndros/KeePassWinHello";            Pattern = "*.plgx" }
    @{ Repo = "ligos/readablepassphrasegenerator";    Pattern = "*.plgx" }
    @{ Repo = "Kyrodan/KeeAnywhere";                  Pattern = "*.plgx" }
)

$pluginDir = "C:\Program Files\KeePass Password Safe 2\Plugins"
New-Item -ItemType Directory -Path $pluginDir -Force | Out-Null

foreach ($plugin in $plugins) {
    $repo = $plugin.Repo
    Write-Host "[$repo] Fetching latest release..." -ForegroundColor Cyan
    try {
        $release = Invoke-RestMethod -Uri "https://api.github.com/repos/$repo/releases/latest" -UseBasicParsing
        $asset = $release.assets | Where-Object { $_.name -like $plugin.Pattern } | Select-Object -First 1
        if (-not $asset) {
            Write-Host "  No .plgx found in latest release assets" -ForegroundColor Red
            continue
        }
        $outFile = Join-Path $pluginDir $asset.name
        Write-Host "  Downloading $($asset.name) (v$($release.tag_name))..." -ForegroundColor Cyan
        Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $outFile -UseBasicParsing
        Write-Host "  OK" -ForegroundColor Green
    } catch {
        Write-Host "  FAILED: $_" -ForegroundColor Red
    }
}

Write-Host "`nDone. Restart KeePass to load plugins." -ForegroundColor Yellow
