$ErrorActionPreference = "Continue"
Set-Location $PSScriptRoot
function Add-CFPreferred($Entry) {
    Write-Host "[CF-first] $($Entry.name)" -ForegroundColor Cyan
    & packwiz curseforge add $Entry.cf -y
    if ($LASTEXITCODE -eq 0) { return }
    if ($Entry.mr -ne "") {
        Write-Host "  Falling back to Modrinth: $($Entry.mr)" -ForegroundColor Yellow
        & packwiz modrinth add $Entry.mr -y
    }
}

$projects = @(
    @{ cf="probejs"; mr="probejs"; name="ProbeJS" },
    @{ cf="kubejs-studio"; mr="kubejs-studio"; name="KubeJS Studio" }
)
foreach ($entry in $projects) { Add-CFPreferred $entry }
& packwiz refresh
