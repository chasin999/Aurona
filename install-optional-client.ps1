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
    @{ cf="dynamic-fps"; mr="dynamic-fps"; name="Dynamic FPS" },
    @{ cf="polymorph"; mr="polymorph"; name="Polymorph" },
    @{ cf="xaeros-minimap"; mr=""; name="Xaero's Minimap" },
    @{ cf="xaeros-world-map"; mr=""; name="Xaero's World Map" }
)
foreach ($entry in $projects) { Add-CFPreferred $entry }
& packwiz refresh
