# Simulation

## Three-Phase Turn Cycle

The simulation operates in a repeating cycle:

### Phase 1: Scene

The orchestrator presents a situation — vivid, immediate, grounded in the world. No state files are read or written beyond what's already in context. The scene ends with a moment that invites the player's response.

### Phase 2: Discussion

The player and orchestrator exchange freely. Multiple messages. This is where the life is co-authored — the player describes what happens, the orchestrator responds with texture and consequences, together they build up meaning and direction.

No state files are touched during discussion. This is conversation, not computation.

Discussion continues until alignment is reached. Either side can signal readiness conversationally — "that feels right", "ready to move forward?" The signal is natural language, not a command.

### Phase 3: Commit

The orchestrator evaluates what was decided during discussion and delegates to domain agents:

1. **Assess what changed** — action, psychological signal, social consequences, plausibility
2. **Delegate to affected domains** — only agents whose state was touched
3. **Assemble results** — collect consequence narratives from domain agents
4. **Write coordination state** — `scene.md` (always), `timeline.json` (if time advances)
5. **Handle inflection points** — snapshot + codex synthesis if a new inflection is crossed
6. **Present next scene** — return to Phase 1

## Formative Event Lifecycle

Events cluster around developmental psychology inflection points. Turn granularity compresses between them and slows at each one.

1. **Attachment formation** (early childhood) — establishes relational baseline
2. **Agency threshold** (late childhood) — first experience of consequential choice
3. **Identity consolidation** (adolescence) — self-concept under social pressure
4. **Moral reasoning inflection** (early adulthood) — values tested against real cost
5. **Generativity vs. stagnation** (midlife) — confrontation with legacy
6. **Integrity vs. despair** (late life) — narrative reconciliation

Between inflection points, the orchestrator compresses time — a single commit might cover years. At inflection points, time slows to scene-level, with multiple discussion-commit cycles exploring a single formative moment.

## Event Types

Each formative event has a type that determines its narrative function and which psychological layers it targets:

- **Attachment disruption** — tests attachment, may form schemas
- **Identity challenge** — tests self-concept
- **Moral inflection point** — tests values hierarchy
- **Agency test** — tests agency themes, persistence
- **Encounter with otherness** — tests worldview, may shift values
- **Loss** — activates schemas, tests defenses
- **Unexpected grace** — potential schema healing, defense maturation

## Relationship Events

Relationship events are a lighter mechanic that operates between inflection points, during time compression. They exist to give the player direct interaction with network characters who would otherwise only appear as background state.

**When they fire:** During time compression, when the orchestrator identifies network characters who haven't had direct player interaction recently. Characters with high warmth or attachment edges, direct information flow, but no recent scene presence are candidates.

**What they are:** Small, naturalistic character interaction scenes. A conversation with a parent at the dinner table. A moment with a sibling in the car. A grandparent's weekend visit. They are texture, not plot — they build relational depth without requiring pivotal-moment stakes.

**How they flow through the turn cycle:** Same three-phase cycle (scene → discussion → commit), but with lower stakes. The scene is a moment, not a crisis. Discussion is shorter. The commit updates `network.json` via the network agent and `scene.md` via the orchestrator. The psychology agent only engages if the interaction crosses the significance threshold — most relationship events won't.

**What they are not:** Not inflection points. They don't trigger snapshots. They don't trigger codex synthesis. They are lightweight commits that build network texture and give the player presence in the character's relational life.

**Pacing integration:** During time compression, instead of a single summary commit covering years, the orchestrator interleaves 1-2 relationship events with the compression narrative. Time still advances — the compression still happens — but the player gets to be present for selected moments within the compressed period.

## Event Presentation

Events involving network characters must be presented based on the protagonist's proximity, not the engine's convenience.

**The presence test:** When a significant event involves a network character, ask: *Would the protagonist have been there?* If yes, present it as a scene the player experiences directly. If no, present it as information arriving through a specific network channel — a phone call, a conversation where someone tells them, a rumor overheard.

**Network events slow compression:** Even during time compression, if a significant event occurs involving a network character and the protagonist would have been present, slow down enough to present it as a scene. Do not skip past it and report it after the fact.

**The significance test:** If the event would change a relationship dynamic — warmth, conflict, attachment, gatekeeper stance — it is significant enough to warrant a scene when the protagonist is present.

**What this prevents:** Events like "Kyle got into a fight and you heard about it later" when the protagonist was in the same building and would have witnessed or been pulled into it. If the character would have been there, the character is there. If the character would only hear about it, they hear about it through a specific channel with its own texture — Marcus telling them at lunch, overhearing in the hallway, a parent mentioning it at dinner.

## Interaction Model

The simulation supports two interaction modes, detected from the tone of the player's message:

**Discussion mode** (`"discussion"`): The player and engine co-author the character's life through conversation. The player describes intentions, motivations, reactions, and ideas about the character's trajectory — and can also shape the surrounding world, relationships, and narrative direction. This is the simulation's natural rhythm.

**Prose mode** (`"prose"`): The player responds in-character to narrative scenes. The engine interprets the prose semantically — extracting intent, action, and psychological signal — and advances the simulation.

The player can shift between modes naturally. No explicit switching is required.

### Player Intention

A player may set an overarching intention for how they approach the simulation — a meta-orientation that sits above the character's psychology. Stored in `config.json` as `player_intention`. The intention is not a character trait — it's a lens the player brings. The engine should be aware of it but not force it; it informs interpretation, not plot.

## Tonal Sovereignty

The user sets the narrative register. The engine maintains it. Only the user can shift it.

If the simulation has been grounded realism, the orchestrator does not introduce fantastical elements. If the user steers toward a new register, the engine follows and the world agent recalibrates the possibility space. The tonal register is captured explicitly in `period.md` so the world agent can validate against it.

The key test: *Did the user initiate this tonal shift, or did the engine?* If the engine, it's a violation. If the user, it's an evolution.

## Presentation Layer

**State files are for the engine. The player sees narrative.**

What the player sees after each commit:
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
