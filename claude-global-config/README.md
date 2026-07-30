# Claude Code global config

Machine-level Claude Code settings — applies automatically to **every project** on a machine (as opposed to the rest of this repo, which is a per-project boilerplate). Controls which model handles what kind of task, to cut cost:

- `agents/quick-worker.md` — Haiku subagent for simple, mechanical, well-scoped work.
- `agents/deep-reasoner.md` — Opus subagent for genuinely hard problems (architecture, tricky bugs, security).
- `CLAUDE.md` — instructs Claude Code's main session to delegate to the above instead of doing everything itself.

## Setup on a new machine

```bash
git clone https://github.com/caoky9595/antigravity-agent-framework.git ~/Desktop/private/antigravity-agent-framework

mkdir -p ~/.claude/agents
ln -sf ~/Desktop/private/antigravity-agent-framework/claude-global-config/agents/quick-worker.md ~/.claude/agents/quick-worker.md
ln -sf ~/Desktop/private/antigravity-agent-framework/claude-global-config/agents/deep-reasoner.md ~/.claude/agents/deep-reasoner.md
ln -sf ~/Desktop/private/antigravity-agent-framework/claude-global-config/CLAUDE.md ~/.claude/CLAUDE.md
```

If `~/.claude/CLAUDE.md` or the agent files already exist as real files (not symlinks), back them up or merge their content first — `ln -sf` overwrites the symlink but will refuse to overwrite a regular file that already exists at the target in some shells; delete or move the existing file first if that happens.

## Updating

Edit the files here, commit, push. On other machines, `git pull` — Claude Code picks up the change automatically within seconds (no restart needed), since `~/.claude/agents/` and `~/.claude/CLAUDE.md` are symlinks into this repo.
