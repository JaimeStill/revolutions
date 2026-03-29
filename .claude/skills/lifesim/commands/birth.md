# Birth — Initialize a New Life

Create a new simulation instance: a world, a character, and the first formative event.

## Process

### 1. World-Building Session

Begin a collaborative conversation to establish the simulation world. This phase runs as long as needed — it could be a quick exchange or an extended world-building session depending on how much the user has already defined.

Ask the user what kind of world they want to explore:

- A historical period and region (14th century Northern France, 1990s suburban America, Edo-period Japan)
- A fantasy setting (secondary world, mythological, fairy-tale logic)
- A science fiction world (space colonization, post-singularity, alien contact)
- Alt-history, magical realism, post-apocalyptic, or any hybrid
- Something the user has already developed and wants to bring in

If the user provides a detailed vision, work with it — ask clarifying questions, research historical or cultural material when relevant, and push for specificity where the simulation needs it. If the user provides a loose sketch or says "surprise me," generate a world with rich narrative potential.

**The goal is a viable foundation**, not exhaustive detail. Establish enough that the simulation can validate actions and generate culturally grounded events. Leave room for emergence — details that aren't nailed down will be discovered through play.

What **must** be established:
- The possibility space (what can happen in this world)
- The social structure (who has power, how it's distributed)
- The material conditions (resources, scarcity, technology or its equivalent)
- The tonal register (what kind of story this is — grounded realism, high fantasy, etc.)

What **can** emerge:
- Specific places, secondary characters, cultural details
- Historical or world events the character hasn't encountered yet
- Deeper social dynamics that surface through play

### 2. Generate the World

Once the world-building conversation reaches alignment, delegate to the **world agent** (`.claude/agents/domain/world-agent.md`) in birth mode. Pass it everything established during the conversation.

The world agent generates:

#### `state/period.md`

The world's possibility space as prose — what is physically possible, socially permissible, conceivable, punishable, and available. Includes the tonal register. This is the engine's reference for all plausibility validation during play.

#### `state/society.json`

Structured facts for quick engine lookup:

```json
{
  "period": "string — era label or world name",
  "region": "string — geographic specificity",
  "culture": "string — cultural identity",
  "setting_type": "string — historical | fantasy | sci-fi | alt-history | hybrid | other",
  "mobility_constraints": {
    "class": "string",
    "gender": "string",
    "ethnicity": "string"
  },
  "collective_trauma": ["string"],
  "information_environment": {
    "literacy_rate": "string",
    "primary_medium": "string"
  }
}
```

#### `state/generation.json`

The birth cohort and its defining conditions:

```json
{
  "birth_cohort": "string — year range or equivalent",
  "defining_events": [
    {
      "event": "string",
      "year": "number or string",
      "character_age_at_event": "string",
      "developmental_impact": "string"
    }
  ],
  "economic_entry": "string",
  "relationship_to_prior_generation": "string",
  "cohort_narrative": "string — one sentence capturing the generation's identity"
}
```

### 3. Generate the Character

At birth, only biological and temperament layers exist. Other layers form through play. The orchestrator writes this directly — no interpretation needed, just initialization.

#### `state/individual.json`

```json
{
  "biological": {
    "sex": "string",
    "health_baseline": "string",
    "physical_capacity": "string"
  },
  "temperament": {
    "activity": "number 0-1",
    "reactivity": "number 0-1",
    "sociability": "number 0-1",
    "persistence": "number 0-1"
  },
  "attachment": {
    "style": "not yet formed",
    "stability": null,
    "formed_at": null,
    "forming_context": null,
    "key_relationship": null
  },
  "schemas": {
    "active": []
  },
  "values": {
    "hierarchy": [],
    "tested_by": [],
    "last_reordered": null
  },
  "self_concept": {
    "agency": null,
    "communion": null,
    "dominant_sequence": null,
    "identity_statement": null
  },
  "defenses": {
    "repertoire": {
      "mature": [],
      "neurotic": [],
      "immature": [],
      "psychotic": []
    },
    "current_tier": null,
    "stress_threshold_for_regression": null
  }
}
```

### 4. Initialize the Social Network

The orchestrator writes this directly. Start with the character's immediate family — the people present at birth. Generate names, roles, and initial relationship data appropriate to the world.

#### `state/network.json`

Nodes describe WHO someone is. Edges describe the relationship TO the character.

```json
{
  "nodes": [
    {
      "id": "string",
      "name": "string",
      "role": "string — mother, father, sibling, etc.",
      "alive": true,
      "description": "string — brief prose sketch of this person"
    }
  ],
  "edges": [
    {
      "from": "self",
      "to": "string — node id",
      "warmth": "number 0-1",
      "conflict": "number 0-1",
      "attachment": "number 0-1",
      "obligation": "number 0-1",
      "resentment": "number 0-1"
    }
  ],
  "gatekeepers": [],
  "normative_pressure": {
    "rewarded": ["string"],
    "punished": ["string"]
  }
}
```

### 5. Initialize Timeline

#### `state/timeline.json`

```json
{
  "birth_year": "number or string",
  "current_year": "number or string — same as birth_year",
  "current_age": 0,
  "developmental_stage": "infancy",
  "erikson_conflict": "trust_vs_mistrust",
  "turn_count": 0,
  "inflection_points_passed": [],
  "next_inflection": "attachment_formation"
}
```

### 6. Write Config

#### `config.json`

```json
{
  "state_resolution": 3,
  "turn_scope": "season",
  "narrative_verbosity": "medium",
  "profile_update_threshold": "significant",
  "network_depth": 5,
  "ancestry_detail": "emergent",
  "player_mode": "human",
  "interaction_model": "discussion",
  "player_intention": null
}
```

### 7. Generate the First Scene

#### `state/scene.md`

Write the opening scene. This is the character's entry into the world — the first formative moment. It should:

- Establish the sensory world the character is born into
- Introduce the primary attachment figures
- Set up the first developmental tension (trust vs. mistrust)
- End with a situation that invites the player's first prose response

The scene should feel immediate and grounded in the world that was built. Not a summary — a moment.

### 8. Create Initial Snapshot

Copy all state files to `state/snapshots/turn-0-birth/` to capture the initial state.

### 9. Initialize Codex

Create the codex structure with README indexes in every subdirectory:

```
codex/
  README.md              # "Codex for <character name>. Contains:" + pointers to subdirs
  chronicle.md           # Empty or with a brief birth entry
  characters/
    README.md            # "Character entries for <character name>'s social network."
  psychology/
    README.md            # "Psychological documentation for <character name>."
  world/
    README.md            # "World context for <character name>'s life." + pointers to subdirs
    places/
      README.md          # "Places in <character name>'s world."
    events/
      README.md          # "Historical and cultural events shaping <character name>'s life."
    institutions/
      README.md          # "Institutions in <character name>'s world."
```

### 10. Name the Instance

Suggest a name based on the character's name and birth year or world (e.g., `drew-1993`, `kael-ashenmere`). Ask the player to confirm or provide an alternative. Validate that the directory `sim/<name>/` doesn't already exist.

### 11. Write Everything

Create the instance directory structure and write all files:

```
sim/<instance-name>/
  config.json
  state/
    period.md
    society.json
    generation.json
    individual.json
    network.json
    timeline.json
    scene.md
    snapshots/
      turn-0-birth/
  codex/
    README.md
    chronicle.md
    characters/
      README.md
    psychology/
      README.md
    world/
      README.md
      places/
        README.md
      events/
        README.md
      institutions/
        README.md
```

Write the instance name to `sim/.active`.

### 12. Present the Opening

Output the narrative from `scene.md` to the player. From this point forward, the simulation is active and operates in the three-phase turn cycle.
