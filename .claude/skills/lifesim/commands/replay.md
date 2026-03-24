# Replay — Reconstruct a Life Narrative

Rebuild the story of a life from the codex and state snapshots.

## Process

### 1. Find the Instance

If a simulation is active (check `sim/.active`), use that instance. Otherwise, list available instances in `sim/` and ask the player to choose.

### 2. Read the Codex

Check if `codex/chronicle.md` exists. If it does, this is the primary narrative source — it contains the synthesized story of the life organized by inflection points.

### 3. Read State History

For deeper reconstruction or if the chronicle is incomplete:
1. List all snapshots in `state/snapshots/` chronologically
2. Read each snapshot's `scene.md` and `timeline.json` to trace the life's arc
3. Read `state/individual.json` for the character's current psychology
4. Read `state/generation.json` for the world context

### 4. Render the Narrative

Produce a prose reconstruction of the life — not a data dump, but a story. Structure it around the developmental inflection points:

- What happened at each inflection point
- What the character chose and what it cost
- How the choices shaped who they became

The tone should be reflective — like a biographer looking back at a life with the benefit of hindsight. The character's psychology (schemas, values, defenses) should be visible through the narrative, not stated clinically.

If the life is still in progress, end with where the character stands now and what remains unresolved.
