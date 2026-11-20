import { theme } from "herdr";
import type { Color } from "gpui-kit";

// theme() は各色を "#rrggbb" の文字列で返すが、型は string なので Color として扱う
export type Theme = Record<string, Color>;
export const colors = () => theme() as Theme;
