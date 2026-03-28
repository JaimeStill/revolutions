# Plan: Synthesis Pass, Social Network Dynamics, and Subagent Decomposition

## Context

The simulation engine has a two-domain state architecture (state/ for machine data, codex/ for literary prose), but the **synthesis pass** — the process that generates codex from state — has never been implemented. The codex for drew-1993 was hand-authored during playtesting. Additionally, **social network dynamics** (consequence propagation, gatekeepers, normative pressure) are defined in schema but not processed during turns.

This session matures both systems and introduces two subagents to handle them, decomposing the orchestrator's responsibilities for better context efficiency and separation of concerns.

### Architectural Distinction

Two layers that must stay cleanly separated:

- **The engine** — `CLAUDE.md` + `.claude/agents/` + `.claude/skills/lifesim/` + `.claude/hooks/` — runtime instructions that drive the simulation.
- **Project docs** — `.claude/project/` — development-time reference for dev sessions via iterative-dev. Tracks requirements, schemas, architecture decisions.

New capabilities live **in the engine**. Project docs track *that* they exist and *why*.

### Critical Creative Constraint

Codex prose must be literary, alive, and self-sufficient:

1. **Never rely on the reader's prior knowledge.** Historical events enter the chronicle only through specific, sensory, ground-level changes in the character's daily experience.
2. **Moments must be earned by their context.** Ordinary texture is the soil significant moments grow from.
3. **Characters are people, not caricatures.** Distinctiveness from specific mannerisms and ways of being, not exaggerated traits.
4. **Events get two outputs.** A world entry with full historical context, and a chronicle passage rendering how it filtered into the character's perceptual world.

---

## Subagent Architecture

The orchestrator remains the main thread — interpretation, generation, pacing, scene writing. Two new leaf agents handle specialized work:

### Codex Agent — `.claude/agents/codex-agent.md`

- **Model:** opus (literary composition needs the best reasoning)
- **Responsibility:** Synthesis pass — composing codex entries from state diffs
- **Triggered by:** Orchestrator at inflection points and session exits
- **Input:** State diff (current vs. last snapshot), existing codex files, style guide, **and the discussion context** — the conversation that produced the state changes, so the agent understands the nuance, tone, and emotional texture behind the data
- **Output:** Updated codex files (chronicle entry, character updates, world entries, psychology portrait, README indexes)
- **Context:** Style guide + existing codex + state diff + discussion context from the orchestrator's prompt

### Network Agent — `.claude/agents/network-agent.md`

- **Model:** sonnet (structured reasoning, not literary composition)
- **Responsibility:** Social consequence processing — propagation, gatekeepers, normative pressure
- **Triggered by:** Orchestrator during turns that involve social interaction
- **Input:** Action summary from the orchestrator (what happened, who was involved, who witnessed it), current network.json, relevant character context, **and the discussion context** — so the agent understands the tone and interpersonal nuance of the interaction, not just the mechanical facts
- **Output:** Updated network.json + narrative summary of social consequences for the orchestrator to weave into generation
- **Context:** Network state + action summary + discussion context from the orchestrator's prompt

### Orchestrator changes

The orchestrator's turn protocol becomes:

1. **Read state** — unchanged
2. **Interpret + validate** — unchanged
3. **Social processing** — if the action involves people, delegate to the network agent. Receive updated network state and consequence summary.
4. **Update state** — write state files including network agent's updates. If inflection point crossed: create snapshot, then delegate synthesis to the codex agent.
5. **Generate** — produce narrative, informed by the network agent's consequence summary

---

## Files to Create or Modify

### Engine files

| File | Action | Purpose |
|------|--------|---------|
| `.claude/agents/codex-agent.md` | **Create** | Codex synthesis subagent |
| `.claude/agents/network-agent.md` | **Create** | Social network processing subagent |
| `.claude/agents/orchestrator.md` | **Modify** | Update turn protocol to delegate to subagents |
| `.claude/skills/lifesim/reference/codex-style.md` | **Create** | Literary craft guide (loaded by codex agent) |
| `.claude/skills/lifesim/reference/synthesis.md` | **Create** | Synthesis pass protocol (loaded by codex agent) |
| `.claude/skills/lifesim/SKILL.md` | **Modify** | Update instance layout, reference new docs |
| `.claude/skills/lifesim/commands/birth.md` | **Modify** | Initialize new codex directory structure with READMEs |
| `.claude/skills/lifesim/commands/exit.md` | **Modify** | Reference synthesis protocol for codex agent delegation |
| `CLAUDE.md` | **Modify** | Clarify engine vs. project doc distinction, document subagent architecture |

### Project docs

| File | Action | Purpose |
|------|--------|---------|
| `.claude/project/README.md` | **Modify** | Add pointers to new engine docs |
| `.claude/project/architecture.md` | **Modify** | Update agent table — codex-agent and network-agent now active |
| `.claude/project/schemas.md` | **Modify** | Update network.json schema, document codex structure |
| `.claude/project/state.md` | **Modify** | Update instance layout for new codex subdirectories |
| `.claude/project/requirements.md` | **Modify** | Check off completed items |

### Instance migration

| File | Action | Purpose |
|------|--------|---------|
| `sim/drew-1993/codex/` | **Restructure** | Reorganize world/ into subdirectories, add README indexes |
| `sim/drew-1993/state/network.json` | **Migrate** | Evolve to enhanced schema |

---

## Implementation Details

### 1. CLAUDE.md — Engine vs. Project Distinction

Add a clear section:

**Engine architecture:**
- `CLAUDE.md` — simulation identity, turn protocol, state ownership
- `.claude/agents/orchestrator.md` — main agent: interpretation, generation, pacing
- `.claude/agents/codex-agent.md` — synthesis subagent: literary codex composition
- `.claude/agents/network-agent.md` — social network subagent: consequence propagation
- `.claude/skills/lifesim/` — commands (birth, load, exit, profile, replay) + reference docs (codex style, synthesis protocol)
- `.claude/hooks/` — compaction hooks for context continuity

**Development reference (not part of the engine):**
- `.claude/project/` — architecture docs, schemas, requirements. Used during dev sessions via iterative-dev.

### 2. Codex Style Guide — `.claude/skills/lifesim/reference/codex-style.md`

New `reference/` directory in the lifesim skill for docs loaded by the engine during specific operations.

**Sections:**
- **Core principles** — the four creative constraints, expanded with craft-level guidance
- **Chronicle craft** — chapter structure, time compression in prose, weaving ordinary texture, events entering only through character's sensory world
- **Character entries** — who someone *is* to the character, voice specificity, observation over clinical description
- **Psychology portrait** — developmental assessment voice, theory in readable prose
- **World entries** — self-contained entries for events, places, institutions. Organized in subdirectories. The self-sufficiency test: could a reader with zero background understand this?
- **README indexes** — every codex subdirectory gets one for discoverability
- **Anti-patterns** — tells of generic AI prose to avoid
- **Economy** — every sentence earns its place

### 3. Synthesis Protocol — `.claude/skills/lifesim/reference/synthesis.md`

**Sections:**
- **Triggers** — inflection point transitions, session exit (both after snapshot)
- **Process** (executed by codex agent):
  1. Identify baseline snapshot and current state
  2. Diff individual.json, network.json, timeline.json
  3. Compose chronicle entry (not summarize)
  4. Create/update character entries for meaningfully changed nodes
  5. Create world entries for events, places, institutions that became relevant
  6. Update psychology portrait if significance threshold crossed
  7. Update all affected README indexes
- **Delegation protocol** — how the orchestrator invokes the codex agent, what context to pass, what to expect back

### 4. Codex Agent — `.claude/agents/codex-agent.md`

**Agent definition:**
- Name: codex-agent
- Model: opus
- Description: Synthesis subagent for literary codex composition

**Instructions:**
- You are the codex composer. You receive state diffs, existing codex, and discussion context, and produce literary prose.
- Always load `reference/codex-style.md` for craft guidance
- Always load `reference/synthesis.md` for process
- Read the discussion context to understand the nuance and emotional texture behind the state changes — this is where the life was actually lived
- Read existing codex to maintain voice continuity — match the established style
- Read the state diff to understand what structurally changed
- Compose — don't summarize. The codex is literature, not a report.
- Output: write updated codex files directly to the instance

### 5. Network Agent — `.claude/agents/network-agent.md`

**Agent definition:**
- Name: network-agent
- Model: sonnet
- Description: Social network processing subagent

**Instructions:**
- You process social consequences of player actions
- Input: action summary (what happened, who was involved, witnesses), current network.json, discussion context (so you understand the interpersonal nuance, not just the facts)
- **Propagate consequences** — trace through edges using visibility and information_flow. Who learns about this? How do their feelings toward the character shift?
- **Check gatekeepers** — does this action change any gatekeeper's stance? Open or close access?
- **Apply normative pressure** — does this align with or deviate from rewarded/punished behaviors? What's the cost or reward?
- Output: updated network.json + a narrative summary of social ripple effects

### 6. Social Network Schema Evolution

**Gatekeepers** — from flat list to structured:
```json
"gatekeepers": [
  {
    "node_id": "karen",
    "gates": "social access — who Drew can visit, where he can go",
    "conditions": "academic performance, good behavior",
    "current_stance": "permissive — Drew is low-maintenance"
  }
]
```

**Normative pressure** — add enforcement and cost:
```json
"normative_pressure": {
  "rewarded": [
    {
      "behavior": "academic achievement",
      "enforced_by": ["karen", "greg", "school"],
      "reward": "trust, expanded autonomy, pride currency from Greg"
    }
  ],
  "punished": [
    {
      "behavior": "emotional outbursts",
      "enforced_by": ["karen", "greg"],
      "cost": "anxiety spike in Karen, withdrawal of trust"
    }
  ]
}
```

**Edge enhancement** — add visibility and information flow:
```json
"edges": [
  {
    "from": "self", "to": "greg",
    "warmth": 0.5, "conflict": 0.1, "attachment": 0.55,
    "obligation": 0.8, "resentment": 0.1,
    "visibility": "high — sees Greg daily",
    "information_flow": "indirect — learns about school through Karen"
  }
]
```

### 7. Codex Directory Structure

```
codex/
  README.md
  chronicle.md
  characters/
    README.md
    *.md
  psychology/
    README.md
    portrait.md
  world/
    README.md
    places/
      README.md
      *.md
    events/
      README.md
      *.md
    institutions/
      README.md
      *.md
```

### 8. Orchestrator Update

Revise turn protocol:

1. **Read state** — unchanged
2. **Interpret + validate** — unchanged
3. **Social processing** — delegate to network agent when the action involves people. Pass: action summary, current network.json. Receive: updated network state, consequence narrative.
4. **Update state** — write state files including network updates. If inflection point crossed: create snapshot, then delegate synthesis to codex agent.
5. **Generate** — produce narrative informed by consequence summary

Add reference to subagent invocation patterns and what context each agent needs.

### 9. Drew-1993 Migration

- Move `plano-tx.md` → `world/places/plano-tx.md`
- Create event entries from chronicle + generation.json:
  - `world/events/oklahoma-city-bombing.md`
  - `world/events/plano-heroin-epidemic.md`
  - `world/events/columbine.md`
  - `world/events/september-11.md`
  - `world/events/alcatel-restructuring.md`
- Create institution entries:
  - `world/institutions/mendenhall-elementary.md`
  - `world/institutions/first-united-methodist.md`
  - `world/institutions/alcatel-telecom-corridor.md`
- Write all README indexes
- Migrate network.json to enhanced schema
- **Do NOT rewrite** chronicle, character entries, or psychology portrait

---

## Implementation Order

1. CLAUDE.md — engine vs. project distinction
2. Codex style guide — `reference/codex-style.md`
3. Synthesis protocol — `reference/synthesis.md`
4. Codex agent — `.claude/agents/codex-agent.md`
5. Network agent — `.claude/agents/network-agent.md`
6. SKILL.md + birth.md + exit.md updates
7. Orchestrator update — subagent delegation in turn protocol
8. Project docs — architecture.md, schemas.md, state.md, README.md
9. Drew-1993 migration — codex restructure, world entries, network migration
10. Requirements — check off completed items

## Verification

- Browse drew-1993 codex: README indexes make everything discoverable
- Read enhanced network.json: gatekeepers, normative pressure, edges carry enough info for the network agent
- Read codex-agent.md + network-agent.md: clear responsibilities, focused context, correct model routing
- Read orchestrator.md: delegation points are explicit, turn protocol flows cleanly
- Read reference docs from cold start: codex-style.md + synthesis.md are self-contained
- End-to-end test next session: advance Drew into middle school, trigger synthesis at identity consolidation, verify social dynamics shape events
