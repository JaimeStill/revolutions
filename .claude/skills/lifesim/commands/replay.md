# Replay — Reconstruct a Life Narrative

Rebuild the story of a life from the decision and event logs.

## Process

### 1. Find the Instance

If a simulation is active (check `sim/.active`), use that instance. Otherwise, list available instances in `sim/` and ask the player to choose.

### 2. Read the Logs

Read in order:
1. `log/events.jsonl` — the generated events, chronologically
2. `log/decisions.jsonl` — the player's responses to those events
3. `archive/events-cold.jsonl` and `archive/decisions-cold.jsonl` if they exist — these contain earlier entries that were compressed

Merge archived and live entries into chronological order.

### 3. Read Context

Read supporting state for narrative color:
- `state/timeline.json` — the life's arc
- `state/individual.json` — the character's current psychology (to understand how they got here)
- `state/generation.json` — the world they were born into

### 4. Render the Narrative

Produce a prose reconstruction of the life — not a log dump, but a story. Structure it around the developmental inflection points:

- What happened at each inflection point
- What the character chose and what it cost
- How the choices shaped who they became

The tone should be reflective — like a biographer looking back at a life with the benefit of hindsight. The character's psychology (schemas, values, defenses) should be visible through the narrative, not stated clinically.

If the life is still in progress, end with where the character stands now and what remains unresolved.
