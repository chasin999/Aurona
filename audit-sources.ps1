Set-Location $PSScriptRoot

$rows = foreach ($file in Get-ChildItem .\mods\*.pw.toml -ErrorAction SilentlyContinue) {
    $text = Get-Content $file.FullName -Raw
    if ($text -match '\[update\.curseforge\]' -or $text -match 'metadata:curseforge') {
        $source = "CurseForge"
    } elseif ($text -match '\[update\.modrinth\]' -or $text -match 'metadata:modrinth') {
        $source = "Modrinth"
    } else {
        $source = "Other/URL"
    }

    [PSCustomObject]@{ File = $file.Name; Source = $source }
}

$rows | Sort-Object Source, File | Format-Table -AutoSize

Write-Host ""
Write-Host "Counts:" -ForegroundColor Cyan
$rows | Group-Object Source | Sort-Object Name | ForEach-Object {
    Write-Host ("  {0,-12} {1,4}" -f $_.Name, $_.Count)
}

$external = @($rows | Where-Object { $_.Source -ne "CurseForge" })
if ($external.Count -gt 0) {
    Write-Host ""
    Write-Host "Non-CurseForge metadata (may become external files in CF export):" -ForegroundColor Yellow
    $external | Format-Table -AutoSize
} else {
    Write-Host ""
    Write-Host "All mod metadata is CurseForge-backed." -ForegroundColor Green
}
