---
name: iterative-dev
description: Iterative development workflow using .claude/project/ and .claude/init.md. Use when the user wants to bootstrap a new project, start a development session, wrap up a session, review project state, or asks about the iterative-dev workflow. Triggers on "new project", "bootstrap", "init", "wrap up", "next session", "generate init", "session closeout", "review project", "project review".
argument-hint: "[bootstrap|init|review]"
---

# Iterative Development Workflow

A lightweight, plan-mode-driven development workflow for personal projects. No issue trackers, no project boards — just a project directory and a session bootstrap that carry context between sessions.

## Sub-Commands

Route based on `$ARGUMENTS`:

| Command | File | Purpose |
|---------|------|---------|
| `bootstrap` | [commands/bootstrap.md](commands/bootstrap.md) | Scaffold a new project with the iterative-dev workflow |
| `init` | [commands/init.md](commands/init.md) | Start a session from `.claude/init.md` in plan mode |
| `review` | [commands/review.md](commands/review.md) | Analyze project state and alignment |

Read the corresponding command file and follow its instructions. If no sub-command is provided, explain the available commands and the workflow conventions below.

## Conventions

### `.claude/project/` — The Authoritative Document

The source of truth for the project, organized as a directory of focused files. `README.md` is the index — vision, high-level architecture, and pointers to detail files. Sub-files cover specific concerns (schemas, requirements, configuration, etc.).

Every session reads `README.md` to orient, then loads sub-files as needed. The structure adapts to the project, but generally:

- **README.md** — vision, how it works, high-level architecture, directory of sub-files
- **requirements.md** — checkbox list grouped by area, ordered by dependency
- Additional files as the project's complexity warrants

These documents are alive. Check off completed requirements. Add new ones as they emerge. Keep each file focused on a single concern.

### `.claude/init.md` — The Session Bootstrap

Generated at the end of each session. Defines the next session's focus. Used as the initial prompt in plan mode.

Structure: goal, what to build, key constraints, definition of done. Keep it focused — a session should have a clear, achievable scope.

### Branching

Each development session works on its own branch, created from `main` at session start. Branch names should be descriptive of the session's focus (e.g., `state-architecture-optimization`, `codex-layer`).

### The Development Loop

```
Start session
 └─ Create a branch from main
    └─ Read .claude/init.md in plan mode
       └─ Read .claude/project/README.md for context
          └─ Load relevant sub-files from .claude/project/
             └─ Plan the session scope
                └─ Execute implementation
                   └─ Pre-commit review
                      ├─ Reconcile project docs against changes
                      ├─ Discuss next steps with the user
                      └─ Write init.md from the discussion
                         └─ Commit, push, and open a PR
```

### Pre-Commit Review

Before committing, run a structured closeout with three parts:

1. **Reconcile project docs** — review `.claude/project/` against the session's changes. Check off completed requirements, update architecture/schema/state docs, add new sub-files if new concepts emerged. The goal: someone reading the project docs after this session sees a coherent, current picture.

2. **Discuss next steps** — have a genuine conversation with the user about what comes next:
   - If the next step is a **playtest**: note what was built and what to observe (written for the human — the engine runs pure with no awareness of evaluation). Also capture what development work is queued after the playtest cycle resolves, so there's a clear picture of the next build stage.
   - If the next step is a **dev session**: identify the next build target. Surface new ideas or directions beyond current requirements.
   - If there's **no obvious next step**: discuss openly. Review project state, what's working, what's incomplete. The conversation often reveals the next direction.

3. **Write `.claude/init.md`** — capture the discussion's outcome as the next session's bootstrap.
