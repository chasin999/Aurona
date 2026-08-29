$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
& packwiz refresh
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
& .\audit-sources.ps1
& packwiz curseforge export
exit $LASTEXITCODE
