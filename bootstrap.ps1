$ErrorActionPreference = "Continue"
Set-Location $PSScriptRoot

if (-not (Get-Command packwiz -ErrorAction SilentlyContinue)) {
    Write-Host "ERROR: packwiz is not available in PATH." -ForegroundColor Red
    exit 1
}

$fallbacks = New-Object System.Collections.Generic.List[string]
$failed = New-Object System.Collections.Generic.List[string]

function Add-CFPreferred($Entry) {
    Write-Host ""
    Write-Host "[CF-first] $($Entry.name)" -ForegroundColor Cyan

    & packwiz curseforge add $Entry.cf -y
    if ($LASTEXITCODE -eq 0) { return }

    if ($Entry.mr -ne "") {
        Write-Host "  CF lookup failed; trying Modrinth fallback: $($Entry.mr)" -ForegroundColor Yellow
        & packwiz modrinth add $Entry.mr -y
        if ($LASTEXITCODE -eq 0) {
            $fallbacks.Add("$($Entry.name) -> Modrinth ($($Entry.mr))")
            return
        }
    }

    $failed.Add("$($Entry.name) [CF=$($Entry.cf), MR=$($Entry.mr)]")
}

$projects = @(
    @{ cf="create"; mr="create"; name="Create" },
    @{ cf="immersive-engineering"; mr="immersiveengineering"; name="Immersive Engineering" },
    @{ cf="immersive-petroleum"; mr="immersivepetroleum"; name="Immersive Petroleum" },
    @{ cf="ender-io"; mr="enderio"; name="Ender IO" },
    @{ cf="pneumaticcraft-repressurized"; mr="pneumaticcraft-repressurized"; name="PneumaticCraft: Repressurized" },
    @{ cf="industrial-foregoing"; mr="industrial-foregoing"; name="Industrial Foregoing" },
    @{ cf="mekanism"; mr="mekanism"; name="Mekanism" },
    @{ cf="mekanism-generators"; mr="mekanism-generators"; name="Mekanism Generators" },
    @{ cf="applied-energistics-2"; mr="ae2"; name="Applied Energistics 2" },
    @{ cf="actually-additions"; mr="actually-additions"; name="Actually Additions" },
    @{ cf="rftools-base"; mr="rftools-base"; name="RFTools Base" },
    @{ cf="rftools-utility"; mr="rftools-utility"; name="RFTools Utility" },
    @{ cf="rftools-power"; mr="rftools-power"; name="RFTools Power" },
    @{ cf="rftools-builder"; mr="rftools-builder"; name="RFTools Builder" },
    @{ cf="rftools-dimensions"; mr="rftools-dimensions"; name="RFTools Dimensions" },
    @{ cf="just-dire-things"; mr="just-dire-things"; name="Just Dire Things" },
    @{ cf="draconic-evolution"; mr="draconic-evolution"; name="Draconic Evolution" },
    @{ cf="multiblocked2"; mr="multiblocked2"; name="Multiblocked2" },
    @{ cf="neovitae"; mr="neovitae"; name="Neo Vitae" },
    @{ cf="ars-nouveau"; mr="ars-nouveau"; name="Ars Nouveau" },
    @{ cf="occultism"; mr="occultism"; name="Occultism" },
    @{ cf="theurgy"; mr="theurgy"; name="Theurgy" },
    @{ cf="elemental-craft"; mr="elemental-craft"; name="ElementalCraft" },
    @{ cf="kubejs"; mr="kubejs"; name="KubeJS" },
    @{ cf="kubejs-create"; mr="kubejs-create"; name="KubeJS Create" },
    @{ cf="kubejs-mekanism"; mr="kubejs-mekanism"; name="KubeJS Mekanism" },
    @{ cf="lootjs"; mr="lootjs"; name="LootJS" },
    @{ cf="almost-unified"; mr="almostunified"; name="Almost Unified" },
    @{ cf="astages"; mr="astages"; name="AStages" },
    @{ cf="astages-ftb-quests"; mr="astages-ftb-quests"; name="AStages FTB Quests" },
    @{ cf="ftb-quests-forge"; mr=""; name="FTB Quests" },
    @{ cf="ftb-library-forge"; mr=""; name="FTB Library" },
    @{ cf="ftb-teams-forge"; mr=""; name="FTB Teams" },
    @{ cf="ftb-chunks-forge"; mr=""; name="FTB Chunks" },
    @{ cf="ftb-ultimine-forge"; mr=""; name="FTB Ultimine" },
    @{ cf="create-ultimine"; mr="create-ultimine"; name="Create Ultimine" },
    @{ cf="jei"; mr="jei"; name="Just Enough Items" },
    @{ cf="jade"; mr="jade"; name="Jade" },
    @{ cf="jade-addons"; mr="jade-addons-forge"; name="Jade Addons" },
    @{ cf="mouse-tweaks"; mr="mouse-tweaks"; name="Mouse Tweaks" },
    @{ cf="appleskin"; mr="appleskin"; name="AppleSkin" },
    @{ cf="controlling"; mr="controlling"; name="Controlling" },
    @{ cf="crafting-tweaks"; mr="crafting-tweaks"; name="Crafting Tweaks" },
    @{ cf="shulkerboxtooltip"; mr="shulkerboxtooltip"; name="ShulkerBoxTooltip" },
    @{ cf="modernfix"; mr="modernfix"; name="ModernFix" },
    @{ cf="ferritecore"; mr="ferrite-core"; name="FerriteCore" },
    @{ cf="embeddium"; mr="embeddium"; name="Embeddium" },
    @{ cf="immediatelyfast"; mr="immediatelyfast"; name="ImmediatelyFast" },
    @{ cf="entityculling"; mr="entityculling"; name="Entity Culling" },
    @{ cf="clumps"; mr="clumps"; name="Clumps" },
    @{ cf="spark"; mr="spark"; name="spark" }
)

foreach ($entry in $projects) { Add-CFPreferred $entry }

Write-Host ""
Write-Host "Refreshing pack index..." -ForegroundColor Yellow
& packwiz refresh

if ($fallbacks.Count -gt 0) {
    $fallbacks | Set-Content -Encoding UTF8 "source-fallbacks.log"
    Write-Host ""
    Write-Host "Modrinth fallbacks used:" -ForegroundColor Yellow
    $fallbacks | ForEach-Object { Write-Host "  - $_" }
} else {
    Remove-Item "source-fallbacks.log" -ErrorAction SilentlyContinue
}

if ($failed.Count -gt 0) {
    $failed | Set-Content -Encoding UTF8 "bootstrap-failures.log"
    Write-Host ""
    Write-Host "Unresolved projects:" -ForegroundColor Red
    $failed | ForEach-Object { Write-Host "  - $_" }
} else {
    Remove-Item "bootstrap-failures.log" -ErrorAction SilentlyContinue
}

Write-Host ""
Write-Host "Bootstrap complete." -ForegroundColor Green
Write-Host "Botania is not auto-added; read BOTANIA-SNAPSHOT.md." -ForegroundColor Yellow
Write-Host "Run .\audit-sources.ps1 before export."
