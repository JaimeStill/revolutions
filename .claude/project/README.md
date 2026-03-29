# Revolutions

A human lifecycle simulator where Claude Code is the simulation engine.

## Vision

Revolutions captures patterns of human growth within the constraints of a specific world — historical, fantastical, or anything in between. It generates psychological profiles of individuals within generational and social constraints, driven by prose input — from a human player or AI subagent — rather than discrete choice menus.

Every decision is a prose response to a narrative event. Intent is interpreted semantically, not parsed. Formative moments are structured around developmental psychology inflection points. Ancestry is not predetermined — ancestor traits emerge retroactively through the psychological profile of the main character.

The simulation treats Claude Code's context window as its frame buffer, its agents as processing units, its file system as the persistence layer, and its architectural constraints as the simulation's physics.

## How It Works

A player starts a life with `/lifesim birth`. The orchestrator runs a collaborative world-building session — the world can be historical, fantasy, sci-fi, or anything else — then generates a character and the first formative event. From there, the simulation operates in a three-phase cycle: the orchestrator presents a **scene**, the player and engine co-author what happens through **discussion**, and when alignment is reached, the orchestrator **commits** — delegating to domain agents (psychology, network, world) to process state changes, then presenting the next scene.

There is no `/turn` command. The conversation IS the simulation. The orchestrator knows the protocol because its system prompt defines it.

State lives on disk in `sim/<instance>/state/`. The conversation is a working surface — disposable, rebuildable. When context compaction fires, hooks rebuild the simulation entirely from state files.

## Project Contents

| File | Purpose |
|------|---------|
| [architecture.md](architecture.md) | Engine constraints, agents, skills, hooks, context management, session types |
| [state.md](state.md) | Two-domain layout (state/ + codex/), instance structure, snapshots, synthesis pass |
| [schemas.md](schemas.md) | JSON schemas for all state files (individual, network, society, generation, timeline) |
| [simulation.md](simulation.md) | Turn protocol, pacing, inflection points, event types, interaction model, presentation layer |
| [configuration.md](configuration.md) | Instance config.json schema and parameter reference |
| [requirements.md](requirements.md) | Capability checklist grouped by area |

### Engine Reference Docs

These live in the engine itself (not here) and are loaded at runtime:

| File | Purpose |
|------|---------|
| `.claude/skills/lifesim/reference/codex-style.md` | Literary craft guide for codex composition |
| `.claude/skills/lifesim/reference/synthesis.md` | Synthesis pass protocol — how state becomes codex |

## Directory Structure

```
revolutions/
  CLAUDE.md                      # Simulation identity and turn protocol
  README.md                      # Project overview
  .claude/
    project/                     # This directory — development-time reference
    init.md                      # Next dev session bootstrap (iterative-dev)
    settings.json                # Orchestrator config, hooks, env vars
    agents/
      orchestrator.md            # Main agent — three-phase cycle, delegation, narrative assembly
      psychology-agent.md        # Psychology subagent — schemas, defenses, values, self-concept
      network-agent.md           # Social network subagent — consequence propagation
      world-agent.md             # World subagent — world generation, plausibility, tonal register
      codex-agent.md             # Synthesis subagent — literary codex composition
    skills/
      lifesim/                   # Simulation skill
        commands/                # Sub-commands (birth, load, exit, profile, replay)
        reference/               # Engine reference docs (codex-style, synthesis)
      iterative-dev/             # Development workflow skill
  sim/
    .active                      # Runtime breadcrumb (current instance name)
    <instance-name>/             # One per simulation run (self-contained)
      config.json
      state/
        snapshots/
      codex/
        README.md
        chronicle.md
        characters/
        psychology/
        world/
          places/
          events/
          institutions/
```
