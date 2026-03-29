# Session: Mechanics Refinement

## Context

Playtest session 3 (drew-1993, age 14) surfaced four issues with how the engine handles narration, events, and state checkpointing. All fixes are markdown instruction changes — no new agents, no schema changes, no new commands.

## Changes

### 1. Load Summary Narration
**File:** `.claude/skills/lifesim/commands/load.md`

Rewrite steps 3 and 5:
- Step 3 becomes "read and internalize state files" (context loading, not presentation)
- Step 5 gets explicit style guidance: the orientation reads like catching a friend up on a game. Conversational, specific, informational. Anti-pattern: no engine prose ("Three years of building have made him into something"). Use chronicle as story-so-far source. Hit: who this person is, what's happened, who matters, what's unresolved. Then transition into the current scene.

### 2. Relationship Events
**Files:** `.claude/project/simulation.md`, `.claude/agents/orchestrator.md`

New mechanic for lighter character interactions during time compression:
- **simulation.md** — new "Relationship Events" section after Event Types. Defines: when they fire (compression periods, neglected high-warmth/attachment edges), what they are (naturalistic moments, not crises), how they flow through the turn cycle (same three phases, lower stakes, network agent processes, psychology agent only if significance threshold crossed), what they are not (not inflection points, no snapshots, no codex synthesis).
- **orchestrator.md** — new subsection in Pacing. Before compressing through years, check network.json for characters with high warmth/attachment who haven't appeared in scenes. Insert 1-2 relationship events per compression period. Select for narrative potential, not exhaustiveness. Orchestrator voices characters from codex entries and network state — no new subagent needed yet.

### 3. Event Presentation Principle
**File:** `.claude/agents/orchestrator.md`

New section after Pacing:
- **Presence test:** Would the protagonist have been there? If yes → scene. If no → information arriving through a specific network channel.
- **Network events slow compression:** Significant events involving network characters that the protagonist would witness get presented as scenes, not reported after the fact.
- **Significance test:** If the event would change a relationship dynamic (warmth, conflict, attachment, gatekeeper stance), it's significant enough to be a scene.
- **Prevents:** Off-screen events like the Kyle Briggs scenario that the player should have experienced directly.

### 4. Inflection Point Recognition
**File:** `.claude/agents/orchestrator.md`

Expand commit sequence step 5:
- Inflection points crystallize over a series of moments — they're not binary thresholds. The orchestrator should recognize the crystallizing moment (the point of no return) and snapshot there.
- Test: "Has the character done something irreversible that sets the terms for how this inflection resolves?"
- Add coordination note that session-exit snapshots are handled by `/lifesim exit`.

### 5. Requirements Update
**File:** `.claude/project/requirements.md`

Add under new "Relationship Mechanics" section or fold into existing structure:
- Relationship events during time compression
- Orchestrator weaves relationship scenes into compression pacing
- Event presentation principle (scenes vs. reports based on presence)
- Load summary conversational briefing style

## Implementation Order

1. `load.md` (standalone)
2. `simulation.md` (defines the mechanic)
3. `orchestrator.md` (references simulation.md, adds all three orchestrator changes together)
4. `requirements.md` (documents what was added)

## Verification

Playtest validation. Definition of done for this session: all mechanics encoded, internally consistent across documents, requirements updated, ready for next playtest.
