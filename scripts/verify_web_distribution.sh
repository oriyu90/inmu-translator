#!/bin/bash
# 公開bundle検証 (Tango verify_web_distribution.sh の軽量版)
set -e
DIR="$(cd "$(dirname "$0")/.." && pwd)"
REQ="index.html style.css app.js goroku-core.json manifest.webmanifest icon.svg sw.js build-info.json"
for f in $REQ; do [ -f "$DIR/$f" ] || { echo "MISSING: $f"; exit 1; }; done
node --check "$DIR/app.js"
node "$DIR/scripts/eval-rule.mjs"
python3 -c "import json;[json.load(open('$DIR/'+f)) for f in ['goroku-core.json','manifest.webmanifest','build-info.json']];print('JSON OK')"
grep -q "192.168.0.114" "$DIR/app.js" || { echo "default LLM missing"; exit 1; }
grep -qi "apiKey.*[A-Za-z0-9]\{16,\}" "$DIR/app.js" && { echo "possible hardcoded secret"; exit 1; } || true
grep -q "noindex" "$DIR/index.html" || { echo "noindex missing"; exit 1; }
echo "VERIFY OK"
