# Next Session: Domain Architecture Refactor

## Context

Session 4 playtest advanced Drew to age 14 (August 2007, threshold of eighth grade). Content quality is excellent — chronicle, psychology portrait, character entries, network state all read well. But evaluation of the engine itself revealed two architectural issues:

1. **The turn model doesn't match how the simulation plays.** Every player message is treated as a turn that advances state. In practice, the simulation works best as collaborative discussion — multiple exchanges building up narrative before anything should change. The protocol needs a distinct discussion phase where no state is written, followed by an explicit commit phase where all processing happens.

2. **Subagent delegation barely fires.** Only the codex agent was invoked (during `/lifesim exit`). The network agent never ran. The orchestrator handled everything monolithically because there's no natural delegation point in a "every message is a turn" model.

## What to Build

### Three-Phase Turn Cycle

Replace the current "every message is a turn" protocol with:

1. **Scene** — Orchestrator presents a situation. Narrative output only, no state changes.
2. **Discussion** — Player and orchestrator go back and forth. Multiple exchanges co-authoring what happens — the details, the tone, the consequences. No state files are touched.
3. **Commit** — When discussion reaches mutual alignment (natural language, no explicit command), the orchestrator evaluates what changed and delegates to domain agents. State files are written, snapshots created. Then the next scene is presented.

The commit trigger is conversational — either side can signal alignment ("that feels right", "ready to lock this in?"). No explicit command needed.

### Domain Agent Architecture

Every state domain gets a dedicated subagent. The orchestrator becomes pure coordination — it owns no state domain, it's the interface between the player and the subsystems.

| Domain | Agent | Owns | Role |
|--------|-------|------|------|
| Orchestration | orchestrator | `scene.md`, `timeline.json` | Player interface, discussion, commit routing, narrative assembly, pacing |
| Psychology | psychology-agent (**new**) | `individual.json` | Schema activation, defense assessment, value reordering, self-concept evolution |
| Social Network | network-agent (exists) | `network.json` | Consequence propagation, gatekeepers, normative pressure |
| World | world-agent (**new**) | `society.json`, `period.md`, `generation.json` | World generation at birth, plausibility validation, rare societal updates |
| Literary Codex | codex-agent (exists) | `codex/*` | Literary synthesis from state diffs and discussion context |

At commit time, the orchestrator evaluates what changed during discussion and delegates to every domain agent whose state was affected. For domains without changes, no delegation. Scene and timeline are orchestrator coordination files — it writes those directly.

### `/lifesim exit` Becomes Lighter

Exit validates state is current, creates a final snapshot if needed, and commits to git. It is **not** the primary synthesis trigger — that happens during commit phases throughout the session.

## Files to Create

- `.claude/agents/psychology-agent.md` — profile evaluation, schema dynamics, defense assessment
- `.claude/agents/world-agent.md` — world generation (birth), plausibility validation (turns), rare societal updates

## Files to Rewrite

- `.claude/agents/orchestrator.md` — strip domain ownership, three-phase turn cycle, commit-as-delegation
- `.claude/agents/network-agent.md` — review for consistency with new domain boundaries
- `.claude/agents/codex-agent.md` — review; now receives diffs from multiple domain agents
- `CLAUDE.md` — updated turn protocol, domain ownership summary
- `.claude/project/simulation.md` — three-phase turn protocol, domain map
- `.claude/project/architecture.md` — agent responsibilities, delegation model
- `.claude/project/schemas.md` — ensure each domain's schema is clearly scoped to its agent
- `.claude/project/requirements.md` — new requirements for domain agents, update existing
- `.claude/skills/lifesim/commands/birth.md` — world generation delegates to world agent
- `.claude/skills/lifesim/commands/load.md` — review; state loading may need to orient around domain agents
- `.claude/skills/lifesim/commands/exit.md` — lighter flow (validate + snapshot + commit, not synthesis trigger)
- `.claude/skills/lifesim/commands/profile.md` — review; psychology domain now owned by psychology agent
- `.claude/skills/lifesim/commands/replay.md` — review; codex domain now owned by codex agent

## What's Not in Scope

- Playtest validation (following session)
- New features (snapshot rewinding, ancestry, AI mode)

## Definition of Done

- All five domains have clear agent definitions with explicit file ownership
- Orchestrator encodes the three-phase cycle with no direct state domain ownership
- Project docs (simulation.md, architecture.md, schemas.md) are consistent with the new model
- All skill sub-commands (birth, load, exit, profile, replay) are consistent with the new domain architecture
- Requirements.md reflects the new architecture
- Session committed and PR'd
