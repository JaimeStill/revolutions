# State

## Two-Domain Architecture

Each simulation instance separates machine state from player-facing artifacts:

- **`state/`** — machine domain. Structured JSON and prose optimized for the orchestrator. Minimal, high information density, fast partial loads. The orchestrator owns this side.
- **`codex/`** — player domain. Human-readable projections of the life. Prose-first narrative, character sheets, psychological portraits. Generated via synthesis pass, not updated every turn.

This is CQRS applied to simulation state: the engine writes to `state/`, the player reads from `codex/`. The codex is a projection of machine state, not a separate source of truth.

## Instance Layout

```
sim/
  .active                        # Runtime breadcrumb — current instance name (for hooks)
  <instance-name>/               # One directory per simulation run
    config.json                  # Simulation parameters for this run
    state/                       # Machine domain
      period.md                  # Historical period reference (generated at birth, read-only)
      society.json               # Social conditions — structured facts for quick lookup
      generation.json            # Birth cohort, collective events, economic conditions
      individual.json            # Seven-layer psychological profile
      network.json               # Relationship graph — nodes and edges
      timeline.json              # Current age, developmental stage, turn counter
      scene.md                   # Current narrative context (bridge across compaction)
      snapshots/                 # Full state copies at inflection points + session exits
        turn-0-birth/
        turn-N-label/
    codex/                       # Player domain — human-readable projections
      README.md                  # Codex index
      chronicle.md               # Append-only narrative organized by inflection point
      characters/                # One .md per significant network node
        README.md                # Character index
      psychology/                # Character portrait, updated at thresholds
        README.md                # Psychology index
      world/                     # Period and cultural context entries
        README.md                # World index
        places/                  # Geographic and cultural environments
          README.md
        events/                  # Historical and cultural events
          README.md
        institutions/            # Schools, churches, employers, organizations
          README.md
```

## State Layers

Each layer has a different update rate. Period and generation are constants per life (read-only after birth). Society is near-constant (rare upheavals only). Social network is slow-moving. Individual state updates when thresholds are crossed. Scene updates every turn.

## Snapshots

Full copy of machine state at meaningful boundaries. Stored in `state/snapshots/turn-{N}-{label}/`.

**Snapshot triggers:**
- Inflection point transitions (orchestrator creates during turn)
- Session exit (`/lifesim exit`)

Snapshots enable rewinding the simulation to any prior state by restoring snapshot files to `state/`. They also enable the synthesis pass by providing a diff baseline.

**Schema alignment:** Snapshots preserve historical content but must always conform to the current schema. When the simulation schema changes (e.g., fields added, removed, or restructured), all existing snapshots are migrated to match. This ensures any snapshot can be restored without schema incompatibility.

## Codex — Synthesis Pass

The codex is not updated every turn. It is generated via a synthesis pass:

**Triggers:**
- Inflection point transitions (after snapshot)
- Session exit (after snapshot)
- On demand (future: `/lifesim narrate`)

**Process:**
1. Diff latest snapshot against current state to identify what changed
2. Append new section to `codex/chronicle.md`
3. Update `codex/characters/<id>.md` for nodes that changed significantly
4. Update `codex/psychology/portrait.md` if individual.json crossed threshold
5. Update `codex/world/` if world context shifted
