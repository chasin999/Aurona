#!/usr/bin/env bash
set -u
cd "$(dirname "$0")"
add_cf_preferred(){ local cf="$1"; local mr="$2"; local name="$3"; echo "[CF-first] $name"; packwiz curseforge add "$cf" -y && return 0; [[ -n "$mr" ]] && packwiz modrinth add "$mr" -y && return 0; return 1; }
add_cf_preferred "dynamic-fps" "dynamic-fps" "Dynamic FPS" || true
add_cf_preferred "polymorph" "polymorph" "Polymorph" || true
add_cf_preferred "xaeros-minimap" "" "Xaero's Minimap" || true
add_cf_preferred "xaeros-world-map" "" "Xaero's World Map" || true
packwiz refresh
