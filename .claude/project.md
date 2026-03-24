# Revolutions

A human lifecycle simulator where Claude Code is the simulation engine.

## Vision

Revolutions captures patterns of human growth under specific cultural and historical conditions. It generates psychological profiles of individuals within generational and social constraints, driven by prose input — from a human player or AI subagent — rather than discrete choice menus.

Every decision is a prose response to a narrative event. Intent is interpreted semantically, not parsed. Formative moments are structured around developmental psychology inflection points. Ancestry is not predetermined — ancestor traits emerge retroactively through the psychological profile of the main character.

The simulation treats Claude Code's context window as its frame buffer, its agents as processing units, its file system as the persistence layer, and its architectural constraints as the simulation's physics.

## How It Works

A player starts a life with `/birth`. The orchestrator — the main agent running the session — coordinates specialized subagents to generate a world, a character, and the first formative event. The player responds in prose. The orchestrator processes every subsequent message as a turn: the psyche-agent interprets the response, the world-agent validates it against the period's possibility space, the network-agent propagates social consequences, and the narrative-agent generates the next event.

There is no `/turn` command. The conversation IS the game. Every message after `/birth` is a turn. The orchestrator knows the protocol because its system prompt defines it.

State lives on disk in `sim/state/`. The conversation is a working surface — disposable, rebuildable. When context compaction fires, hooks rebuild the simulation entirely from state files. The player never notices.

## Architecture

### Claude Code as Simulation Engine

These constraints define the simulation's physics:

1. **Flat agent hierarchy.** Subagents cannot spawn subagents. The orchestrator is the main thread; all others are leaf workers.
2. **Context window = frame budget.** State read into context is "rendered." State on disk is cold storage. LOD management is deciding which files to read.
3. **Skills are prompt injections.** `/birth` loads directives into the orchestrator's context. It is an instruction, not a program.
4. **Hooks are deterministic.** Shell scripts that enforce invariants. They can't reason, but they always run.
5. **No inter-agent communication.** Subagents return results to the orchestrator. All coordination flows through the main thread.
6. **Persistence = files.** JSON and markdown in `sim/` are the only state that survives across turns and sessions.
7. **Model routing is per-agent.** Haiku for cheap/fast validation, Sonnet for nuanced interpretation, Opus for deep reasoning.

### Agents

The orchestrator runs as the session's main agent via `settings.json`. All others are subagents it spawns.

| Agent | Model | Responsibility |
|-------|-------|---------------|
| **orchestrator** | inherit (Opus) | Main thread. Every player message is a turn. Routes to subagents, manages state I/O, controls context budget. |
| **world-agent** | haiku | Holds society and generation state. Validates whether a player action is within the possibility space of the period. |
| **network-agent** | haiku | Tracks relationship nodes and tie qualities. Processes social consequences of decisions. |
| **psyche-agent** | sonnet | Maintains the individual psychological profile. Interprets player prose — extracts action vector, identity alignment, cost signal. Updates profile when threshold crossed. |
| **narrative-agent** | sonnet | Synthesizes state across all layers to generate the next formative event. Manages turn granularity — compresses time or slows to scene-level. Produces the prose the player reads. |
| **ancestor-agent** | haiku / sonnet | Maintains ancestry stubs (haiku). Retroactively resolves ancestor traits consistent with the player's expressed psychology (sonnet). |

### Skills

The simulation is organized as a single skill (`lifesim`) with sub-commands. Each sub-command loads only the context it needs — optimizing the context budget.

| Command | Purpose | Invocation |
|---------|---------|------------|
| `/lifesim birth` | Initialize character, world, generation. Start a new life. | User |
| `/lifesim load <instance>` | Load an existing simulation instance into context. | User |
| `/lifesim exit` | Save all state, write session summary, commit and push, close the simulation. | User |
| `/lifesim profile` | Render the current psychological state in human-readable form. | User or model |
| `/lifesim compress` | Archive cold state to free context budget. | Model |
| `/lifesim replay` | Reconstruct life narrative from the decision and event logs. | User |

Turn processing is not a sub-command. After birth or load, every player message is a turn handled by the orchestrator directly.

### Hooks

| Hook Event | Matcher | Purpose |
|------------|---------|---------|
| `SessionStart` | `compact` | Rebuild context from the active instance's state files after compaction. Reads `sim/.active` to find the instance. |
| `PreCompact` | — | Validate critical state files exist in the active instance before compaction fires. |

Session start/resume is handled by `/lifesim load` — no startup hook needed. The `sim/.active` file is a runtime breadcrumb written by birth/load for hook use, not a session persistence mechanism.

### Context Management

State files are ground truth. The conversation is ephemeral.

- `CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=60` triggers compaction at 60% capacity — early and fast.
- `PreCompact` hook validates state files exist before compaction.
- `SessionStart` hook with `compact` matcher rebuilds context from the active instance's state files. The compaction summary is irrelevant — state files are authoritative.
- `scene.md` in each instance captures the current narrative moment. This bridges continuity across compaction.
- At 60% threshold, compaction is fast (less to summarize) and reclaims ~40% of the window. Since we rebuild from files, triggering early is strictly better than the default 95%.

## State

### File Layout

Each simulation instance is fully self-contained:

```
sim/
  .active                        # Runtime breadcrumb — current instance name (for hooks)
  <instance-name>/               # One directory per simulation run
    config.json                  # Simulation parameters for this run
    state/
      period.md                  # Historical period reference (generated at birth, read-only)
      society.json               # Social conditions for this life
      generation.json            # Birth cohort, collective events, economic conditions
      network.json               # Relationship graph — nodes and edges
      individual.json            # Seven-layer psychological profile
      timeline.json              # Current age, developmental stage, turn counter
      scene.md                   # Current narrative context (bridge across compaction)
    archive/                     # Compressed cold state (old network nodes, resolved events)
    log/
      decisions.jsonl            # Append-only log of player decisions
      events.jsonl               # Append-only log of generated events
```

### State Layers

Each layer has a different update rate. Period and generation are constants per life (read-only after birth). Society is near-constant (rare upheavals only). Social network is slow-moving. Individual state updates when thresholds are crossed. Scene updates every turn.

#### Period (`period.md`)

A prose reference document generated at birth describing the historical period's possibility space. Used by the orchestrator to validate player actions. Covers what is physically possible, socially permissible, conceivable, punishable, and available as opportunity. Written as prose, not rules.

#### Society (`society.json`)

```json
{
  "period": "14th century",
  "region": "Northern France",
  "culture": "Feudal Christian Europe",
  "material_conditions": {
    "economic_mode": "agrarian feudalism",
    "scarcity_profile": "subsistence with periodic famine",
    "technology_tier": "pre-mechanical"
  },
  "power_structure": {
    "political_form": "feudal monarchy",
    "enforcement": "local lords, church courts",
    "mobility_constraints": {
      "class": "rigid — born into station",
      "gender": "severe — women as property in most contexts",
      "ethnicity": "variable — outsiders suspect"
    }
  },
  "worldview": {
    "dominant": "Catholic Christianity",
    "relationship_to_nature": "fallen world, divine order",
    "relationship_to_authority": "ordained by God"
  },
  "collective_trauma": ["Black Death (ongoing)", "Hundred Years War"],
  "information_environment": {
    "literacy_rate": "clergy and nobility only",
    "primary_medium": "oral tradition, church sermons",
    "censorship": "church controls written knowledge"
  }
}
```

#### Generation (`generation.json`)

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

#### Network (`network.json`)

```json
{
  "nodes": [
    {
      "id": "mother",
      "name": "Marguerite",
      "role": "family_nuclear",
      "alive": true,
      "qualities": {
        "attachment_strength": 0.8,
        "obligation_weight": 0.9,
        "aspiration_vector": "wants child to survive",
        "resentment_load": 0.1
      }
    }
  ],
  "edges": [
    {
      "from": "self",
      "to": "mother",
      "type": "primary_attachment",
      "warmth": 0.7,
      "conflict": 0.2
    }
  ],
  "gatekeepers": [
    {
      "node_id": "village_priest",
      "controls_access_to": ["literacy", "legitimacy", "spiritual authority"]
    }
  ],
  "normative_pressure": {
    "rewarded": ["obedience", "piety", "labor"],
    "punished": ["questioning", "ambition beyond station", "sexual deviance"]
  }
}
```

#### Individual (`individual.json`) — Seven-Layer Psychological Profile

The core of the simulation. Each layer is grounded in established psychological theory, operates at a different timescale, and serves a different narrative function.

```json
{
  "biological": {
    "sex": "female",
    "health_baseline": "sturdy",
    "physical_capacity": "above average for age and nutrition"
  },

  "temperament": {
    "_theory": "Thomas & Chess / Rothbart",
    "_note": "Set near birth, slow drift. The character's natural grain.",
    "activity": 0.6,
    "reactivity": 0.8,
    "sociability": 0.3,
    "persistence": 0.7
  },

  "attachment": {
    "_theory": "Bowlby / Ainsworth",
    "_note": "Formed early childhood. Colors all relationship processing.",
    "style": "anxious",
    "stability": 0.6,
    "formed_at": "age 3",
    "forming_context": "Mother's illness created unpredictable availability",
    "key_relationship": "mother"
  },

  "schemas": {
    "_theory": "Young's Schema Therapy — early maladaptive schemas",
    "_note": "3-5 activated schemas. Resistant to change. Narrative gold.",
    "active": [
      {
        "name": "abandonment",
        "unmet_need": "stable connection",
        "core_belief": "People I love will leave or die",
        "compensatory_strategy": "hypervigilance in relationships — watches for signs of withdrawal",
        "formed_at": "age 5",
        "forming_context": "Father died of plague. Mother withdrawn in grief.",
        "activation_level": 0.7
      },
      {
        "name": "emotional_deprivation",
        "unmet_need": "nurturing and attention",
        "core_belief": "My needs are too much for others to meet",
        "compensatory_strategy": "self-sufficiency — never asks for help",
        "formed_at": "age 6",
        "forming_context": "Mother could not attend to emotional needs while keeping family alive",
        "activation_level": 0.5
      }
    ]
  },

  "values": {
    "_theory": "Schwartz's Theory of Basic Human Values",
    "_note": "Crystallizes adolescence-adulthood. Top values = what's protected first under pressure.",
    "hierarchy": ["security", "benevolence", "conformity", "tradition"],
    "tested_by": [],
    "last_reordered": null
  },

  "self_concept": {
    "_theory": "McAdams' Narrative Identity Theory",
    "_note": "Constructed throughout life. Most resistant to rapid change.",
    "agency": "moderate — I can influence my immediate world but larger forces are beyond me",
    "communion": "high — I define myself through my bonds with others",
    "dominant_sequence": "contamination — good things are fragile and will be taken",
    "identity_statement": "I am someone who holds things together for others"
  },

  "defenses": {
    "_theory": "Vaillant's hierarchy of defense mechanisms",
    "_note": "Under stress, regress to less mature tiers. Growth = more mature defenses.",
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

The psyche-agent reads all layers when interpreting a player decision. It checks:
- Does this action confirm or contradict the **values hierarchy**?
- Does it activate or heal a **schema/wound**?
- Does it confirm or challenge the **self-concept narrative**?
- What **defense mechanisms** are currently active?

If the decision crosses a significance threshold, the psyche-agent updates the relevant layers. Layers 1-2 barely change. Layer 3 shifts only at major inflection points. Layer 4 can reorder through moral tests. Layers 5-6 are moderately dynamic. Layer 7 (current state, in `scene.md`) changes every turn.

The narrative-agent reads the profile to generate events targeting the character's active tensions — presenting situations that force schemas into conflict with values, or that test the self-concept against reality.

#### Timeline (`timeline.json`)

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

#### Scene (`scene.md`)

A narrative document, not JSON. Written by the orchestrator after each turn. Read first on session start and after compaction.

```markdown
## Current Scene

**Year:** 1353 | **Age:** 8 | **Season:** Late autumn

The village is preparing for winter. Three more families left after the last wave
of sickness. Marguerite has taken in a neighbor's orphaned son — another mouth,
but she couldn't leave him. The village priest has noticed that Agnes can read
the few words scratched on the church wall. He's offered to teach her letters.

## Last Decision

The player chose to accept the priest's offer despite Marguerite's unease about it.
This represents the character's first independent choice that goes against a primary
attachment figure's wishes.

## Pending

The priest's teaching creates a new relationship node (mentor) and activates the
agency_threshold inflection point. The next event should test whether this independence
is sustainable — what does it cost to want something for yourself in this world?

## Emotional State

Anxiety: moderate (leaving mother's sphere).
Excitement: high (first taste of knowledge).
Guilt: low but present (mother's disapproval).
```

### Formative Event Lifecycle

Events cluster around developmental psychology inflection points. Turn granularity compresses between them and slows at each one.

1. **Attachment formation** (early childhood) — establishes relational baseline
2. **Agency threshold** (late childhood) — first experience of consequential choice
3. **Identity consolidation** (adolescence) — self-concept under social pressure
4. **Moral reasoning inflection** (early adulthood) — values tested against real cost
5. **Generativity vs. stagnation** (midlife) — confrontation with legacy
6. **Integrity vs. despair** (late life) — narrative reconciliation

Between inflection points, the orchestrator compresses time — a single turn might cover years. At inflection points, time slows to scene-level, with multiple turns exploring a single formative moment.

### Event Types

Each formative event has a type that determines its narrative function and which psychological layers it targets:

- **Attachment disruption** — tests Layer 2, may form Layer 3 schemas
- **Identity challenge** — tests Layer 5 self-concept
- **Moral inflection point** — tests Layer 4 values hierarchy
- **Agency test** — tests Layer 5 agency themes, Layer 1 persistence
- **Encounter with otherness** — tests worldview, may shift Layer 4
- **Loss** — activates Layer 3 schemas, tests Layer 6 defenses
- **Unexpected grace** — potential schema healing, defense maturation

### Interaction Model

The simulation supports two interaction modes. The active mode is stored in the instance's `config.json` as `interaction_model`.

**Discussion mode** (`"discussion"`): The player and engine co-author the character's life through conversation. The player describes intentions, motivations, reactions, and ideas about Drew's trajectory — and can also shape the surrounding world, relationships, and narrative direction. The engine interprets this input, updates state, and generates the next narrative beat. This mode is ideal during formative periods when the character is still crystallizing, and when the player wants to think through choices rather than perform them.

**Prose mode** (`"prose"`): The player responds in-character to narrative scenes. The engine interprets the prose semantically — extracting intent, action, and psychological signal — and advances the simulation. This mode works best once the character is well-established and the player wants immersive scene-level interaction.

The player can shift between modes naturally. The engine should recognize which mode is active from the tone of the player's message and respond accordingly. No explicit switching is required.

#### Player Intention

A player may set an overarching intention for how they approach the simulation — a meta-orientation that sits above the character's psychology. This is stored in `config.json` as `player_intention`. Examples: "explore what I would have done differently with adult wisdom," "see how far ambition takes someone in this period," "play a life of quiet resistance." The intention is not a character trait — it's a lens the player brings. The engine should be aware of it but not force it; it informs interpretation, not plot.

### Presentation Layer

**State files are for the engine. The player sees narrative.**

When the orchestrator updates state files (individual.json, network.json, timeline.json, etc.), those updates are internal bookkeeping. The player should never be shown raw JSON, file paths, or schema field names as the primary output of a turn.

What the player sees after each turn:
- **Narrative prose** — the scene, the moment, what happened and what it felt like. Written as an expert narrator would deliver it: vivid, economical, grounded in sensory detail.
- **A brief narrative summary of what changed** — not "updated attachment.style to 'secure with anxious undertone'" but "Drew's sense of the world is forming: his mother is reliable but watchful, and he's learning that safety requires vigilance."
- **A natural transition** — either a scene that invites response, or (in discussion mode) a question or observation that invites the player's thinking about what comes next.

The engine should be as detailed as it wants in the state files. But the player-facing output is always human-readable narrative. The files are the engine's memory. The prose is the player's experience.

### Decisions

Player input is interpreted, not parsed:

- **Prose input** — psyche-agent extracts intent, action vector
- **Discussion input** — player describes intentions, motivations, and trajectory; engine translates to state changes and narrative
- **Action vs. inaction** — avoidance is a psychological signal (activates different schemas than engagement)
- **Identity alignment** — confirms or challenges the self-concept
- **Cost signal** — what was risked or sacrificed reveals actual values (not stated values)
- **Audience** — private decision vs. social performance affects different layers

### Effects

- **Immediate:** Self-state update (Layer 7), network relationship delta, material position change
- **Delayed:** Reputation propagation through network, opportunity opening/closing, trauma or resilience accumulation
- **Generational:** Compression into the inheritance profile for potential descendants

## Configuration

Each instance's `config.json` controls simulation fidelity. Token budget is treated as a hardware constraint; these parameters are the LOD controls. Defaults are set at birth.

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

| Parameter | Values | Effect |
|-----------|--------|--------|
| `state_resolution` | 1-5 | Number of actively tracked fields per state layer. Higher = richer but more context. |
| `turn_scope` | `day` / `season` / `year` / `decade` | Time window per turn. Wider = faster life, less compaction. |
| `narrative_verbosity` | `minimal` / `medium` / `rich` | Prose length per event. |
| `profile_update_threshold` | `any` / `significant` / `major` | How significant a decision must be to trigger profile recalculation. |
| `network_depth` | 1-10 | Number of actively simulated relationship nodes. |
| `ancestry_detail` | `stub` / `emergent` | Shallow placeholder vs. retroactively resolved through play. |
| `player_mode` | `human` / `ai` / `hybrid` | Who provides prose responses to events. |

## Cultural Constraints — Period Context

The orchestrator validates player actions against `state/period.md` — a prose document generated at birth describing the possibility space of the character's historical period. It is not a ruleset; the orchestrator reads it and uses judgment.

The period document covers:
- What is physically possible given the technology
- What is socially permissible given the power structure
- What is conceivable given the information environment
- What would be punished and how
- What opportunities exist and for whom

The core question: "Could this person, in this place and time, do what the player described?"

Period context is generated from the model's training knowledge at birth — not hardcoded. Each simulation instance stores its own `period.md`, separate from `society.json` (which captures the specific social conditions the character navigates rather than the period's general possibility space).

## Ancestry

Ancestry is not predetermined. The ancestor-agent maintains stubs — minimal placeholders — and resolves them retroactively as the character's psychology develops.

When the psyche-agent detects a pattern (e.g., a deep-seated fear of authority), the ancestor-agent asks: "What kind of family history would produce this?" It then fills in ancestor traits that are consistent with the character's expressed psychology. The player discovers their ancestry through the character's life, not before it.

## Directory Structure

```
revolutions/
  CLAUDE.md                      # Simulation identity and turn protocol
  .claude/
    project.md                   # This document — the authoritative reference
    init.md                      # Next session bootstrap (generated at end of each session)
    settings.json                # Orchestrator config, hooks, env vars
    agents/
      orchestrator.md            # Main agent — turn routing, state management
    skills/
      lifesim/                   # Single skill with sub-commands
        SKILL.md                 # Routes sub-commands, shared context
        commands/
          birth.md               # /lifesim birth — initialize a new life
          load.md                # /lifesim load — resume a simulation
          profile.md             # /lifesim profile — render psychological state
          compress.md            # /lifesim compress — archive cold state
          replay.md              # /lifesim replay — reconstruct life narrative
    hooks/
      session-compact.sh         # Rebuild context after compaction
      pre-compact.sh             # Validate state before compaction
  sim/
    .active                      # Runtime breadcrumb (current instance name)
    <instance-name>/             # One per simulation run (self-contained)
      config.json
      state/
      log/
      archive/
```

## Requirements

Capabilities the simulation needs, roughly ordered by dependency. Development unfolds naturally — pick up wherever makes sense in a given session.

### Core Loop
- [x] Orchestrator agent processes every player message as a turn
- [x] `/lifesim birth` initializes a character, world, and first formative event
- [x] `/lifesim load` resumes an existing simulation instance
- [ ] State files persist to disk after every turn
- [x] Compaction hooks rebuild context seamlessly from state files
- [x] Simulation instances are self-contained directories

### Psychological Engine
- [ ] Orchestrator interprets player prose and extracts intent (future: psyche-agent)
- [ ] Seven-layer profile updates when significance threshold is crossed
- [ ] Events target active psychological tensions (future: narrative-agent)
- [ ] Formative event lifecycle pacing — compress between inflection points, slow at them

### World Simulation
- [ ] Orchestrator validates actions against period.md (future: world-agent)
- [ ] Period context generated at birth from model knowledge
- [ ] Society and generation state inform event generation
- [ ] Material conditions constrain what's possible

### Social Network
- [ ] Relationship nodes and edges tracked in network.json (future: network-agent)
- [ ] Social consequences propagate through the network
- [ ] Gatekeepers control access to opportunity
- [ ] Normative pressure affects decision costs

### Ancestry
- [ ] Ancestry stubs maintained (future: ancestor-agent)
- [ ] Retroactive trait resolution based on expressed psychology
- [ ] Ancestry integrates with the character's self-concept narrative

### Player Modes
- [ ] Human mode — player provides prose responses (default)
- [ ] AI mode — a subagent generates prose responses autonomously
- [ ] Hybrid mode — AI generates default, player can override
- [x] `/lifesim replay` reconstructs the life narrative from logs

### Quality of Life
- [x] `/lifesim profile` renders a readable psychological portrait
- [x] `/lifesim compress` archives cold state to manage context budget
- [ ] Configurable parameters in instance `config.json` control fidelity
- [x] Session resume via `/lifesim load`
