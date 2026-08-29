# Expert 1.21.1 NeoForge — packwiz starter v0.1.2

This revision is CurseForge-first.

## Baseline
- Minecraft 1.21.1
- NeoForge 21.1.224
- Canonical release: CurseForge ZIP
- Default map: FTB Chunks
- Recipe viewer: JEI
- Botania: planned opening magic system, manual Snapshot

## IMPORTANT
Use a fresh directory. Do not copy v0.1.2 over a v0.1 folder that already contains
generated `mods/*.pw.toml`, because differing CF/MR slugs can leave duplicate metadata.

## Bootstrap
Windows:
```powershell
./bootstrap.ps1
```

Linux/macOS:
```bash
./bootstrap.sh
```

Bootstrap behavior:
1. Try CurseForge metadata.
2. Fall back to Modrinth only if needed.
3. Resolve dependencies through packwiz.
4. Save any fallback to `source-fallbacks.log`.

## Audit
```powershell
./audit-sources.ps1
```

## Build
```powershell
./build-curseforge.ps1
```

or:
```powershell
packwiz refresh
packwiz cf export
```

## Default QoL
- FTB Ultimine
- Create Ultimine
- FTB Chunks
- JEI
- Jade + Jade Addons
- Mouse Tweaks
- AppleSkin
- Controlling
- Crafting Tweaks
- ShulkerBoxTooltip

## Default performance / diagnostics
- ModernFix
- FerriteCore
- Embeddium
- ImmediatelyFast
- Entity Culling
- Clumps
- spark

## Optional client
- Dynamic FPS
- Polymorph
- Xaero's Minimap
- Xaero's World Map

FTB Chunks remains the default map. Polymorph is intentionally optional because an expert pack
should normally fix recipe conflicts itself.

## Optional server
- ServerCore
- Alternate Current
- Chunky

## Balance reminders
- Gate/limit Ultimine around the ore-vein progression.
- Do not let Industrial Foregoing Laser Drill invalidate physical mining progression.
- Treat RFTools Dimensions as late-game resource engineering.
- Draconium ore should require physical + chemical + nuclear processing.
- Awakened Draconium should culminate in a tech/magic process involving Neo Vitae.
- Use Multiblocked2 for unique cross-discipline facilities, not as a replacement for every machine.
