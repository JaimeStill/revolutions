# State Schemas

JSON schemas for all simulation state files. Instance files contain only data — theory references are documented here. Each domain's state is owned by a specific agent.

## Period (`period.md`) — owned by world-agent

A prose reference document generated at birth describing the world's possibility space. Not limited to historical periods — the world can be fantasy, sci-fi, alt-history, or any setting. Used by the world agent to validate player actions at commit time.

Covers what is physically possible, socially permissible, conceivable, punishable, and available as opportunity. Also captures the **tonal register** — the established narrative tone (grounded realism, high fantasy, gritty noir, etc.) — which the world agent validates against alongside factual plausibility.

The core question: "Could this person, in this world, do what the player described — and is it tonally consistent with the story we've been telling?"

Period context is generated from the model's knowledge at birth — not hardcoded. For historical settings, this means research into the actual period. For fictional settings, it means establishing internal consistency. Separate from `society.json`, which captures specific structured facts rather than the world's general possibility space.

## Society (`society.json`) — owned by world-agent

Structured facts the engine needs for quick lookup. Period.md handles texture and prose.

```json
{
  "period": "14th century",
  "region": "Northern France",
  "culture": "Feudal Christian Europe",
  "setting_type": "historical",
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

## Generation (`generation.json`) — owned by world-agent

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

## Network (`network.json`) — owned by network-agent

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
      "resentment": 0.1,
      "visibility": "high — lives in the same house, sees her daily",
      "information_flow": "direct — mother observes the character's behavior firsthand"
    }
  ],
  "gatekeepers": [
    {
      "node_id": "village_priest",
      "gates": "access to literacy, religious standing, community reputation",
      "conditions": "piety, obedience, attendance at mass",
      "current_stance": "neutral — has not yet formed a strong opinion of the character"
    }
  ],
  "normative_pressure": {
    "rewarded": [
      {
        "behavior": "obedience",
        "enforced_by": ["mother", "village_priest", "lord"],
        "reward": "safety, social inclusion, access to resources"
      }
    ],
    "punished": [
      {
        "behavior": "questioning authority",
        "enforced_by": ["village_priest", "lord"],
        "cost": "public shaming, penance, loss of standing"
      }
    ]
  }
}
```

### Edge fields

- `visibility` — how directly this person observes the character's behavior. High visibility means actions are seen firsthand. Low means they rely on secondhand reports.
- `information_flow` — how information about the character reaches this person. Direct (observes firsthand), indirect (hears through others — specify the channel), or minimal (rarely hears anything).

These fields drive the network agent's consequence propagation: when the character acts, the agent traces through edges to determine who learns about it and how their relationships shift.

## Individual (`individual.json`) — owned by psychology-agent — Seven-Layer Psychological Profile

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

The psychology agent reads all layers when processing the psychological impact of a committed action. It checks:
- Does this action confirm or contradict the **values hierarchy**?
- Does it activate or heal a **schema/wound**?
- Does it confirm or challenge the **self-concept narrative**?
- What **defense mechanisms** are currently active?

If the action crosses the significance threshold, the psychology agent updates the relevant layers. Layers 1-2 barely change. Layer 3 shifts only at major inflection points. Layer 4 can reorder through moral tests. Layers 5-6 are moderately dynamic. Scene (`scene.md`, owned by the orchestrator) updates at every commit.

## Timeline (`timeline.json`) — owned by orchestrator

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

## Character Profiles (`characters/<id>.json`) — generated by birth command (character scope)

Generated profiles for non-protagonist characters. Same seven-layer structure as `individual.json`, but typically at lower resolution — calibrated to the character's narrative function rather than collaboratively authored. The persona agent loads these when embodying a character. The network agent references them when processing social consequences.

Generated on demand: when the birth command runs in character scope (invoked by the orchestrator during a commit, by the player directly, or by the fork command). Stored in `state/characters/` with the character's network node ID as filename.

```json
{
  "id": "string — matches network node id",
  "name": "string",
  "biological": { "...same structure as individual.json..." },
  "temperament": { "...same structure..." },
  "attachment": { "...same structure..." },
  "schemas": { "...same structure..." },
  "values": { "...same structure..." },
  "self_concept": { "...same structure..." },
  "defenses": { "...same structure..." }
}
```

The depth of each layer depends on how much is known about the character. A well-established network character (Carol, Marcus) may have a nearly protagonist-level profile. A peripheral character may have only biological, temperament, and a few schemas.

## Scene (`scene.md`) — owned by orchestrator

A narrative document, not JSON. Written by the orchestrator at commit time. Read first on session start and after compaction. Contains the current moment, last decision, pending threads, and emotional state.
