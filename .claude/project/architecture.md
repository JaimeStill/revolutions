# Architecture

## Session Types

This project has two session types, distinguished by which skill initializes them:

- **Simulation session** (`/lifesim birth` or `/lifesim load`): The engine is running. Skills, agents, and hooks drive the simulation. `sim/.active` is set. Compaction hooks fire. The three-phase turn cycle is active.
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

## Agent Architecture

Agents are organized by role:

- **Orchestrator** — the main thread. Coordinates the turn cycle, delegates to other agents, renders the player's experience.
- **Domain agents** (`agents/domain/`) — own state files and process mechanics. Invoked at commit time.
- **Actor agents** (`agents/actors/`) — embody characters and perform within scenes. Invoked during the discussion phase. They don't own state — they perform and return.

### Domain Agents

Every state file has exactly one owning domain agent.

| Agent | Model | Owns | Role |
|-------|-------|------|------|
| **orchestrator** | inherit (Opus) | `scene.md`, `timeline.json` | Player interface, three-phase turn cycle, commit routing, narrative assembly, pacing |
| **psychology-agent** | sonnet | `individual.json` | Schema activation, defense assessment, value reordering, self-concept evolution |
| **network-agent** | sonnet | `network.json` | Social consequence propagation, gatekeepers, normative pressure |
| **world-agent** | sonnet | `society.json`, `period.md`, `generation.json` | World generation at birth, plausibility validation, tonal register |
| **codex-agent** | opus | `codex/*` | Literary synthesis from state diffs and discussion context |

### Actor Agents

| Agent | Model | Owns | Role |
|-------|-------|------|------|
| **persona-agent** | sonnet | nothing | Embodies a specific character for direct interaction with the player during events |

### Delegation Model

**At commit time:** The orchestrator delegates to domain agents whose state was affected. Each returns a consequence narrative. The orchestrator assembles results, writes coordination files, and presents the next scene.

**During events:** The orchestrator delegates character embodiment to the persona agent. The player interacts with the persona's output directly — the orchestrator relays transparently, only interjecting for scene transitions or when the player steps out of the interaction to address the orchestrator.

For domains without changes, no delegation. Routine commits may need no delegation at all.

### Tonal Sovereignty

The user sets the narrative register. The engine maintains it. Only the user can shift it. This principle is enforced at the orchestrator level and validated by the world agent against the tonal register captured in `period.md`.

## Skills

| Command | Purpose | Invocation |
|---------|---------|------------|
| `/lifesim birth` | World-building session, then initialize character, world, generation. Start a new life. | User |
| `/lifesim load <instance>` | Load an existing simulation instance into context. | User |
| `/lifesim exit` | Validate state, snapshot, synthesize if needed, commit, close simulation. | User |
| `/lifesim profile` | Render the current psychological state in human-readable form. | User or model |
| `/lifesim replay` | Reconstruct life narrative from codex and snapshots. | User |

Turn processing is not a sub-command. After birth or load, the three-phase cycle is active and the orchestrator handles everything.

## Hooks

No hooks are currently active. With the 1M context window and the orchestrator's stateless coordination model (domain agents own their state independently), compaction may be handled naturally without hook intervention. Previous compaction hooks (`session-compact.sh`, `pre-compact.sh`) were designed for the old "every message is a turn" model and have been retired.

Hooks will be revisited if a concrete need emerges — compaction issues, invariant enforcement, or automated behaviors that benefit from deterministic shell-level triggers.

## Context Management

State files are ground truth. The conversation is ephemeral.

- `scene.md` captures the current narrative moment, bridging continuity across compaction.
- The orchestrator is stateless — it reads state files at the start of each phase and writes at commit time. If compaction occurs, it reconstructs context from state files.
- The discussion phase generates the simulation's richest material, but it lives only in conversation. At commit time, the orchestrator captures essential narrative and psychological content in `scene.md` and through domain agent updates.
