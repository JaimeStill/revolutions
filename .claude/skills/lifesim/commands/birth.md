# Birth — Initialize a New Life

Create a new simulation instance: a character, a world, and the first formative event.

## Process

### 1. Gather Context

Ask the player if they have preferences for any of the following, or if they'd like everything generated:

- **Historical period and region** (e.g., "14th century Northern France", "1920s Shanghai", "pre-colonial West Africa")
- **Any character constraints** (e.g., sex, social class, a specific trait)

If the player provides nothing, generate everything — pick a period and region that offers rich narrative potential.

### 2. Generate the World

Use your knowledge of history, anthropology, and sociology. Do not rely on templates — each world should feel researched and specific.

#### `state/period.md`

A prose reference document describing the historical period's possibility space:
- What is physically possible given the technology
- What is socially permissible given the power structure
- What is conceivable given the information environment
- What would be punished and how
- What opportunities exist and for whom
- Key material conditions (food, shelter, medicine, trade)

This document is the orchestrator's reference for validating player actions. Write it as prose, not rules.

#### `state/society.json`

The specific social conditions the character is born into:

```json
{
  "period": "string — era label",
  "region": "string — geographic specificity",
  "culture": "string — cultural identity",
  "material_conditions": {
    "economic_mode": "string",
    "scarcity_profile": "string",
    "technology_tier": "string"
  },
  "power_structure": {
    "political_form": "string",
    "enforcement": "string",
    "mobility_constraints": {
      "class": "string",
      "gender": "string",
      "ethnicity": "string"
    }
  },
  "worldview": {
    "dominant": "string",
    "relationship_to_nature": "string",
    "relationship_to_authority": "string"
  },
  "collective_trauma": ["string"],
  "information_environment": {
    "literacy_rate": "string",
    "primary_medium": "string",
    "censorship": "string"
  }
}
```

#### `state/generation.json`

The birth cohort and its defining conditions:

```json
{
  "birth_cohort": "string — year range",
  "defining_events": [
    {
      "event": "string",
      "year": "number",
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

At birth, only biological and temperament layers exist. Other layers form through play.

#### `state/individual.json`

```json
{
  "biological": {
    "sex": "string",
    "health_baseline": "string",
    "physical_capacity": "string"
  },
  "temperament": {
    "_theory": "Thomas & Chess / Rothbart",
    "activity": "number 0-1",
    "reactivity": "number 0-1",
    "sociability": "number 0-1",
    "persistence": "number 0-1"
  },
  "attachment": {
    "_theory": "Bowlby / Ainsworth",
    "style": "not yet formed",
    "stability": null,
    "formed_at": null,
    "forming_context": null,
    "key_relationship": null
  },
  "schemas": {
    "_theory": "Young's Schema Therapy",
    "active": []
  },
  "values": {
    "_theory": "Schwartz's Theory of Basic Human Values",
    "hierarchy": [],
    "tested_by": [],
    "last_reordered": null
  },
  "self_concept": {
    "_theory": "McAdams' Narrative Identity Theory",
    "agency": null,
    "communion": null,
    "dominant_sequence": null,
    "identity_statement": null
  },
  "defenses": {
    "_theory": "Vaillant's hierarchy",
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

#### `state/network.json`

Start with the character's immediate family — the people present at birth. Generate names, roles, and initial relationship qualities appropriate to the period and culture.

```json
{
  "nodes": [
    {
      "id": "string",
      "name": "string",
      "role": "string — family_nuclear, family_extended, community, etc.",
      "alive": true,
      "qualities": {
        "attachment_strength": "number 0-1",
        "obligation_weight": "number 0-1",
        "aspiration_vector": "string",
        "resentment_load": "number 0-1"
      }
    }
  ],
  "edges": [
    {
      "from": "self",
      "to": "string — node id",
      "type": "string",
      "warmth": "number 0-1",
      "conflict": "number 0-1"
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
  "birth_year": "number",
  "current_year": "number — same as birth_year",
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

Write the simulation parameters to the instance root. Defaults:

```json
{
  "state_resolution": 3,
  "turn_scope": "season",
  "narrative_verbosity": "medium",
  "profile_update_threshold": "significant",
  "network_depth": 5,
  "ancestry_detail": "emergent",
  "player_mode": "human"
}
```

### 7. Generate the First Event

#### `state/scene.md`

Write the opening scene. This is the character's entry into the world — the first formative moment. It should:

- Establish the sensory world the character is born into
- Introduce the primary attachment figures
- Set up the first developmental tension (trust vs. mistrust)
- End with a situation that invites the player's first prose response

The scene should feel immediate and grounded in the period. Not a summary — a moment.

### 8. Initialize Logs

Create empty files:
- `log/decisions.jsonl`
- `log/events.jsonl`

### 9. Name the Instance

Suggest a name based on the character's name and birth year (e.g., `agnes-1345`). Ask the player to confirm or provide an alternative. Validate that the directory `sim/<name>/` doesn't already exist.

### 10. Write Everything

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
  log/
    decisions.jsonl
    events.jsonl
  archive/
```

Write the instance name to `sim/.active`.

### 11. Present the Opening

Output the narrative from `scene.md` to the player. From this point forward, every player message is a simulation turn processed by the orchestrator.
