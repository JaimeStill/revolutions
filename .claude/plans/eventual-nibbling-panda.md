# Session 5: Domain Architecture Refactor

## Context

Playtest evaluation revealed two fundamental issues:

1. **The turn model is wrong.** The current protocol treats every player message as a simulation turn that advances state. In practice, the simulation works as collaborative discussion where multiple exchanges build up the narrative before state should change. The protocol needs to match how the simulation actually wants to be played.

2. **Subagent delegation barely fires.** During the Session 2 playtest, only the codex agent was invoked (during `/lifesim exit`). The network agent never ran. The orchestrator handled everything monolithically because there's no natural delegation point in the current "every message is a turn" model.

The fix is architectural: redesign the turn protocol around a three-phase cycle, and restructure domain ownership so every state domain has a dedicated subagent with the orchestrator as pure coordinator.

## Three-Phase Turn Cycle

1. **Scene** — Orchestrator presents a situation. Narrative output only, no state changes.
2. **Discussion** — Player and orchestrator go back and forth. Multiple exchanges. They co-author what happens. No state files are touched. This is where the creative collaboration lives.
3. **Commit** — When discussion reaches mutual alignment (detected through natural language, no explicit command needed), the orchestrator evaluates what changed and delegates to domain agents. State files are written, snapshots created, subagents run. Then the next scene is presented.

## Domain Architecture

Every state domain gets a dedicated subagent. The orchestrator owns no state domain — it's the interface between the player and the underlying subsystems.

| Domain | Agent | Owns | Role |
|--------|-------|------|------|
| Orchestration | orchestrator | `scene.md`, `timeline.json` | Player interface, discussion facilitation, commit routing, narrative assembly, pacing |
| Psychology | psychology-agent (new) | `individual.json` | Schema activation, defense assessment, value reordering, self-concept evolution |
| Social Network | network-agent | `network.json` | Consequence propagation, gatekeepers, normative pressure |
| World | world-agent (new) | `society.json`, `period.md`, `generation.json` | World generation at birth, plausibility validation, rare societal updates |
| Literary Codex | codex-agent | `codex/*` | Literary synthesis from state diffs and discussion context |

### Commit Phase Routing

At commit time, the orchestrator evaluates what changed during discussion, then:
- If social dynamics changed → delegate to network agent
- If psychology shifted → delegate to psychology agent
- If inflection point crossed → delegate to codex agent
- If world context changed (rare) → delegate to world agent
- Scene and timeline → orchestrator handles directly (coordination, not domain knowledge)

### `/lifesim exit` becomes lighter

Exit validates state is current, creates a final snapshot if needed, and commits to git. It is not the primary synthesis trigger — that happens during commit phases throughout the session.

## Implementation Scope

### New files
- `.claude/agents/psychology-agent.md` — profile evaluation, schema dynamics, defense assessment
- `.claude/agents/world-agent.md` — world generation (birth), plausibility validation (turns), rare societal updates

### Rewritten files
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

### Not in scope
- Playtest validation (next session)
- New features (snapshot rewinding, ancestry, AI mode)

## Verification

- All five domains have clear agent definitions with explicit file ownership
- Orchestrator instructions encode the three-phase cycle with no direct state domain ownership
- Project docs (simulation.md, architecture.md, schemas.md) are consistent with the new model
- All skill sub-commands (birth, load, exit, profile, replay) are consistent with the new domain architecture
- Birth command delegates world generation to world agent
- Exit command is lightweight (validate + snapshot + commit)
- Requirements.md reflects the new architecture

## Deliverable

This session's output is `.claude/init.md` — the session bootstrap for the next dev session that will execute this refactor. No implementation in this session.
