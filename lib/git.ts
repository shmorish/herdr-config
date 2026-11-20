import { exec } from "herdr";

// git を、index の lock も fsmonitor も触らずに呼ぶ（watch を起こさない・他の git とぶつからない）。`on`: 別マシンの名前
export const git = (cwd: string, args: string[], on?: string | null) =>
  exec("git", ["--no-optional-locks", "-c", "core.fsmonitor=false", ...args], { cwd, on });
