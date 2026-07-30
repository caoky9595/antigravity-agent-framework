# Cost-aware delegation (applies to every project)

Two subagents are available globally to control model cost — prefer delegating instead of doing everything in the main session:

- **quick-worker** (Haiku) — use for simple, mechanical, well-scoped work: renaming, formatting, boilerplate, straightforward multi-file edits, running/reading test output, search-and-replace. Delegate here by default for anything that doesn't need deep judgment.
- **deep-reasoner** (Opus) — use only for genuinely hard problems: architecture decisions, tricky bugs, security-sensitive design, algorithm tradeoffs. Don't reach for this by default — it's the expensive option.

Handle everything else directly in the main session at its current model. The goal: keep the main session on a mid-tier model, push bulk/mechanical work down to `quick-worker`, and escalate to `deep-reasoner` only when the task actually warrants it.

Any project can override this by defining its own `.claude/agents/quick-worker.md` / `deep-reasoner.md` — project-level definitions take precedence over these global ones.
