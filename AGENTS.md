# AI Agent Handbook (AGENTS.md)

> **Every agent MUST read and follow this file before executing any task.**

## 1. Project Context
- **Project name**: [Your project name]
- **Purpose**: [Brief description]
- **Stack**: [Target Languages / Frameworks]

## 2. MANDATORY CHECKLIST — Run Before Every Response

> [!CAUTION]
> These are **enforceable rules**, not suggestions. Violating any rule = failed task.

```
BEFORE starting any task, verify:
□ Is the request specific enough to act on (which file, what symptom, what expected outcome)?
□ If critically ambiguous → restate your understanding + ask ONE question. Don't guess intent.
□ If already clear enough → proceed directly, don't ask just to be safe.

BEFORE writing any code, verify:
□ Have I read the relevant files first? (Not guessing structure)
□ Am I using the project's existing patterns? (Check existing code)

BEFORE saying "Done" or "Fixed", verify:
□ Have I run the actual command (test/lint/build) and pasted FULL output?
□ Does the output show 0 failures / 0 errors?
□ If I haven't run verification → I MUST NOT claim completion

BEFORE fixing a bug, verify:
□ Have I traced the root cause? (Not just suppressing the error)
□ Can I explain WHY the bug happens, not just WHERE?

ALWAYS:
□ Use proper project logging (never use debug prints in production code)
□ Use specific exceptions/error handling (not bare catch-all)
□ Read from environment variables for secrets (never hardcode)
□ Add types/docstrings to public functions
```

## 3. Iron Laws (NON-NEGOTIABLE)

1. **NO GUESSING** — If you don't know the file structure, READ it first. Never fabricate file paths, function names, or outputs.
2. **NO COMPLETION WITHOUT EVIDENCE** — You must run the verification command and paste its output. "It should work" is not evidence.
3. **NO FIXES WITHOUT ROOT CAUSE** — Trace the data flow. Explain the chain: Error → Direct cause → Root cause → Hypothesis.
4. **MINIMAL CHANGES** — Fix what's asked. Don't refactor, rename, or reorganize things that aren't part of the task.
5. **NO ACTING ON AMBIGUITY** — If the request is missing a critical detail (which file, what "it" refers to, what "correct" looks like), restate your understanding and ask ONE clarifying question before proceeding. Don't silently guess intent — but don't ask when the request is already clear enough to act on, either; that's just friction.

## 4. Verification Commands (USE THESE — not just words)

Every rule above has a concrete verification. Run these, paste output:

| What to verify | Command |
|---------------|---------|
| Secrets, debug prints, bare errors, lint, tests | `bash .agents/scripts/pre_submit_check.sh` |
| Repository Map | `bash .agents/scripts/generate_repomap.sh` |
| Custom Project Tests | `[PROJECT_TEST_COMMAND]` |

> [!IMPORTANT]
> If you cannot run a verification command, STATE that explicitly:
> "I cannot verify because [reason]. Please run: `[command]`"
> NEVER silently skip verification.

## 5. Persistent Memory (Docs-as-Code)
- Save analysis/plans to `docs/ai/planning/` or `docs/ai/design/` for cross-session persistence
- Log lessons learned to `docs/ai/KNOWLEDGE.md` (Recovery Ledger)
- Use `docs/ai/repomap.txt` to understand project structure before guessing files

## 6. Tech Standards
- **Error Handling**: Use language-specific best practices, propagate errors correctly
- **Logging**: Structured logging preferred
- **Secrets**: Always use environment variables
- **MCP**: Prefer MCP Servers for external tool integration (DB, GitHub, Slack)
