# Global config (machine-level)

Machine-level settings — applies automatically to **every project** on a machine (as opposed to the rest of this repo, which is a per-project boilerplate you run `init.sh` against). Covers three tools:

- `CLAUDE.md` — for Claude Code (`~/.claude/CLAUDE.md`). Instructs the main session to delegate to `agents/quick-worker.md` (Haiku, mechanical work) / `agents/deep-reasoner.md` (Opus, genuinely hard problems) instead of doing everything itself, plus a baseline-discipline block (no guessing, no claiming "done" without verification, root-cause fixes, minimal diffs) that applies even in a project with no local `AGENTS.md`.
- `agents/quick-worker.md`, `agents/deep-reasoner.md` — the two subagents referenced above.
- The 6 skills under `../.agents/skills/` — symlinked into `~/.claude/skills/<name>/SKILL.md` so `/fix_bug`, `/new_feature`, `/quick_fix`, `/refactor`, `/update_docs`, `/new_role` work in Claude Code on any project, init'd or not. Cursor also picks these up for free if it reads `~/.claude/{agents,skills}` directly (recent Cursor behavior — best-effort, not a guaranteed contract).
- `GEMINI.md` — for Google Antigravity (`~/.gemini/GEMINI.md`). Same baseline-discipline block, minus the Claude Code-specific subagent section (Antigravity's subagent frontmatter format differs — not ported yet). Antigravity's global config path/format is still inconsistent across its own docs, so this link is best-effort; verify it's picked up.

## Setup on a new machine

```bash
git clone https://github.com/caoky9595/antigravity-agent-framework.git ~/Desktop/private/antigravity-agent-framework
~/Desktop/private/antigravity-agent-framework/machine-setup.sh
```

`machine-setup.sh` is its own file (not a flag on `init.sh`) specifically so it's tab-completable — nothing to remember, just `./m` + Tab. It's a thin wrapper around `init.sh --machine-setup`, which stays the single source of truth for the actual symlinking logic. Read `init.sh` at the repo root for the exact commands it runs — kept in one script rather than duplicated here in prose, so this doc can't drift out of sync with what it actually does.

Run it with no arguments and it opens a native checklist dialog (macOS `osascript`, Linux `zenity`/`kdialog`, plain text prompts as a last resort) asking which of the two targets to wire up:
- **Claude Code + Cursor (`~/.claude`)** — one option, not two: Cursor has no config of its own here, it only piggybacks on Claude Code's `~/.claude/{agents,skills}`, so there's no way to enable one without the other.
- **Google Antigravity (`~/.gemini`)** — independent of the above.

To skip the dialog (scripting, repeat runs): `./machine-setup.sh --claude-only`, `--antigravity-only`, or `--all`.

If any of these targets already exist as a **real file** (not a symlink), `init.sh` will skip it and print a warning rather than overwrite it — back up or remove the existing file, then re-run.

## Troubleshooting

**`⚠ skip ... (real file, not touching it)`** — one of the global targets (`~/.claude/CLAUDE.md`, `~/.claude/agents/*.md`, `~/.claude/skills/*/SKILL.md`, `~/.gemini/GEMINI.md`, `~/.antigravity-agent-framework`) already exists as a real file, not a symlink, so `init.sh` refuses to touch it — this is a deliberate guard against silently destroying something you or another tool wrote there. To resolve:

1. **Inspect it first**: `cat <path>` (or `wc -c <path>` to quickly check if it's empty — e.g. some tools create an empty placeholder file like `~/.gemini/GEMINI.md` before you ever set this framework up).
2. **Empty or nothing you need** → `rm <path>`, then re-run `./machine-setup.sh`.
3. **Has real content you want to keep** → back it up first (`mv <path> <path>.bak`), decide whether to merge its content into the framework's version (e.g. paste it into `claude-global-config/CLAUDE.md` or `GEMINI.md` and commit), then `rm <path>` and re-run.

Never force-overwrite (`rm -f` + blind relink) without checking step 1 first — that's exactly the silent-destruction case this guard exists to prevent.

## Updating

Edit the files here, commit, push. On other machines, `git pull` — Claude Code (and Antigravity/Cursor where applicable) pick up the change automatically within seconds (no restart needed), since everything under `~/.claude/` and `~/.gemini/GEMINI.md` is a symlink into this repo.

## Per-project setup

See the root [README.md](../README.md) — `init.sh <path>` wires the per-project half (skills/workflows symlinked, `AGENTS.md`/`docs/ai/`/`pre_submit_check.sh` scaffolded).
