# Start a Development Session

Begin a new session from `.claude/init.md`.

## Process

### 1. Read the Session Bootstrap

Read `.claude/init.md` to understand:
- What this session should focus on
- What "done" looks like
- Key constraints and considerations

### 2. Read the Project Context

Read `.claude/project.md` for full project context:
- Architecture and key decisions (so you don't relitigate them)
- Requirements checklist (so you know what's done and what's pending)
- Any conventions or patterns established in prior sessions

### 3. Plan the Implementation

Enter plan mode. Collaborate with the user on:
- How to approach the work defined in init.md
- Implementation details — which files to create/modify, what order
- Any design decisions that need to be made
- Anything in init.md that needs refinement based on current project state

The user trusts Claude with implementation details after alignment in the planning phase. Focus planning on conceptual alignment, not line-by-line code review.

### 4. Execute

Once the plan is approved, implement the work. After completing:

1. **Update `.claude/project.md`** — check off completed requirements, add any new ones that emerged
2. **Generate `.claude/init.md`** — read the remaining requirements, identify the next logical step, write the bootstrap for the next session
3. **Commit everything** — all session work, updated project.md, and new init.md in a single commit
