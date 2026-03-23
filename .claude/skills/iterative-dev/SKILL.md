---
name: iterative-dev
description: Iterative development workflow using .claude/project.md and .claude/init.md. Use when the user wants to bootstrap a new project, start a development session, wrap up a session, review project state, or asks about the iterative-dev workflow. Triggers on "new project", "bootstrap", "init", "wrap up", "next session", "generate init", "session closeout", "review project", "project review".
argument-hint: "[bootstrap|init|review]"
---

# Iterative Development Workflow

A lightweight, plan-mode-driven development workflow for personal projects. No issue trackers, no project boards — just two files that carry context between sessions.

## Sub-Commands

Route based on `$ARGUMENTS`:

| Command | File | Purpose |
|---------|------|---------|
| `bootstrap` | [commands/bootstrap.md](commands/bootstrap.md) | Scaffold a new project with the iterative-dev workflow |
| `init` | [commands/init.md](commands/init.md) | Start a session from `.claude/init.md` in plan mode |
| `review` | [commands/review.md](commands/review.md) | Analyze project state and alignment |

Read the corresponding command file and follow its instructions. If no sub-command is provided, explain the available commands and the workflow conventions below.

## Conventions

### `.claude/project.md` — The Authoritative Document

The single source of truth for the project. Contains vision, architecture, key decisions, and a requirements checklist. Every session reads this to understand where the project is and what needs doing.

Adapt the structure to the project, but generally:
- **Vision** — what and why
- **How It Works** — high-level system explanation
- **Architecture** — components, data flow, constraints
- **Key Decisions** — what was decided and why (so future sessions don't relitigate)
- **Requirements** — checkbox list grouped by area, ordered by dependency

This document is alive. Check off completed requirements. Add new ones as they emerge.

### `.claude/init.md` — The Session Bootstrap

Generated at the end of each session. Defines the next session's focus. Used as the initial prompt in plan mode.

Structure: goal, what to build, key constraints, definition of done. Keep it focused — a session should have a clear, achievable scope.

### The Development Loop

```
Start session
 └─ Read .claude/init.md in plan mode
    └─ Read .claude/project.md for context
       └─ Plan the session scope
          └─ Execute implementation
             └─ Check off requirements in project.md
                └─ Generate new init.md for next session
                   └─ Commit + exit
```

### Session Closeout

At the end of every session:

1. Update `.claude/project.md` — check off completed requirements, add new ones
2. Write `.claude/init.md` — identify the next logical step from remaining requirements
3. Commit everything together — all session work, updated project.md, new init.md
