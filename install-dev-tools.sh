#!/usr/bin/env bash
set -u
cd "$(dirname "$0")"
add_cf_preferred(){ local cf="$1"; local mr="$2"; local name="$3"; echo "[CF-first] $name"; packwiz curseforge add "$cf" -y && return 0; [[ -n "$mr" ]] && packwiz modrinth add "$mr" -y && return 0; return 1; }
add_cf_preferred "probejs" "probejs" "ProbeJS" || true
add_cf_preferred "kubejs-studio" "kubejs-studio" "KubeJS Studio" || true
packwiz refresh
