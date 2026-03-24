# Architecture

## Session Types

This project has two session types, distinguished by which skill initializes them:

- **Simulation session** (`/lifesim birth` or `/lifesim load`): The engine is running. Skills, agents, and hooks drive the simulation. `sim/.active` is set. Compaction hooks fire. Every player message is a turn.
- **Development session** (`/iterative-dev`): We're iterating on the engine itself. Project docs and init.md drive the session. No simulation is active. Hooks guard on `sim/.active` and no-op.

## Claude Code as Simulation Engine

These constraints define the simulation's physics:

1. **Flat agent hierarchy.** Subagents cannot spawn subagents. The orchestrator is the main thread; all others are leaf workers.
2. **Context window = frame budget.** State read into context is "rendered." State on disk is cold storage. LOD management is deciding which files to read.
3. **Skills are prompt injections.** `/lifesim birth` loads directives into the orchestrator's context. It is an instruction, not a program.
4. **Hooks are deterministic.** Shell scripts that enforce invariants. They can't reason, but they always run. They guard on `sim/.active` to distinguish session types.
5. **No inter-agent communication.** Subagents return results to the orchestrator. All coordination flows through the main thread.
6. **Persistence = files.** JSON and markdown in `sim/` are the only state that survives across turns and sessions.
7. **Model routing is per-agent.** Haiku for cheap/fast validation, Sonnet for nuanced interpretation, Opus for deep reasoning.

## Agents

The orchestrator runs as the session's main agent via `settings.json`. Currently the orchestrator handles all turn processing directly. Subagent decomposition is future architecture:

| Agent | Model | Responsibility | Status |
|-------|-------|---------------|--------|
| **orchestrator** | inherit (Opus) | Main thread. Turn processing, state I/O, context budget. | Active |
| **world-agent** | haiku | Validate actions against period possibility space. | Future |
| **network-agent** | haiku | Process social consequences of decisions. | Future |
| **psyche-agent** | sonnet | Interpret player prose, update psychological profile. | Future |
| **narrative-agent** | sonnet | Generate formative events targeting active tensions. | Future |
| **ancestor-agent** | haiku / sonnet | Retroactively resolve ancestry from expressed psychology. | Future |

## Skills

| Command | Purpose | Invocation |
|---------|---------|------------|
| `/lifesim birth` | Initialize character, world, generation. Start a new life. | User |
| `/lifesim load <instance>` | Load an existing simulation instance into context. | User |
| `/lifesim exit` | Snapshot state, synthesize codex, commit, close simulation. | User |
| `/lifesim profile` | Render the current psychological state in human-readable form. | User or model |
| `/lifesim replay` | Reconstruct life narrative from codex and snapshots. | User |

Turn processing is not a sub-command. After birth or load, every player message is a turn handled by the orchestrator directly.

## Hooks

| Hook Event | Matcher | Purpose |
|------------|---------|---------|
| `SessionStart` | `compact` | Rebuild context from the active instance's state files after compaction. Guards on `sim/.active`. |
| `PreCompact` | — | Validate critical state files exist before compaction fires. Guards on `sim/.active`. |

## Context Management

State files are ground truth. The conversation is ephemeral.

- `CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=60` triggers compaction at 60% capacity — early and fast.
- `PreCompact` hook validates state files exist before compaction.
- `SessionStart` hook with `compact` matcher rebuilds context from state files. The compaction summary is irrelevant — state files are authoritative.
- `scene.md` captures the current narrative moment, bridging continuity across compaction.
- At 60% threshold, compaction is fast (less to summarize) and reclaims ~40% of the window.
