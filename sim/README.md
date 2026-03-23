# Simulation Instances

Each subdirectory is a self-contained simulation run created by `/lifesim birth`.

```
<instance-name>/
  config.json          # Simulation parameters for this run
  state/
    period.md          # Historical period reference (read-only after birth)
    society.json       # Social conditions for this life
    generation.json    # Birth cohort, collective events
    individual.json    # Seven-layer psychological profile
    network.json       # Relationship graph
    timeline.json      # Age, developmental stage, turn counter
    scene.md           # Current narrative moment
  log/
    decisions.jsonl    # Player decisions (append-only)
    events.jsonl       # Generated events (append-only)
  archive/             # Compressed cold state
```

Use `/lifesim load <instance-name>` to resume a simulation.
