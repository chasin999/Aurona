#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
packwiz refresh
./audit-sources.sh
packwiz curseforge export
