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

Once the plan is approved, implement the work.

### 6. Pre-Commit Review

Before committing, run a structured closeout:

#### 6a. Reconcile Project Docs

Review `.claude/project/` against the session's changes:
- **`requirements.md`** — check off completed items, add new ones that emerged
- **`README.md`** — does the vision or directory structure need updating?
- **Other sub-files** — do architecture, schemas, simulation, state, or configuration docs need revision? Did new concepts emerge that warrant a new sub-file?

The goal is that someone reading the project docs after this session sees a coherent, current picture of the engine.

#### 6b. Reconcile Simulation State

If any simulation instances exist in `sim/`, evaluate whether the session's changes affect them. Check:

- **State files** — do any state file formats or expectations need updating to align with new mechanics?
- **Codex** — do codex entries need revision to reflect new engine capabilities or changed conventions?
- **Configuration** — does `config.json` need new fields or adjusted parameters?
- **Consistency** — does the simulation's current state make sense given the mechanics that now govern it?

Not every dev session will affect existing simulations. If nothing changed that touches simulation state, skip this step. But when the engine evolves in ways that change how state is interpreted or generated, existing instances should be brought into alignment rather than left to drift.

#### 6c. Plan Next Steps

Have a conversation with the user about what comes next. This is not a rubber stamp — it's a genuine discussion. Cover:

**If the next step is a playtest:**
- What was built that needs validation?
- What should the user pay attention to during the simulation? (This is a note *to the user* — the engine runs pure with no awareness that evaluation is happening.)
- What development work is queued after the playtest cycle resolves? This ensures that once playtesting and any tuning it produces are complete, there's a clear picture of the next development stage.

**If the next step is a development session:**
- What's the next logical build target from remaining requirements?
- Are there new ideas or directions worth exploring? The user may have ambitions beyond the current requirements — features, infrastructure, integrations — that should be surfaced and discussed here.

**If there's no obvious next step:**
- Discuss openly. Review the project's current state, what's working well, what feels incomplete. See if there's something compelling to target. The conversation itself often reveals the next direction.

#### 6d. Write `.claude/init.md`

Capture the discussion's outcome as the next session's bootstrap:
- Goal, scope, constraints, definition of done (for dev sessions)
- Observation notes and queued development work (for playtest sessions)
- Any new ideas or directions that were discussed but deferred

### 7. Commit, Push, and PR

Stage all session work, commit, push the branch, and open a pull request against `main`.
