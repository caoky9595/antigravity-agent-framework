# Cost-aware delegation (applies to every project)

Two subagents are available globally to control model cost — prefer delegating instead of doing everything in the main session:

- **quick-worker** (Haiku) — use for simple, mechanical, well-scoped work: renaming, formatting, boilerplate, straightforward multi-file edits, running/reading test output, search-and-replace. Delegate here by default for anything that doesn't need deep judgment.
- **deep-reasoner** (Opus) — use only for genuinely hard problems: architecture decisions, tricky bugs, security-sensitive design, algorithm tradeoffs. Don't reach for this by default — it's the expensive option.

Handle everything else directly in the main session at its current model. The goal: keep the main session on a mid-tier model, push bulk/mechanical work down to `quick-worker`, and escalate to `deep-reasoner` only when the task actually warrants it.

Any project can override this by defining its own `.claude/agents/quick-worker.md` / `deep-reasoner.md` — project-level definitions take precedence over these global ones.

# Baseline engineering discipline (applies even with no local project setup)

- Read relevant files before writing code — never guess file structure, names, or APIs.
- Never claim "done" or "fixed" without running an actual verification command (test/lint/build) and showing its output.
- Fix bugs by tracing the root cause, not by suppressing the symptom.
- Make minimal, scoped changes — don't refactor, rename, or reorganize beyond what was asked.
- If the request is missing a critical detail, restate your understanding and ask ONE question before proceeding — don't guess intent. If it's already clear enough, just proceed.

If the current project has an `AGENTS.md` and/or `.agents/` directory, treat those as authoritative — they define project-specific verification commands and may extend or override these rules.
