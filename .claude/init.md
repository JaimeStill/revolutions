# Next Session: State History Architecture + Continue Drew's Playtest

## Context

First playtest session with `drew-1993` (Plano, TX, born November 1993). Birth, absorbent years, and two advances completed. Drew is 11 years old, May 2004, end of fifth grade, about to enter middle school. The simulation is paused at the edge of the identity consolidation inflection point.

## Critical Design Issue: State Mutation

**State files must not be overwritten — they must evolve with history preserved.**

During this session, state files (individual.json, network.json, timeline.json, scene.md) were overwritten in place as the simulation advanced. This destroys narrative history. The simulation needs to preserve every version of state so the full arc of a life can be reconstructed.

**Current interim approach:** Snapshot-based. Previous state versions are stored in `archive/snapshots/turn-{N}-{label}/` before the current state files are updated. The `state/` directory always contains the latest version. Two snapshots exist for `drew-1993`:
- `archive/snapshots/turn-0-birth/` — original birth state (age 0, 1993)
- `archive/snapshots/turn-1-agency-threshold/` — post-absorbent-years state (age 8, 2001)
- `state/` — current state (age 11, 2004)

**This needs a proper architectural decision.** The snapshot approach works but was implemented ad-hoc. Next session should resolve the state history mechanism formally and document it in project.md. Options discussed:
1. **Snapshot-based** — copy full state to `archive/snapshots/turn-{N}/` before each mutation. Simple, full reconstruction possible, but duplicates data.
2. **Append-only state** — state files contain their own history (scene.md accumulates, JSON files include changelogs). Simple reads for history, but files grow and slow down engine reads.
3. **Split current + deltas** — `state/` is current (fast reads), `log/state-deltas.jsonl` captures every mutation. Compact, but reconstruction requires replaying deltas.

No decision made yet. Resolve in next session.

## Key Findings This Session

### 1. The Agency Gap (Resolved in Architecture)

Birth should auto-narrate the absorbent years (0–7) as compressed summary, forming attachment style and early schemas, then hand control to the player at the agency threshold (~age 7-9). Grounded in Montessori, Piaget, Erikson, Bowlby, and brainwave development research. Birth command needs updating to implement this.

### 2. Interaction Model: Discussion vs. Prose (Added to Architecture)

Two modes: `discussion` (co-authoring through conversation) and `prose` (in-character scene responses). The engine detects which mode is active from tone. Documented in project.md under "Interaction Model." Config supports `interaction_model` and `player_intention` fields.

### 3. Presentation Layer: State Files ≠ Player Output (Added to Architecture)

State files are for the engine. The player sees narrative prose with a human-readable summary of what changed. Never show JSON, file paths, or schema field names as primary output. Documented in project.md under "Presentation Layer."

### 4. `/lifesim exit` Sub-Command (Created)

New sub-command that saves all state, writes a session summary to `log/sessions.jsonl`, updates init.md, commits, and pushes. Located at `.claude/skills/lifesim/commands/exit.md`. Added to SKILL.md routing table and project.md skills table.

### 5. State History Preservation (Open — See Above)

State files must preserve history, not overwrite. Interim snapshot approach in place. Needs formal architectural decision.

## Active Instance State: drew-1993

Drew Mitchell, age 11, May 2004, Plano TX. End of fifth grade, summer ahead, middle school in the fall.

- **Attachment:** Secure with anxious undertone. Stable — Karen remains primary, Nana Carol is the deepening secondary bond.
- **Schemas:** Emotional inhibition (channels feelings into productivity, defaults to "I'm fine") + self-sacrifice (measures worth by usefulness, decided post-9/11 to be the kid who doesn't add to the burden).
- **Organizing principle:** Competence as security. Drew fixes things, builds things, reads voraciously. He's genuinely skilled for his age — gardens with Nana Carol, maintains the house, teaches himself how the internet works.
- **Values forming:** Security, benevolence, self-direction, achievement (in that order).
- **Self-concept:** "I am someone who figures things out."
- **Key relationships:** Nana Carol (deepest bond, intellectual and practical partner), Karen (warm, slightly less central as Drew becomes more independent), Greg (earns trust through competence, still emotionally distant), Megan (14, pulling away, implicit benchmark), Connor (best friend but drifting — different interests emerging), Kyle Briggs (bully who tested Drew twice, moved on when Drew didn't react).
- **What's coming:** Middle school. The social rules that made Drew solid at Mendenhall don't map onto Jasper's hierarchy of status, humor, athletics, and social fluency. Drew's quiet competence doesn't have a clear category there. The identity consolidation inflection point is approaching.
- **Player intention:** "Retroactive wisdom" — approaching Drew's life as an opportunity to explore what they would have done differently with adult perspective and discipline.

## What to Work On

1. **Resolve state history architecture** — pick an approach, document in project.md, implement in orchestrator/exit commands
2. **Continue the playtest** — advance Drew into middle school (the identity consolidation inflection point). Test the transition from competence-in-safe-spaces to competence-under-social-pressure.
3. **Update birth command** — implement auto-narration of absorbent years
4. **Update orchestrator agent** — encode presentation layer rules and interaction model detection
5. **Test `/lifesim exit`** — run the full exit flow (save, summarize, commit, push)
6. **Test remaining sub-commands** — `/lifesim load`, `/lifesim profile`, `/lifesim compress`

## What's Working

- Birth command generates rich, specific, historically grounded worlds
- Narrative quality is strong — the Plano setting feels real and textured
- Absorbent years compression works well
- Discussion interaction model feels natural
- Player intention adds meaningful depth
- Snapshot-based state history (interim) preserves previous versions

## What's Not Yet Tested

- Turn processing across multiple sequential turns
- `/lifesim load` (session resume)
- `/lifesim exit` (save, commit, push)
- `/lifesim profile` (psychological portrait)
- Compaction hooks
- Prose interaction mode
- State history reconstruction from snapshots
