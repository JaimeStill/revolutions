---
name: lifesim
description: "Human lifecycle simulator. Use when the user wants to start a new life (/lifesim birth), load a saved simulation (/lifesim load), exit and save (/lifesim exit), view a character's psychology (/lifesim profile), archive old state (/lifesim compress), or replay a life story (/lifesim replay). Triggers on: birth, new life, start simulation, load simulation, resume life, exit simulation, save simulation, stop simulation, character profile, psychological portrait, compress state, replay life, life story."
argument-hint: "[birth|load <instance>|exit|profile|compress|replay]"
---

# Lifesim

A psychological lifecycle simulator. Characters develop through formative events structured around developmental psychology inflection points. Prose in, prose out.

## Sub-Commands

Route based on `$ARGUMENTS`:

| Command | File | Purpose |
|---------|------|---------|
| `birth` | [commands/birth.md](commands/birth.md) | Create a new simulation instance |
| `load` | [commands/load.md](commands/load.md) | Load an existing simulation instance |
| `exit` | [commands/exit.md](commands/exit.md) | Save state, commit, push, and close the active simulation |
| `profile` | [commands/profile.md](commands/profile.md) | Render the active character's psychological portrait |
| `compress` | [commands/compress.md](commands/compress.md) | Archive cold state to free context budget |
| `replay` | [commands/replay.md](commands/replay.md) | Reconstruct a life narrative from logs |

Read the corresponding command file and follow its instructions. If no sub-command is provided, list available commands and any existing simulation instances found in `sim/`.

## Instance Layout

Each simulation run is fully self-contained in `sim/<instance-name>/`:

```
sim/<instance-name>/
  config.json              # Simulation parameters for this run
  state/
    period.md              # Historical period reference (generated at birth)
    society.json           # Social conditions for this life
    generation.json        # Birth cohort, collective events
    individual.json        # Seven-layer psychological profile
    network.json           # Relationship graph
    timeline.json          # Age, stage, turn counter
    scene.md               # Current narrative moment
  log/
    decisions.jsonl        # Player decisions (append-only)
    events.jsonl           # Generated events (append-only)
  archive/                 # Compressed cold state
```

## Active Instance Tracking

During an active session, `sim/.active` contains the instance directory name. This file is a runtime breadcrumb used by compaction hooks — not a session persistence mechanism. Players always start a simulation explicitly via `/lifesim birth` or `/lifesim load`.
