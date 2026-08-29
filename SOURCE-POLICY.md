# Source policy

Canonical source strategy: CurseForge-first.

- Prefer CurseForge metadata when an official/current project exists there.
- Fall back to Modrinth only when CurseForge lookup/build availability fails.
- Use URL metadata only for deliberately pinned special artifacts, such as Botania snapshots.
- Run `audit-sources.ps1` before release.
- Canonical release artifact: `packwiz cf export`.
- External bundled files must comply with their licenses and CurseForge's current submission rules.
- Once progression scripting begins, update major mods one-by-one instead of blindly using update --all.
