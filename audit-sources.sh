#!/usr/bin/env bash
cd "$(dirname "$0")"
echo "Non-CurseForge metadata:"
found=0
for f in mods/*.pw.toml; do
  [[ -e "$f" ]] || continue
  if grep -Eq '\[update\.curseforge\]|metadata:curseforge' "$f"; then
    :
  else
    echo "  $f"
    found=1
  fi
done
[[ "$found" -eq 1 ]] || echo "  none"
