# Workflow: New Role

> Use this to create a new specialized domain skill/role (e.g. Backend Engineer,
> Database Architect, Frontend Specialist) tailored to THIS project's actual
> stack — not a generic template you copy-pasted from the internet.
>
> This runs two ways: explicitly (user typed `/new_role`), or automatically as
> "Step 0: ROLE CHECK" inside `fix_bug`/`new_feature`/`refactor` when no
> matching role exists yet for the task's domain. Either way, once created,
> immediately switch to using that role's persona to actually do the task —
> creating the file is not the end goal, using it is.

## Step 1: GET SCOPE
- **Auto-invoked from another workflow's Step 0** (the common case): INFER the
  role name/domain yourself from the task already in context — which files/layer
  it touches, what the user asked for. Do NOT stop to ask; asking here defeats
  the entire point of Step 0 being automatic.
- **Invoked standalone as `/new_role` with no other task in context**: use
  whatever role name the user gave; if they said nothing at all, ask.
- Slugify to kebab-case, ALWAYS prefixed with `agent-` (e.g. "Backend Engineer"
  → `agent-backend`). The prefix is mandatory, not cosmetic: `.agents/skills/`
  also holds the 6 core workflow skills (`fix_bug`, `new_feature`, `quick_fix`,
  `refactor`, `update_docs`, `new_role`), which are symlinks back to the shared
  framework repo — if a role slug ever collided with one of those names, writing
  the new SKILL.md would corrupt the shared file for every project on the
  machine. Never pick a slug without the `agent-` prefix.

## Step 2: ANALYZE PROJECT (Iron Law #1 — no guessing)
```bash
cat docs/ai/repomap.txt 2>/dev/null || bash .agents/scripts/generate_repomap.sh
```
- Detect language/framework/key deps from whatever manifest actually exists
  (`package.json`, `requirements.txt`/`pyproject.toml`, `go.mod`, `Cargo.toml`,
  `composer.json`, ...). Read it — don't assume.
- Open 2-3 real source files relevant to this role's domain to learn the
  naming conventions, error-handling style, and test framework already in use.
- If the repo is empty/new and nothing project-specific exists yet, say so
  explicitly in the draft instead of inventing conventions.

## Step 3: DRAFT SKILL.md
Write `.agents/skills/<role-slug>/SKILL.md` — same YAML frontmatter shape
(`name`, `description`) as the other core skills — with a body covering:
- **Persona**: 1-2 sentences on who this role is and what it owns.
- **Tech stack**: only what Step 2 actually found, citing the file(s) it came from.
- **Coding standards**: patterns observed in THIS repo, not generic best practices.
- A closing line stating this role still obeys the project's root `AGENTS.md`
  Iron Laws — it extends them, it never replaces them.

If nothing useful was found in Step 2 for a section, write "not yet
established in this repo" instead of guessing — leave it for the user to fill in.

## Step 4: REPORT
```markdown
## 🧩 New Role Created: [Role Name]

### Based on
- [file(s) actually read in Step 2]

### Saved to
`.agents/skills/<role-slug>/SKILL.md`

### Note
This role only applies to the current project — unlike the 6 core workflow
skills, it is a real file, not symlinked back to the framework repo.
```

If Step 0 of the calling workflow is still in progress, continue it now using
this role's persona — do not stop here and wait.
