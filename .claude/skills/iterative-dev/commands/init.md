# Start a Development Session

Begin a new session from `.claude/init.md`.

## Process

### 1. Create a Session Branch

Create a new branch from `main` with a name descriptive of the session's focus:

```bash
git checkout main
git pull
git checkout -b <descriptive-branch-name>
```

### 2. Read the Session Bootstrap

Read `.claude/init.md` to understand:
- What this session should focus on
- What "done" looks like
- Key constraints and considerations

### 3. Read the Project Context

Read `.claude/project/README.md` for project orientation:
- Vision and high-level architecture
- Pointers to detail files for deeper context

Load relevant sub-files from `.claude/project/` based on what the session touches (e.g., `requirements.md` for the checklist, `schemas.md` if working on state, etc.).

### 4. Plan the Implementation

Enter plan mode. Collaborate with the user on:
- How to approach the work defined in init.md
- Implementation details — which files to create/modify, what order
- Any design decisions that need to be made
- Anything in init.md that needs refinement based on current project state

The user trusts Claude with implementation details after alignment in the planning phase. Focus planning on conceptual alignment, not line-by-line code review.

### 5. Execute

Once the plan is approved, implement the work. After completing:

1. **Update `.claude/project/`** — check off completed requirements, update any sub-files that changed (architecture, schemas, etc.)
2. **Generate `.claude/init.md`** — read the remaining requirements, identify the next logical step, write the bootstrap for the next session
3. **Commit** — all session work, updated project files, and new init.md
4. **Push and open a PR** — push the branch and create a pull request against `main`
