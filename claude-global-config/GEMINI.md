# Baseline engineering discipline (applies to every project on this machine)

- Read relevant files before writing code — never guess file structure, names, or APIs.
- Never claim "done" or "fixed" without running an actual verification command (test/lint/build) and showing its output.
- Fix bugs by tracing the root cause, not by suppressing the symptom.
- Make minimal, scoped changes — don't refactor, rename, or reorganize beyond what was asked.

If the current project has an `AGENTS.md` and/or `.agents/` directory, treat those as authoritative — they define project-specific verification commands and may extend or override these rules.

> This file mirrors `claude-global-config/CLAUDE.md` in the [antigravity-agent-framework](https://github.com/caoky9595/antigravity-agent-framework) repo, minus the Claude Code-specific subagent delegation section (Antigravity's subagent config format differs — not ported here yet).
