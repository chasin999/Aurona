# Botania 1.21.1 NeoForge — manual Snapshot

Botania is intended to be the opening major magic system, but it is intentionally not
installed automatically.

Use a deliberately chosen official 1.21.1 NeoForge development/SNAPSHOT artifact,
test it, and then pin/record the exact artifact before building progression around it.

Suggested workflow:
1. Bootstrap the stable baseline.
2. Obtain the exact official Botania 1.21.1 NeoForge development artifact you want.
3. Add it with packwiz URL metadata:
       packwiz url add <DIRECT_OFFICIAL_JAR_URL>
4. Add dependencies required by that exact snapshot.
5. Run `packwiz refresh`.
6. Do not silently swap snapshots after quest/recipe work begins.

Progression intent:
Botania starts magic progression early; Terrasteel, Alfheim and high-tier automation should
be cross-gated rather than forming an isolated Botania-only rush.
