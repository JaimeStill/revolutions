# Simulation

## Turn Protocol

Four steps, executed by the orchestrator on every player message:

1. **Read state** — `scene.md` and `timeline.json` always. Other files as needed based on what the event touches.
2. **Interpret + validate** — Extract action, psychological signal, and cost from the player's prose. Check plausibility against `period.md`. Single pass.
3. **Update state** — Write changed state files. `scene.md` always. `timeline.json` only when time advances. Other files when relevant. If an inflection point is crossed: create a snapshot, then run the synthesis pass.
4. **Generate** — Produce narrative prose ending with a situation that invites a prose response. Never menus, never numbered choices.

## Formative Event Lifecycle

Events cluster around developmental psychology inflection points. Turn granularity compresses between them and slows at each one.

1. **Attachment formation** (early childhood) — establishes relational baseline
2. **Agency threshold** (late childhood) — first experience of consequential choice
3. **Identity consolidation** (adolescence) — self-concept under social pressure
4. **Moral reasoning inflection** (early adulthood) — values tested against real cost
5. **Generativity vs. stagnation** (midlife) — confrontation with legacy
6. **Integrity vs. despair** (late life) — narrative reconciliation

Between inflection points, the orchestrator compresses time — a single turn might cover years. At inflection points, time slows to scene-level, with multiple turns exploring a single formative moment.

## Event Types

Each formative event has a type that determines its narrative function and which psychological layers it targets:

- **Attachment disruption** — tests attachment, may form schemas
- **Identity challenge** — tests self-concept
- **Moral inflection point** — tests values hierarchy
- **Agency test** — tests agency themes, persistence
- **Encounter with otherness** — tests worldview, may shift values
- **Loss** — activates schemas, tests defenses
- **Unexpected grace** — potential schema healing, defense maturation

## Interaction Model

The simulation supports two interaction modes. The active mode is stored in `config.json` as `interaction_model`.

**Discussion mode** (`"discussion"`): The player and engine co-author the character's life through conversation. The player describes intentions, motivations, reactions, and ideas about the character's trajectory — and can also shape the surrounding world, relationships, and narrative direction. The engine interprets this input, updates state, and generates the next narrative beat.

**Prose mode** (`"prose"`): The player responds in-character to narrative scenes. The engine interprets the prose semantically — extracting intent, action, and psychological signal — and advances the simulation.

The player can shift between modes naturally. The engine recognizes which mode is active from the tone of the player's message. No explicit switching is required.

### Player Intention

A player may set an overarching intention for how they approach the simulation — a meta-orientation that sits above the character's psychology. Stored in `config.json` as `player_intention`. The intention is not a character trait — it's a lens the player brings. The engine should be aware of it but not force it; it informs interpretation, not plot.

## Presentation Layer

**State files are for the engine. The player sees narrative.**

What the player sees after each turn:
- **Narrative prose** — the scene, the moment, what happened and what it felt like. Vivid, economical, grounded in sensory detail.
- **A brief narrative summary of what changed** — in human terms, not schema field names.
- **A natural transition** — a scene that invites response, or (in discussion mode) a question that invites thinking about what comes next.

The engine should be as detailed as it wants in state files. The player-facing output is always human-readable narrative.

## Decisions

Player input is interpreted, not parsed:

- **Prose input** — extract intent, action vector
- **Discussion input** — translate intentions and motivations to state changes and narrative
- **Action vs. inaction** — avoidance is a psychological signal
- **Identity alignment** — confirms or challenges the self-concept
- **Cost signal** — what was risked or sacrificed reveals actual values
- **Audience** — private decision vs. social performance affects different layers

## Effects

- **Immediate:** Scene update, network relationship delta, material position change
- **Delayed:** Reputation propagation through network, opportunity opening/closing, trauma or resilience accumulation
- **Generational:** Compression into the inheritance profile for potential descendants

## Ancestry

Ancestry is not predetermined. Stubs are maintained and resolved retroactively as the character's psychology develops. When the orchestrator detects a psychological pattern, it asks: "What kind of family history would produce this?" Ancestor traits are filled in consistent with expressed psychology. The player discovers their ancestry through the character's life, not before it.
