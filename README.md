# 淫夢語録風変換器 Web（実システム・Tango Pro Web風ローカルファースト）

上欄入力→変換→下欄出力＋コピー。履歴はIndexedDB（削除可）。AIは自宅LM Studio直結が既定。

## 既定接続
- BaseURL `http://localhost:1234/v1`（このPCのLM Studio）/ Modelは［取得］で一覧から選択 / キーなし
- 自宅サーバ `http://192.168.0.114:1234/v1` はプリセット切替で使用可
- Anthropic（要キー・ブラウザ直行）・OpenAI・OpenRouter・Ollama対応

## 自宅で使う（本命）
```bash
cd inmu-goroku-translator
npx wrangler pages dev . --ip 0.0.0.0 --port 8788
# 同一LAN端末で http://<PCのIP>:8788 を開く
```

## 公開（studio-riziにstage・Tango方式）
```bash
bash scripts/verify_web_distribution.sh
bash scripts/stage_web_release.sh --studio-rizi "/Users/yuki/適当フォルダ/studio-rizi"
# studio-rizi側: npm run build && npm run validate → pushは承認後
```
公開URL想定：`https://studio-rizi.pages.dev/projects/inmu-translator/web/`
本番httpsから自宅LLMを叩くにはcloudflared tunnelのhttps URLを設定（詳細は `03_構成と作業書.md` §4）。

## 文書
- `01_設計書.md` 要件・分析・方針 / `02_仕様書.md` API・プロンプト原文 / `03_構成と作業書.md` 実機構成・手順・検証
