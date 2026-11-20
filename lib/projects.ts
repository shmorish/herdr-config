import { home } from "herdr";
import * as fs from "fs/promises";

// ~/.config/herdr-app/projects.json の案件フォルダ（~ を展開した絶対パス）。無い・壊れているときは []
export async function loadProjects(): Promise<string[]> {
  try {
    return (JSON.parse(await fs.readFile(`${home()}/.config/herdr-app/projects.json`, "utf8")) as string[]).map((d) => d.replace(/^~/, home()));
  } catch {
    return [];
  }
}
