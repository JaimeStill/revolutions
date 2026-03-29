# Plan: Domain Architecture Refactor

## Context

Session 4 playtest revealed two structural problems: (1) the "every message is a turn" model fights the simulation's natural discussion-based rhythm, and (2) subagent delegation barely fires because there's no natural commit boundary. This session refactors the engine into a three-phase turn cycle with dedicated domain agents.

Additionally, two design principles need to be encoded into the architecture:

1. **World-agnostic simulation.** Birth doesn't require a historical setting. The world can be fantasy, sci-fi, alt-history, or anything else. The initialization phase is a collaborative world-building session that runs as long as needed to establish viable foundations. Anything not established at birth emerges through play.

2. **Tonal sovereignty.** The user sets the register — the engine maintains it. Only the user can shift it. If the simulation has been grounded realism for 14 years, the orchestrator never introduces fantastical elements. If the user steers toward the fantastical, the engine follows and recalibrates. This is a validation rule: the world-agent checks plausibility against the established possibility space *and* tonal register, both of which can expand — but only when the user expands them.

## Design

### Three-Phase Turn Cycle

Replace "every player message is a turn" with:

1. **Scene** — Orchestrator presents a situation. Narrative only, no state writes.
2. **Discussion** — Player and orchestrator exchange freely. Multiple messages. Co-authoring what happens. No state files touched.
3. **Commit** — Conversational alignment reached. Orchestrator evaluates what changed, delegates to domain agents, writes state, then presents next scene.

The commit trigger is conversational — either side signals readiness naturally. No `/commit` command.

### Domain Agent Map

| Domain | Agent | Owns | Model |
|--------|-------|------|-------|
| Orchestration | orchestrator | `scene.md`, `timeline.json` | inherit (Opus) |
| Psychology | psychology-agent (new) | `individual.json` | sonnet |
| Social Network | network-agent (exists) | `network.json` | sonnet |
| World | world-agent (new) | `society.json`, `period.md`, `generation.json` | sonnet |
| Literary Codex | codex-agent (exists) | `codex/*` | opus |

The orchestrator owns no state domain except its coordination files (scene, timeline). At commit time it delegates to affected domain agents.

## Execution Order

Work in dependency order — agents first (they define the contracts), then orchestrator (consumes them), then project docs and skills (reference the model).

### Phase 1: New Domain Agents

**1a. Create `.claude/agents/psychology-agent.md`**
- Receives: action summary, current `individual.json`, discussion context
- Processes: schema activation/healing, defense assessment, value reordering, self-concept evolution
- Writes: `individual.json`
- Returns: psychological consequence narrative + change summary

**1b. Create `.claude/agents/world-agent.md`**
- Two modes:
  - **Birth / World-building**: collaborative session to establish the simulation world. Not limited to historical settings — fantasy, sci-fi, alt-history, anything. Generates `period.md` (possibility space + tonal register), `society.json`, `generation.json`. Runs as many exchanges as needed. Conducts research for historical or inspired-by-real settings. Leaves unresolved details for emergent discovery during play.
  - **Validation**: checks plausibility of an action against the established possibility space *and* tonal register. The possibility space can expand — but only when the user expands it through their input.
- Writes: `period.md`, `society.json`, `generation.json` (at birth); `society.json` (rare, during play)
- Returns: validation result, or generated world state at birth
- Key principle: `period.md` captures tonal register alongside factual possibility space, giving the agent something concrete to validate against

### Phase 2: Update Existing Agents

**2a. Rewrite `.claude/agents/orchestrator.md`**
- Strip all domain ownership except scene.md and timeline.json
- Encode three-phase cycle: Scene → Discussion → Commit
- Commit phase = evaluate what changed → delegate to affected domain agents → assemble results → write scene + timeline → present next scene
- Define delegation routing: which domains are affected by what kinds of changes
- Update pacing section (unchanged conceptually, but framed around commit boundaries)
- **Tonal sovereignty principle**: the user sets the register, the engine maintains it, only the user can shift it. The orchestrator never originates tonal shifts — it can escalate, create tension, apply pressure, but always within the established register. If the user steers toward a new register (fantastical, surreal, etc.), the orchestrator follows and delegates to the world-agent to recalibrate the possibility space.

**2b. Review `.claude/agents/network-agent.md`**
- Add explicit note: psychology is not its domain (remove the existing "You do not modify `individual.json`" line and reframe as domain boundary)
- Ensure input/output contract matches what orchestrator will pass at commit time
- Minor — mostly consistent already

**2c. Review `.claude/agents/codex-agent.md`**
- Now receives diffs from multiple domain agents (not just orchestrator)
- Clarify that it receives the orchestrator's assembled change summary, not individual agent outputs
- Minor — mostly consistent already

### Phase 3: Update CLAUDE.md

Rewrite the turn protocol and domain ownership sections to reflect:
- Three-phase cycle
- Domain agent map with file ownership
- Commit-as-delegation model
- Lighter `/lifesim exit`

### Phase 4: Update Skill Commands

**4a. `birth.md`** — Rewrite as a multi-phase initialization session:
- **World-building phase**: collaborative conversation between orchestrator and user to establish the simulation world. Not limited to historical periods — any setting. The orchestrator (or world-agent) conducts research as needed, asks clarifying questions, and iterates until the world is solid. This phase can take many exchanges.
- **World-agent** generates `period.md` (possibility space + tonal register), `society.json`, `generation.json`
- **Character + network**: orchestrator writes initial `individual.json` (biological + temperament only) and `network.json` directly — no interpretation needed at birth, just setup
- Remove the assumption that birth = "pick a historical period." The gather-context step should be open-ended: "What kind of world?" not "What historical period?"
- Preserve all structural steps (snapshot, codex scaffold, instance naming, etc.)

**4b. `exit.md`** — Lighter: validate state is current, create snapshot, commit to git. Synthesis is NOT the primary trigger here — it happens during commit phases. Only run codex agent if the session had commits that didn't trigger synthesis (i.e., no inflection point was crossed during the session).

**4c. `load.md`** — Minor review. State loading doesn't change structurally. May mention domain agents in passing.

**4d. `profile.md`** — Note that psychology domain is owned by psychology-agent. Profile rendering can still be done by orchestrator (it's read-only presentation), but reference the agent as the authority.

**4e. `replay.md`** — Minor. Codex is still the source. No structural change needed.

### Phase 5: Update Project Docs

**5a. `simulation.md`** — Rewrite turn protocol to three-phase cycle. Update interaction model (discussion mode is now the default rhythm, not an alternative).

**5b. `architecture.md`** — Update agent table (remove Future agents that are now implemented, add psychology-agent and world-agent as Active). Update delegation model description.

**5c. `schemas.md`** — Review. Each domain's schema section should note which agent owns it. No schema changes needed — the data structures are fine, it's the ownership and processing model that's changing.

**5d. `state.md`** — Update state ownership table to reflect domain agents.

**5e. `requirements.md`** — Add new requirements for domain agents and three-phase cycle. Check off anything completed by this session.

## Files Changed (Summary)

| Action | File |
|--------|------|
| Create | `.claude/agents/psychology-agent.md` |
| Create | `.claude/agents/world-agent.md` |
| Rewrite | `.claude/agents/orchestrator.md` |
| Edit | `.claude/agents/network-agent.md` |
| Edit | `.claude/agents/codex-agent.md` |
| Rewrite | `CLAUDE.md` |
| Edit | `.claude/skills/lifesim/commands/birth.md` |
| Edit | `.claude/skills/lifesim/commands/exit.md` |
| Edit | `.claude/skills/lifesim/commands/load.md` |
| Edit | `.claude/skills/lifesim/commands/profile.md` |
| Edit | `.claude/skills/lifesim/commands/replay.md` |
| Rewrite | `.claude/project/simulation.md` |
| Rewrite | `.claude/project/architecture.md` |
| Edit | `.claude/project/schemas.md` |
| Edit | `.claude/project/state.md` |
| Edit | `.claude/project/requirements.md` |
| Edit | `.claude/project/README.md` |

## Verification

This is a documentation/architecture refactor — no code to run. Verification is consistency review:
- Every state file has exactly one owning agent
- The orchestrator references no state file it doesn't own (except reads)
- All skill commands reference the correct agent for each domain
- Project docs (simulation, architecture, schemas, state) tell the same story
- Requirements reflect the new model
