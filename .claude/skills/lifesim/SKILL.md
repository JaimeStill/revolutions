---
name: lifesim
description: "Human lifecycle simulator. Use when the user wants to start a new life (/lifesim birth), load a saved simulation (/lifesim load), exit and save (/lifesim exit), view a character's psychology (/lifesim profile), or replay a life story (/lifesim replay). Triggers on: birth, new life, start simulation, load simulation, resume life, exit simulation, save simulation, stop simulation, character profile, psychological portrait, replay life, life story."
argument-hint: "[birth|load <instance>|exit|profile|replay]"
---

# Lifesim

A psychological lifecycle simulator. Characters develop through formative events structured around developmental psychology inflection points. Prose in, prose out.

## Sub-Commands

Route based on `$ARGUMENTS`:

| Command | File | Purpose |
|---------|------|---------|
| `birth` | [commands/birth.md](commands/birth.md) | Create a new simulation instance |
| `load` | [commands/load.md](commands/load.md) | Load an existing simulation instance |
| `exit` | [commands/exit.md](commands/exit.md) | Snapshot, synthesize codex, commit, and close |
| `profile` | [commands/profile.md](commands/profile.md) | Render the active character's psychological portrait |
| `replay` | [commands/replay.md](commands/replay.md) | Reconstruct a life narrative from codex and snapshots |

Read the corresponding command file and follow its instructions. If no sub-command is provided, list available commands and any existing simulation instances found in `sim/`.

## Reference Docs

Engine reference documents loaded during specific operations (not commands):

| Document | File | Loaded by |
|----------|------|-----------|
| Codex Style Guide | [reference/codex-style.md](reference/codex-style.md) | Codex agent during synthesis |
| Synthesis Protocol | [reference/synthesis.md](reference/synthesis.md) | Codex agent during synthesis |

## Instance Layout

Each simulation run is fully self-contained in `sim/<instance-name>/`:

```
sim/<instance-name>/
  config.json              # Simulation parameters for this run
  state/                   # Machine domain
    period.md              # Historical period reference (generated at birth)
    society.json           # Social conditions — structured facts
    generation.json        # Birth cohort, collective events
    individual.json        # Seven-layer psychological profile
    network.json           # Relationship graph — nodes and edges
    timeline.json          # Age, stage, turn counter
    scene.md               # Current narrative moment
    snapshots/             # Full state copies at inflection points + session exits
  codex/                   # Player domain — human-readable projections
    README.md              # Codex index
    chronicle.md           # Append-only narrative organized by inflection point
    characters/            # One .md per significant network node
      README.md            # Character index
    psychology/            # Character portrait, updated at thresholds
      README.md            # Psychology index
    world/                 # Period and cultural context entries
      README.md            # World index
      places/              # Geographic and cultural environments
        README.md
      events/              # Historical and cultural events
        README.md
      institutions/        # Schools, churches, employers, organizations
        README.md
```

## Active Instance Tracking

During an active session, `sim/.active` contains the instance directory name. This file is a runtime breadcrumb used by compaction hooks — not a session persistence mechanism. Players always start a simulation explicitly via `/lifesim birth` or `/lifesim load`.
