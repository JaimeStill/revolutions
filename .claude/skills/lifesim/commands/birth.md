# Birth — Initialize a New Life

Create a new simulation instance — or generate a character within an existing one. Birth is parameterized to handle three scopes: protagonist creation at any point in a life, non-protagonist character generation within an active simulation, and world-building for new settings.

## Parameters

Birth's behavior is shaped by three parameters, established conversationally during the collaborative session:

### Scope

- **`protagonist`** (default) — full instance creation. World, character, network, timeline, codex scaffold, snapshot, first scene. Sets `sim/.active`. Starts the turn cycle.
- **`character`** — non-protagonist generation within an active instance. Produces an `individual.json`-shaped profile and optional codex entry. Writes to the current instance's character state storage (`state/characters/<id>.json`). Does not create a new instance directory, does not set `sim/.active`, does not start the turn cycle. Returns to whatever invoked it — the orchestrator during a commit, the player on demand, or the fork command assembling a new protagonist.

### Entry Point

- **`birth`** (default) — age 0. Only biological and temperament layers populated. All other layers null, formed through play.
- **`<age or life stage>`** — any developmental stage. All layers appropriate to the entry age are populated during the collaborative session. The world-building phase establishes the world up to this point. The character generation phase populates all seven layers to the degree warranted by the entry age.

### Backstory Resolution

- **`emergent`** (default) — forming_context fields for schemas, attachment, values, and self-concept are populated with enough detail to ground the profile, but specifics are left open for retroactive discovery through play. The chronicle starts empty or with a brief orientation. History resolves forward as the character's behavior under pressure reveals what must have happened.
- **`established`** — forming_context fields are fully specified during the collaborative session. The character's history is known. The chronicle may include a composed retrospective entry. No retroactive resolution needed.
- **`sparse`** — forming_context fields are deliberately minimal or absent. The character has an abandonment schema at 0.7, but neither the player nor the engine knows why. Maximizes retroactive discovery. The psychology agent gains a reverse-inference responsibility: when a schema activates in a distinctive pattern during play, propose a forming context consistent with the profile and the world.

## Process

### 1. Collaborative Session

Begin a conversation to establish what the player wants. The session adapts based on scope and entry point.

**For protagonist scope:**

Determine the world and the character. If no simulation exists, run a full world-building session (see step 2). If forking or entering an established world, the world phase may be abbreviated or skipped.

Determine the entry point. If the player provides an age, life stage, or scenario ("I want to play a 35-year-old veteran teacher in this world"), the entry point is set accordingly. If no entry point is specified, default to age 0.

Determine backstory resolution. If the player wants to discover the character's history through play, use emergent or sparse. If they want full control over the backstory, use established. If not specified, default to emergent.

**For character scope:**

The world already exists (an instance is active). The session focuses on who this person is: their role, age, relationship to existing characters, any known details. The player may provide extensive detail or minimal constraints. The output resolution scales accordingly — a fully specified character gets a detailed profile, a loosely constrained one gets a profile generated from world context and role.

### 2. World-Building (protagonist scope, new world only)

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

When entering an established world (via fork or by the player specifying an existing world), this phase loads existing world state rather than generating new state. The world-building conversation may still occur if the entry point requires extending the world's timeline — a fork set 20 years after the source simulation's current point needs generation.json updated and period.md potentially revised.

### 3. Generate the World (protagonist scope, new world only)

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

### 4. Generate the Character

The character generation phase scales to the entry point.

**Entry at birth (age 0):**

Only biological and temperament layers exist. Other layers form through play. The orchestrator writes this directly.

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

**Entry at a later stage:**

Populate all layers appropriate to the entry age. The collaborative session determines what's known and what's left open based on the backstory resolution parameter.

- **Early childhood entry** — biological, temperament, attachment forming or formed.
- **Late childhood entry** — above, plus emerging schemas, early defense repertoire.
- **Adolescence entry** — above, plus active schemas with forming_context (populated or sparse), emerging values hierarchy, nascent self-concept, diversifying defenses.
- **Early adulthood entry** — all seven layers populated. Values tested. Self-concept with an identity statement. Defense repertoire with a known regression threshold.
- **Midlife / late life entry** — all seven layers at full development. Schemas may include healing notes. Values reordered by life experience. Defense repertoire mature (or not). Self-concept with a dominant narrative sequence.

The depth of each layer's content depends on the backstory resolution parameter. Established resolution means every field is populated with specific history. Sparse resolution means the numerical/structural fields are set (activation levels, hierarchy order, defense tier) but the narrative fields (forming_context, healing_note, identity_statement) are minimal placeholders awaiting retroactive discovery.

**For character scope:**

Same profile structure, but calibrated to the character's narrative function and world position rather than collaboratively authored. The generating context (role, relationship to existing characters, world constraints) shapes the profile. A generated character's profile is lower resolution than a protagonist's but structurally complete — the persona agent needs real machinery to work with.

Generated character profiles are written to `state/characters/<id>.json`. The network agent references these when processing social consequences. The persona agent loads them when embodying. The codex agent synthesizes from them when composing character entries.

### 5. Initialize the Social Network (protagonist scope)

Build the character's network from the entry point. At age 0, this is immediate family. At a later entry, this is family, friends, teachers, mentors — whoever the collaborative session established.

For late-start entries, network nodes may reference characters who have their own generated profiles (in `state/characters/`), or they may be sketched in network.json and generated later when the simulation encounters them with enough depth to warrant it.

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

### 6. Initialize Timeline (protagonist scope)

Set timeline.json to the entry point. For late-start entries, `inflection_points_passed` is populated with the inflection points appropriate to the entry age. If backstory resolution is sparse, these may be listed without detailed resolution — they happened, but how they crystallized is unknown.

#### `state/timeline.json`

```json
{
  "birth_year": "number or string",
  "current_year": "number or string",
  "current_age": "entry age",
  "developmental_stage": "stage appropriate to entry age",
  "erikson_conflict": "conflict appropriate to stage",
  "turn_count": 0,
  "inflection_points_passed": ["list appropriate to entry age"],
  "next_inflection": "next upcoming inflection"
}
```

### 7. Write Config (protagonist scope)

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

### 8. Generate the First Scene (protagonist scope)

#### `state/scene.md`

Write the opening scene for the entry point.

**Entry at birth:** The character's arrival in the world — the first formative moment. Establish the sensory world, introduce the primary attachment figures, set up the first developmental tension (trust vs. mistrust), and end with a situation that invites the player's first prose response.

**Entry at a later stage:** Wherever the player wants to begin — a specific scenario, a turning point, an ordinary Tuesday that's about to become extraordinary, or an open moment that invites the player to establish direction.

For sparse backstory resolution, the first scene may carry deliberate ambiguity — details that hint at a history without specifying it, creating threads the simulation will resolve through play.

The scene should feel immediate and grounded in the world that was built. Not a summary — a moment.

### 9. Create Initial Snapshot (protagonist scope)

Copy all state files to `state/snapshots/turn-0-{label}/`. Label reflects the entry: `turn-0-birth`, `turn-0-age-35-entry`, etc.

### 10. Initialize Codex (protagonist scope)

Create the codex structure with README indexes in every subdirectory:

```
codex/
  README.md              # "Codex for <character name>. Contains:" + pointers to subdirs
  chronicle/
    README.md            # Chronicle index — title + empty chapter table
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

For late-start entries with established backstory, the codex may include an initial chronicle entry and character entries composed during the collaborative session. For emergent or sparse entries, the codex starts minimal — the chronicle fills in as the simulation runs and retroactive discovery occurs.

### 11. Name and Write the Instance (protagonist scope)

Suggest a name based on the character's name and birth year or world (e.g., `drew-1993`, `kael-ashenmere`). Ask the player to confirm or provide an alternative. Validate that the directory `sim/<name>/` doesn't already exist.

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
    characters/            # Generated profiles for non-protagonist characters
    snapshots/
      turn-0-{label}/
  codex/
    README.md
    chronicle/
      README.md
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

### 12. Present the Opening (protagonist scope)

Output the narrative from `scene.md` to the player. From this point forward, the simulation is active and operates in the three-phase turn cycle.

**For character scope:** Return the generated profile to the caller (orchestrator, player, or fork command) with a brief summary of who this person is.
