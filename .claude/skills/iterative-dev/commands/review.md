# Project Review

Perform a comprehensive analysis of the project's current state.

## Process

### 1. Read the Authoritative Document

Read `.claude/project.md` in full — the vision, architecture, key decisions, and requirements checklist.

### 2. Analyze the Actual Project State

Explore the codebase to understand what actually exists:
- What files and directories are present
- What functionality is implemented
- What the code actually does vs. what project.md says it should do
- Git log for recent activity and trajectory

### 3. Identify Alignment Gaps

Compare what project.md describes against what the codebase contains:

- **Requirements marked done but not implemented** — checked off in project.md but the code doesn't support it
- **Implemented but not tracked** — functionality exists in the code but isn't reflected in the requirements
- **Architectural drift** — the codebase has diverged from the architecture described in project.md
- **Stale decisions** — key decisions that no longer make sense given how the project evolved
- **Missing requirements** — capabilities that are clearly needed based on the current state but aren't listed

### 4. Assess Trajectory

Look at the bigger picture:
- Is the project on track toward its vision?
- Are there patterns in the code that suggest a better architectural approach?
- Are there opportunities to simplify or consolidate?
- What are the highest-leverage next steps?
- Are there risks or technical debt accumulating?

### 5. Produce the Review

Present findings to the user organized by:

1. **Alignment gaps** — what's out of sync between project.md and the codebase
2. **Recommendations** — concrete suggestions for improving the project's trajectory
3. **Updated project.md** — if there are changes to make (new requirements, checked-off items, architectural updates), propose the specific edits

After the user reviews and approves changes, update `.claude/project.md` accordingly and commit.
