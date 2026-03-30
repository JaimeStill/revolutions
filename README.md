# Revolutions

A human lifecycle simulator where Claude Code is the engine.

## What Is This

Revolutions simulates a human life — from birth through death and potentially beyond — under specific cultural and historical conditions. The simulation can be set in any world: historical, fantasy, sci-fi, alt-history, or any hybrid. Every decision is a free-form prose response to a narrative event. No menus, no numbered choices. The player and engine co-author a life through conversation.

The simulation models psychological development through a seven-layer profile grounded in established theory (attachment theory, schema therapy, Schwartz's values, narrative identity). Characters grow, accumulate wounds, develop defenses, and face formative events structured around developmental psychology inflection points.

The engine treats Claude Code's context window as its frame buffer, its agents as processing units, its file system as the persistence layer, and its architectural constraints as the simulation's physics.

## How It Works

1. Run `claude` in this directory
2. `/lifesim birth` — start a new life. A collaborative session establishes the world, the character, and the first scene. Birth is parameterized: create a protagonist at any point in a life (age 0 through late life), generate a non-protagonist character within an active simulation, or build a new world from scratch.
3. Respond to narrative events in prose. The engine operates in a three-phase cycle: **scene** (the orchestrator presents a situation), **discussion** (player and engine co-author what happens), **commit** (domain agents process state changes, the next scene is presented).
4. `/lifesim fork` — promote a network character to their own simulation. Take someone who exists in the current life's social network and play from their perspective in the same world.
5. `/lifesim exit` — save and close. State is snapshotted, the codex is synthesized, and everything is committed.
6. `/lifesim load` — resume where you left off.

Each simulation instance lives in `sim/<instance-name>/` with two domains: `state/` (machine-optimized JSON and markdown for the engine) and `codex/` (human-readable narrative projections — chronicle chapters, character sheets, psychological portraits). State snapshots at inflection points enable rewinding and codex synthesis.

## Engine Architecture

The engine is built from Claude Code primitives — agents, skills, and markdown instructions:

- **Orchestrator** — coordinates the three-phase turn cycle, delegates to domain agents, renders the player's experience
- **Domain agents** — psychology (schemas, defenses, values), social network (relationships, gatekeepers), world (plausibility, tonal register), codex (literary synthesis), editor (quality assurance)
- **Actor agents** — persona agent embodies characters for direct player interaction during scenes
- **Skills** — `birth`, `fork`, `load`, `exit`, `profile`, `replay`

## Project Reference

[`.claude/project/`](.claude/project/README.md) contains the full architecture, state schemas, simulation mechanics, configuration reference, requirements checklist, and narrative vision.
