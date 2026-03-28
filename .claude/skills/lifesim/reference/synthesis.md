# Synthesis Pass Protocol

The synthesis pass transforms machine state into literary codex. It is executed by the codex agent, triggered by the orchestrator at inflection points and session exits.

## Triggers

1. **Inflection point transition** — when a new entry is added to `timeline.json`'s `inflection_points_passed`. Runs after the snapshot is created.
2. **Session exit** — when `/lifesim exit` is invoked. Runs after the exit snapshot is created.

## Inputs

The orchestrator passes the following to the codex agent:

1. **State diff** — the current state files and the most recent prior snapshot, so the agent can identify what changed
2. **Existing codex** — all current codex files, so the agent can maintain continuity and voice
3. **Discussion context** — the conversation that produced the state changes. This is where the life was actually lived — the nuance, the tone, the player's intentions, the emotional texture of decisions. The state diff tells you *what* changed; the discussion tells you *why* and *how it felt*.
4. **Style guide** — `reference/codex-style.md` for craft guidance

## Process

### 1. Identify the diff window

Find the most recent prior snapshot in `state/snapshots/`. Compare its contents against the current state files:

- `individual.json` — what psychological layers changed? New schemas? Values reordered? Defense tier shift?
- `network.json` — new nodes? Changed edges? Gatekeeper shifts? Normative pressure changes?
- `timeline.json` — how much time passed? What developmental stage was entered? What inflection points were crossed?
- `scene.md` — where is the character now vs. where they were?

### 2. Compose the chronicle entry

This is composition, not summarization. The agent reads the state diff and the discussion context, then writes a new chapter or section for `chronicle.md`.

**Finding the arc.** What is the narrative shape of this period? Not every period has drama — some are about consolidation, routine, slow drift. The arc should emerge from what actually happened, not be imposed.

**Building from discussion.** The discussion context contains the living material — the player's intentions, the orchestrator's narrative generation, the back-and-forth that shaped decisions. The chronicle distills this into prose that reads as if it were written by a biographer with complete access to the character's inner life.

**Earning the moments.** Before writing a significant scene, establish the ordinary texture that makes it significant. What did the days before look like? What was the routine that this moment disrupted?

**Sensory grounding.** Every event enters through something the character can perceive. Check the character's age and cognitive development — a six-year-old notices different things than a sixteen-year-old.

**Append, don't overwrite.** New content is appended to `chronicle.md`. Existing chapters are not rewritten unless there is a specific structural reason (e.g., correcting a factual inconsistency discovered during play).

### 3. Create or update character entries

For each network node that changed meaningfully during the diff window:

- **New node** — create a new entry in `characters/`. Write the person as they are *to the character* at this point in the life.
- **Significantly changed relationship** — update the existing entry. Preserve the history of the relationship while reflecting its current state.
- **Minor edge changes** — no update needed. Character entries are revised when the relationship's *nature* shifts, not when numerical edge values fluctuate.

### 4. Create world entries

For events, places, or institutions that became relevant during the diff window:

- **Events** (`world/events/`) — if a historical or cultural event shaped this period, create an entry that documents it with full context. Apply the self-sufficiency test: could someone with no background understand this?
- **Places** (`world/places/`) — if the character entered a new environment (new school, new city, a place that matters), create an entry.
- **Institutions** (`world/institutions/`) — if a school, church, employer, or other institution played a significant role, create an entry.

Don't create entries for everything. Create them for things that carry enough weight to deserve their own documentation — things a reader or the engine might need to reference later.

### 5. Update psychology portrait

If `individual.json` crossed a significance threshold during the diff window — a new schema formed, values reordered, defense tier shifted, self-concept changed — update `psychology/portrait.md`.

The portrait is rewritten (not appended) to reflect the character's current developmental state. It should read as a fresh assessment at the current age, informed by everything that came before.

### 6. Update README indexes

For every codex subdirectory that gained or lost entries, update its `README.md`. Each entry gets a one-line description. Keep descriptions current — if a character's role shifted, update their description in the index.

## Output

The codex agent writes all updated files directly to the instance's `codex/` directory. It returns a brief summary to the orchestrator of what was created or updated, for the orchestrator to incorporate into the player-facing session narrative.

## Quality Check

Before finishing, the codex agent should verify:

- Chronicle entry reads as literature, not as a state-diff summary
- New world entries pass the self-sufficiency test
- Character entries show behavior, not labels
- Psychology portrait reflects current state, not just changes
- All README indexes are current
- Voice is consistent with existing codex entries
