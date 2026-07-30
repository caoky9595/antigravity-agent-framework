# Workflow: New Feature

> Use this for adding a new feature. Follow steps IN ORDER.

## Step 0: ROLE CHECK
What domain is this feature in (backend/frontend/database/mobile/...)? Check
`.agents/skills/agent-*/` (project-specific roles, NOT the 6 core workflow
skills) for one whose `description` already matches it.
- Match found → read that SKILL.md and apply its persona/coding standards for
  every step below.
- No match → run this to get the role-creation routine, follow it first, then continue:
```
test -f .agents/workflows/new_role.md && cat .agents/workflows/new_role.md || cat ~/.antigravity-agent-framework/.agents/workflows/new_role.md
```

## Step 1: UNDERSTAND
```bash
# Read project structure — don't guess
cat docs/ai/repomap.txt
# Read previous lessons
cat docs/ai/KNOWLEDGE.md
# Read any existing architecture/design docs, if present
cat docs/ai/design/*.md 2>/dev/null
# Read relevant source files
cat <relevant_file>
```
List the files you read: [file1, file2, ...]

## Step 2: PLAN
Write a brief plan:
- Files to create/modify
- Function/API signatures
- Database/State changes
- Data flow (input → process → output)

Save plan to: `docs/ai/planning/[feature-name].md`

## Step 3: IMPLEMENT
Write code following the project's existing patterns:
□ Follow architectural layering (e.g., Controller → Service)
□ Add types/interfaces/docstrings where appropriate
□ Use project's preferred logging (not print/console.log)
□ Handle specific exceptions properly
□ Never hardcode secrets

## Step 4: VERIFY
Run ALL commands and paste FULL output:
```bash
# 1. Lint and format (using your project's linter)
[PROJECT_LINT_COMMAND]

# 2. Build / Type Check
[PROJECT_BUILD_COMMAND]

# 3. Full quality check
bash .agents/scripts/pre_submit_check.sh
```
→ Fix any ❌ errors before reporting done.

## Step 5: REPORT
```markdown
## ✅ Feature Complete: [Name]

### Files changed
- `file.ext` — [what changed]

### Verification Output
[paste FULL pre_submit_check.sh output]
```
