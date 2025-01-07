import { readFileSync, writeFileSync } from "fs";

const rows = readFileSync("./test-fonts.sh", "utf8").split("\n");

let symbolMap = "";
let isCapturing = false;

for (let i = 0; i < rows.length; i++) {
  const row = rows[i];

  if (row.includes("function test-fonts() {")) {
    isCapturing = true;
    continue;
  }

  if (isCapturing) {
    if (row.includes(`echo "`)) {
      const match = row.match(/"(.*)"/);
      if (match) {
        const [, title] = match;
        symbolMap += `# ${title}\n`;
      }
    } else if (row.includes(`print-unicode-ranges`)) {
      const match = row.match(/print-unicode-ranges (.*)/);
      if (match) {
        let [, codes] = match;
        codes = codes.split(" ");
        let ranges = [];

        for (let j = 0; j < codes.length; j += 2) {
          ranges.push([codes[j], codes[j + 1]]);
        }

        ranges = ranges.map(([first, last]) => `U+${first}-U+${last}`);
        symbolMap += `symbol_map ${ranges.join(",")} Symbols Nerd Font\n\n`;
      }
    } else if (row.includes("}")) {
      break;
    }
  }
}

writeFileSync("./symbol-map.conf", symbolMap);

console.log("done");
