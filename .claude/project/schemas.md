# State Schemas

JSON schemas for all simulation state files. Instance files contain only data — theory references are documented here.

## Period (`period.md`)

A prose reference document generated at birth describing the historical period's possibility space. Used by the orchestrator to validate player actions. Covers what is physically possible, socially permissible, conceivable, punishable, and available as opportunity. Written as prose, not rules.

The core question: "Could this person, in this place and time, do what the player described?"

Period context is generated from the model's training knowledge at birth — not hardcoded. Separate from `society.json`, which captures specific structured facts rather than the period's general possibility space.

## Society (`society.json`)

Structured facts the engine needs for quick lookup. Period.md handles texture and prose.

```json
{
  "period": "14th century",
  "region": "Northern France",
  "culture": "Feudal Christian Europe",
  "mobility_constraints": {
    "class": "rigid — born into station",
    "gender": "severe — women as property in most contexts",
    "ethnicity": "variable — outsiders suspect"
  },
  "collective_trauma": ["Black Death (ongoing)", "Hundred Years War"],
  "information_environment": {
    "literacy_rate": "clergy and nobility only",
    "primary_medium": "oral tradition, church sermons"
  }
}
```

## Generation (`generation.json`)

```json
{
  "birth_cohort": "1340-1355",
  "defining_events": [
    {
      "event": "Black Death arrives",
      "year": 1348,
      "character_age_at_event": "childhood",
      "developmental_impact": "attachment disruption, existential terror normalized"
    }
  ],
  "economic_entry": "post-plague labor shortage — paradoxical opportunity",
  "relationship_to_prior_generation": "rupture — too many dead to maintain continuity",
  "cohort_narrative": "The survivors. Those who grew up knowing the world could end."
}
```

## Network (`network.json`)

Nodes describe WHO someone is. Edges describe the relationship TO the character. These are separate concerns.

```json
{
  "nodes": [
    {
      "id": "mother",
      "name": "Marguerite",
      "role": "mother",
      "alive": true,
      "description": "Widowed at 28. Keeps the family alive through sheer will. Loves fiercely but cannot attend to emotional needs."
    }
  ],
  "edges": [
    {
      "from": "self",
      "to": "mother",
      "warmth": 0.7,
      "conflict": 0.2,
      "attachment": 0.8,
      "obligation": 0.9,
      "resentment": 0.1
    }
  ],
  "gatekeepers": ["village_priest"],
  "normative_pressure": {
    "rewarded": ["obedience", "piety", "labor"],
    "punished": ["questioning", "ambition beyond station", "sexual deviance"]
  }
}
```

## Individual (`individual.json`) — Seven-Layer Psychological Profile

The core of the simulation. Each layer is grounded in established psychological theory, operates at a different timescale, and serves a different narrative function.

| Layer | Theory | Timescale | Narrative Function |
|-------|--------|-----------|-------------------|
| Biological | — | Near-constant | Physical constraints and capacities |
| Temperament | Thomas & Chess / Rothbart | Set near birth, slow drift | The character's natural grain |
| Attachment | Bowlby / Ainsworth | Formed early childhood | Colors all relationship processing |
| Schemas | Young's Schema Therapy | Resistant to change | 3-5 early maladaptive schemas. Narrative gold. |
| Values | Schwartz's Basic Human Values | Crystallizes adolescence-adulthood | What's protected first under pressure |
| Self-Concept | McAdams' Narrative Identity | Constructed throughout life | The story they tell about who they are |
| Defenses | Vaillant's hierarchy | Dynamic under stress | Under stress, regress to less mature tiers. Growth = more mature defenses. |

```json
{
  "biological": {
    "sex": "female",
    "health_baseline": "sturdy",
    "physical_capacity": "above average for age and nutrition"
  },
  "temperament": {
    "activity": 0.6,
    "reactivity": 0.8,
    "sociability": 0.3,
    "persistence": 0.7
  },
  "attachment": {
    "style": "anxious",
    "stability": 0.6,
    "formed_at": "age 3",
    "forming_context": "Mother's illness created unpredictable availability",
    "key_relationship": "mother"
  },
  "schemas": {
    "active": [
      {
        "name": "abandonment",
        "unmet_need": "stable connection",
        "core_belief": "People I love will leave or die",
        "compensatory_strategy": "hypervigilance in relationships — watches for signs of withdrawal",
        "formed_at": "age 5",
        "forming_context": "Father died of plague. Mother withdrawn in grief.",
        "activation_level": 0.7
      }
    ]
  },
  "values": {
    "hierarchy": ["security", "benevolence", "conformity", "tradition"],
    "tested_by": [],
    "last_reordered": null
  },
  "self_concept": {
    "agency": "moderate — I can influence my immediate world but larger forces are beyond me",
    "communion": "high — I define myself through my bonds with others",
    "dominant_sequence": "contamination — good things are fragile and will be taken",
    "identity_statement": "I am someone who holds things together for others"
  },
  "defenses": {
    "repertoire": {
      "mature": ["humor"],
      "neurotic": ["displacement", "intellectualization"],
      "immature": ["passive-aggression"],
      "psychotic": []
    },
    "current_tier": "neurotic",
    "stress_threshold_for_regression": 0.7
  }
}
```

**How the layers interact:**

The orchestrator reads all layers when interpreting a player decision. It checks:
- Does this action confirm or contradict the **values hierarchy**?
- Does it activate or heal a **schema/wound**?
- Does it confirm or challenge the **self-concept narrative**?
- What **defense mechanisms** are currently active?

If the decision crosses a significance threshold, the orchestrator updates the relevant layers. Layers 1-2 barely change. Layer 3 shifts only at major inflection points. Layer 4 can reorder through moral tests. Layers 5-6 are moderately dynamic. Scene (Layer 7, in `scene.md`) changes every turn.

## Timeline (`timeline.json`)

```json
{
  "birth_year": 1345,
  "current_year": 1353,
  "current_age": 8,
  "developmental_stage": "late_childhood",
  "erikson_conflict": "industry_vs_inferiority",
  "turn_count": 4,
  "inflection_points_passed": ["attachment_formation"],
  "next_inflection": "agency_threshold"
}
```

## Scene (`scene.md`)

A narrative document, not JSON. Written by the orchestrator after each turn. Read first on session start and after compaction. Contains the current moment, last decision, pending threads, and emotional state.
