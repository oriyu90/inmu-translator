// 回帰評価: app.js の実コードから ruleConvert を抽出して期待出力と比較
import { readFileSync } from "node:fs";
import { fileURLToPath } from "node:url";
import path from "node:path";
const dir = path.dirname(path.dirname(fileURLToPath(import.meta.url))) + "/";
const src = readFileSync(dir + "app.js", "utf8");
const m = src.match(/const ALIAS[\s\S]*?return \{ text: t\.slice\(0, 300\), used \};\n\}/);
if (!m) { console.error("rule extract failed"); process.exit(1); }
const ruleConvert = new Function(`${m[0]}; return ruleConvert;`)();
const cases = JSON.parse(readFileSync(dir + "scripts/eval-cases.json", "utf8"));
let fail = 0;
for (const c of cases) {
  const got = ruleConvert(c.input, c.mode, c.level).text;
  if (got !== c.expected) { console.error(`NG ${JSON.stringify(c.input)} => ${JSON.stringify(got)} (want ${JSON.stringify(c.expected)})`); fail++; }
  if (/ますゾ|ですねぇ|ますゾ〜/.test(got)) { console.error(`NG mechanical: ${JSON.stringify(got)}`); fail++; }
}
if (fail) process.exit(1);
console.log(`EVAL OK (${cases.length} cases)`);
