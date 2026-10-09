#!/bin/bash
# studio-rizi 配下へstage (Tango stage_web_release.sh の軽量版)
# 使い方: bash scripts/stage_web_release.sh --studio-rizi "/Users/yuki/適当フォルダ/studio-rizi"
set -e
SRC="$(cd "$(dirname "$0")/.." && pwd)"
DEST=""
while [ $# -gt 0 ]; do case "$1" in --studio-rizi) DEST="$2"; shift 2;; *) shift;; esac; done
[ -n "$DEST" ] || { echo "usage: --studio-rizi <path>"; exit 1; }
TARGET="$(cd "$DEST" && pwd)/website/projects/inmu-translator/web"
[ -f "$DEST/AGENTS.md" ] || { echo "not studio-rizi"; exit 1; }
case "$TARGET" in */website/projects/inmu-translator/web) ;; *) echo "bad target"; exit 1;; esac
bash "$SRC/scripts/verify_web_distribution.sh"
mkdir -p "$TARGET"
for f in index.html style.css app.js goroku-core.json manifest.webmanifest icon.svg sw.js build-info.json; do cp "$SRC/$f" "$TARGET/$f"; done
echo "STAGED -> $TARGET"
echo "after: cd $DEST && npm run build && npm run validate"
