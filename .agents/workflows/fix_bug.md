# Workflow: Fix Bug

> Use this workflow for any bug fix. Follow steps IN ORDER, do NOT skip.

## Step 0: ROLE CHECK
What domain is this bug in (backend/frontend/database/mobile/...)? Check
`.agents/skills/agent-*/` (project-specific roles, NOT the 6 core workflow
skills) for one whose `description` already matches it.
- Match found → read that SKILL.md and apply its persona/coding standards for
  every step below.
- No match → run this to get the role-creation routine, follow it first, then continue:
```
test -f .agents/workflows/new_role.md && cat .agents/workflows/new_role.md || cat ~/.antigravity-agent-framework/.agents/workflows/new_role.md
```

## Step 1: REPRODUCE
```bash
# Read previous lessons — you might have seen this before
cat docs/ai/KNOWLEDGE.md

# Run the failing command/test — paste FULL output
[PROJECT_TEST_COMMAND] [path_to_failing_test] 2>&1
# Or reproduce via API call/CLI
curl -X [METHOD] [ENDPOINT]
```

## Step 2: ROOT CAUSE ANALYSIS
Write this template BEFORE writing any fix code:
```
Surface Error : [exact error message from Step 1]
Error Location: [file:line — from stack trace]
Root Cause    : [WHY it happens — trace data flow backwards]
Hypothesis    : "I believe [X] causes this because [Y]"
```
→ If you can't fill all 4 fields, you don't understand the bug yet. Read more code.

## Step 3: FIX
Apply the SMALLEST possible change to fix the root cause.
- Do NOT refactor other code
- Do NOT suppress the error with empty catch/except blocks
- Do NOT change unrelated files

## Step 4: VERIFY
Run BOTH commands and paste FULL output:
```bash
# 1. Verify the specific test passes
[PROJECT_TEST_COMMAND] [path_to_fixed_test] 2>&1

# 2. Verify nothing else broke
bash .agents/scripts/pre_submit_check.sh
```
→ Both must show ✅. If not → go back to Step 2.
→ After 3 failed attempts → STOP and ask user for guidance.

## Step 5: DOCUMENT
Add the lesson learned to `docs/ai/KNOWLEDGE.md`:
```markdown
### [TAG] Short description
- **Error**: error message
- **Root Cause**: why it happened
- **Fix Strategy**: what fixed it
- **Date**: YYYY-MM-DD
```

## Step 6: REPORT
```markdown
## 🔍 Fix Report

### Root Cause Analysis
Surface Error : [from Step 2]
Error Location: [from Step 2]
Root Cause    : [from Step 2]

### Fix Applied
`file.ext:L42`: `old_code` → `new_code`

### Verification Output
[paste FULL output from Step 4]
```
