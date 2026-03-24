# Simulation Instances

Each subdirectory is a self-contained simulation run created by `/lifesim birth`.

```
<instance-name>/
  config.json          # Simulation parameters for this run
  state/               # Machine domain
    period.md          # Historical period reference (read-only after birth)
    society.json       # Social conditions — structured facts
    generation.json    # Birth cohort, collective events
    individual.json    # Seven-layer psychological profile
    network.json       # Relationship graph
    timeline.json      # Age, developmental stage, turn counter
    scene.md           # Current narrative moment
    snapshots/         # Full state copies at inflection points + session exits
  codex/               # Player domain — human-readable projections
    chronicle.md       # Narrative arc organized by inflection point
    characters/        # One .md per significant network node
    world/             # Period and cultural context entries
    psychology/        # Character portrait
```

Use `/lifesim load <instance-name>` to resume a simulation.
