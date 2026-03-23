# Next Session: Core Loop — Orchestrator + /birth

Read `PROJECT.md` for the full architecture. This session implements the core loop that everything else depends on.

## Goal

`/birth` produces a character, a world context, and the first formative event — ready for the player to respond in prose. The orchestrator processes that response as a turn, persists state, and generates the next event.

## What to Build

### 1. Orchestrator Agent (`.claude/agents/orchestrator.md`)

The main agent for the simulation. Its system prompt defines the turn protocol: read state → interpret → validate → propagate → update → generate → persist. It spawns subagents (psyche-agent, narrative-agent, etc.) as needed, but for this session, the orchestrator can handle the full loop itself — subagents come later.

Reference: `CLAUDE.md` defines the orchestrator's identity and turn protocol. The agent file should align with this but focus on the operational frontmatter (name, description, model, tools).

### 2. `/birth` Skill (`.claude/skills/birth/SKILL.md`)

Entry point for a new life. When invoked, it should direct the orchestrator to:
- Generate a society, generation, and character (or accept player input for period/constraints)
- Populate all state files: `society.json`, `generation.json`, `individual.json`, `network.json`, `timeline.json`
- Write the initial `scene.md` with the first formative event
- Initialize empty `decisions.jsonl` and `events.jsonl` logs
- Present the opening narrative to the player, ending with a situation that invites a prose response

### 3. Turn Processing

After `/birth`, every player message is a turn. The orchestrator (guided by `CLAUDE.md`) should:
- Read `scene.md` and relevant state
- Interpret the player's prose (what did they do, what does it mean psychologically)
- Update state files as needed
- Generate the next narrative event
- Write updated `scene.md`
- Append to decision and event logs

For this session, the orchestrator handles interpretation and generation directly. Dedicated subagents (psyche-agent, narrative-agent) are a future session.

## Key Constraints

- The orchestrator is set as main agent in `.claude/settings.json` — it's already configured
- State files go in `sim/state/`, logs in `sim/log/` — directories will be created on first write
- Hooks in `.claude/hooks/` already handle session startup and compaction
- `sim/config.json` has default parameters — the orchestrator should read these
- Don't build subagents yet — the orchestrator handles the full loop for now

## Definition of Done

1. `/birth` creates all state files and presents the first formative event
2. The player can respond in prose and the orchestrator advances the simulation
3. State persists to disk after each turn — `scene.md`, logs, and any profile updates
4. A resumed session (via the startup hook) loads state and continues seamlessly
