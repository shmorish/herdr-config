import { layout } from "herdr";

// layouts/<name>.json のノードのうち、mod が読むところ
export interface LayoutNode {
  id?: string;
  hidden?: boolean;
  active?: string;
  size?: { px?: number };
  traffic_lights?: [number, number];
  children?: LayoutNode[];
}

export const root = () => layout() as LayoutNode | null;

export function find(node: LayoutNode | null | undefined, id: string): LayoutNode | null {
  if (node?.id === id) return node;
  for (const child of node?.children ?? []) {
    const found = find(child, id);
    if (found) return found;
  }
  return null;
}

// サイドバーのレール表示はフラグでなく幅で決まる（端をドラッグして細くしてもそうなる）
export const narrow = () => (find(root(), "sidebar")?.size?.px ?? Infinity) < 160;
