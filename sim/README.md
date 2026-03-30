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
    characters/        # Generated profiles for non-protagonist characters
    snapshots/         # Full state copies at inflection points + session exits
  codex/               # Player domain — human-readable projections
    README.md
    chronicle/         # Narrative arc organized by developmental chapters
      README.md
    characters/        # One .md per significant network node
      README.md
    psychology/        # Character portrait
      README.md
    world/             # Period and cultural context entries
      README.md
      places/
        README.md
      events/
        README.md
      institutions/
        README.md
```

Use `/lifesim load <instance-name>` to resume a simulation.
