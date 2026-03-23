# Profile — Psychological Portrait

Render the active character's psychological state as a readable prose portrait.

## Process

### 1. Find Active Instance

Read `sim/.active` to get the instance name. If no simulation is active, tell the player to load one first.

### 2. Read State

Read from the active instance:
- `state/individual.json` — the full seven-layer profile
- `state/timeline.json` — current age and developmental stage
- `state/network.json` — key relationships (for context)

### 3. Render the Portrait

Present the character's psychology as prose, not raw JSON. Structure it as a clinical portrait — the kind a thoughtful therapist might write. Cover each layer that has developed:

- **Biological & Temperament** — the character's natural grain
- **Attachment** — how they relate to others at the deepest level (if formed)
- **Schemas** — the wounds they carry, the beliefs they can't shake (if any)
- **Values** — what they protect first under pressure (if crystallized)
- **Self-Concept** — the story they tell about who they are (if formed)
- **Defenses** — how they cope under stress (if developed)

Skip layers that haven't formed yet (they're null/empty in the profile). Note what developmental stage the character is in and what's coming next.

End with a brief note on the character's active tensions — where the narrative pressure is, what internal conflicts are unresolved.
