#!/usr/bin/env bash
set -u
cd "$(dirname "$0")"

command -v packwiz >/dev/null 2>&1 || { echo "packwiz not found in PATH"; exit 1; }

: > source-fallbacks.log
: > bootstrap-failures.log

add_cf_preferred() {
  local cf="$1"
  local mr="$2"
  local name="$3"

  echo
  echo "[CF-first] $name"
  packwiz curseforge add "$cf" -y && return 0

  if [[ -n "$mr" ]]; then
    echo "  CF lookup failed; trying Modrinth fallback: $mr"
    if packwiz modrinth add "$mr" -y; then
      echo "$name -> Modrinth ($mr)" >> source-fallbacks.log
      return 0
    fi
  fi

  echo "$name [CF=$cf, MR=$mr]" >> bootstrap-failures.log
  return 1
}
add_cf_preferred "create" "create" "Create" || true
add_cf_preferred "immersive-engineering" "immersiveengineering" "Immersive Engineering" || true
add_cf_preferred "immersive-petroleum" "immersivepetroleum" "Immersive Petroleum" || true
add_cf_preferred "ender-io" "enderio" "Ender IO" || true
add_cf_preferred "pneumaticcraft-repressurized" "pneumaticcraft-repressurized" "PneumaticCraft: Repressurized" || true
add_cf_preferred "industrial-foregoing" "industrial-foregoing" "Industrial Foregoing" || true
add_cf_preferred "mekanism" "mekanism" "Mekanism" || true
add_cf_preferred "mekanism-generators" "mekanism-generators" "Mekanism Generators" || true
add_cf_preferred "applied-energistics-2" "ae2" "Applied Energistics 2" || true
add_cf_preferred "actually-additions" "actually-additions" "Actually Additions" || true
add_cf_preferred "rftools-base" "rftools-base" "RFTools Base" || true
add_cf_preferred "rftools-utility" "rftools-utility" "RFTools Utility" || true
add_cf_preferred "rftools-power" "rftools-power" "RFTools Power" || true
add_cf_preferred "rftools-builder" "rftools-builder" "RFTools Builder" || true
add_cf_preferred "rftools-dimensions" "rftools-dimensions" "RFTools Dimensions" || true
add_cf_preferred "just-dire-things" "just-dire-things" "Just Dire Things" || true
add_cf_preferred "draconic-evolution" "draconic-evolution" "Draconic Evolution" || true
add_cf_preferred "multiblocked2" "multiblocked2" "Multiblocked2" || true
add_cf_preferred "neovitae" "neovitae" "Neo Vitae" || true
add_cf_preferred "ars-nouveau" "ars-nouveau" "Ars Nouveau" || true
add_cf_preferred "occultism" "occultism" "Occultism" || true
add_cf_preferred "theurgy" "theurgy" "Theurgy" || true
add_cf_preferred "elemental-craft" "elemental-craft" "ElementalCraft" || true
add_cf_preferred "kubejs" "kubejs" "KubeJS" || true
add_cf_preferred "kubejs-create" "kubejs-create" "KubeJS Create" || true
add_cf_preferred "kubejs-mekanism" "kubejs-mekanism" "KubeJS Mekanism" || true
add_cf_preferred "lootjs" "lootjs" "LootJS" || true
add_cf_preferred "almost-unified" "almostunified" "Almost Unified" || true
add_cf_preferred "astages" "astages" "AStages" || true
add_cf_preferred "astages-ftb-quests" "astages-ftb-quests" "AStages FTB Quests" || true
add_cf_preferred "ftb-quests-forge" "" "FTB Quests" || true
add_cf_preferred "ftb-library-forge" "" "FTB Library" || true
add_cf_preferred "ftb-teams-forge" "" "FTB Teams" || true
add_cf_preferred "ftb-chunks-forge" "" "FTB Chunks" || true
add_cf_preferred "ftb-ultimine-forge" "" "FTB Ultimine" || true
add_cf_preferred "create-ultimine" "create-ultimine" "Create Ultimine" || true
add_cf_preferred "jei" "jei" "Just Enough Items" || true
add_cf_preferred "jade" "jade" "Jade" || true
add_cf_preferred "jade-addons" "jade-addons-forge" "Jade Addons" || true
add_cf_preferred "mouse-tweaks" "mouse-tweaks" "Mouse Tweaks" || true
add_cf_preferred "appleskin" "appleskin" "AppleSkin" || true
add_cf_preferred "controlling" "controlling" "Controlling" || true
add_cf_preferred "crafting-tweaks" "crafting-tweaks" "Crafting Tweaks" || true
add_cf_preferred "shulkerboxtooltip" "shulkerboxtooltip" "ShulkerBoxTooltip" || true
add_cf_preferred "modernfix" "modernfix" "ModernFix" || true
add_cf_preferred "ferritecore" "ferrite-core" "FerriteCore" || true
add_cf_preferred "embeddium" "embeddium" "Embeddium" || true
add_cf_preferred "immediatelyfast" "immediatelyfast" "ImmediatelyFast" || true
add_cf_preferred "entityculling" "entityculling" "Entity Culling" || true
add_cf_preferred "clumps" "clumps" "Clumps" || true
add_cf_preferred "spark" "spark" "spark" || true

packwiz refresh
[[ -s source-fallbacks.log ]] || rm -f source-fallbacks.log
[[ -s bootstrap-failures.log ]] || rm -f bootstrap-failures.log
echo "Bootstrap complete. Read BOTANIA-SNAPSHOT.md, then run ./audit-sources.sh before export."
