# Next Session: Playtest — Chronicle Migration, Editor Agent, Birth/Fork Architecture

## Context

Session 10 was a major architectural session with four additions:

1. **Chronicle directory migration** — `codex/chronicle.md` split into `codex/chronicle/` with indexed chapter files (`01-the-absorbent-years.md` through `06-carols-kitchen.md` + README index). All engine files, documentation, and the drew-1993 instance updated. The load command now reads the chronicle index + recent chapters instead of the entire file.

2. **Editor agent** — new domain agent at `.claude/agents/domain/editor-agent.md`. Runs after the codex agent during synthesis passes (inflection points and session exits). Reviews codex output for literary quality (anti-patterns, economy, earned moments), voice consistency with existing entries, and factual accuracy against state files. Writes corrections directly to `codex/`.

3. **Parameterized birth + fork command** — birth.md rewritten with three parameters:
   - **Scope**: protagonist (full instance) or character (non-protagonist profile generation)
   - **Entry point**: age 0 through late life — late-start entries populate all layers appropriate to the entry age
   - **Backstory resolution**: emergent (default), established (fully specified), or sparse (minimal — maximizes retroactive discovery)

   Fork command (`fork.md`) promotes a network character to their own simulation instance — shared world, inverted network, independent after creation. Character profiles stored in `state/characters/<id>.json`.

4. **Narrative vision** — `.claude/project/narrative-vision.md` captures the post-death continuation design. Development reference only — the engine never sees it. The no-anticipation constraint is absolute: the engine must never telegraph what comes after death. When Drew's life reaches that point, a dedicated alignment session will prepare the engine.

## Playtest Notes (for the human)

Run the drew-1993 simulation. Drew is 14, early October 2007. The Carol kitchen scene just committed — Drew said the full sentence ("I want to do this again every day for as long as you will have me") and Carol reflected the true version back to him. The identity consolidation inflection is active. Sofia and the courtyard lunches are the live thread.

Things to pay attention to:

- **Chronicle directory loading** — does `/lifesim load` correctly read the chronicle index and recent chapters? Does the story-so-far summary feel complete without loading the entire chronicle?
- **Editor agent's first pass** — the editor will run whenever the next synthesis fires (inflection point crystallization or session exit). Does it catch real issues? Does it improve quality? Or does it create friction by over-correcting?
- **Persona delegation quality** — continuing from last session's observation. Carol's kitchen scene worked well with persona delegation. Watch for the same quality when Sofia appears next, and when any relationship events surface during compression.
- **Pivotal moment recognition** — the identity consolidation inflection is active. Does the orchestrator correctly identify when moments meet all three criteria (irreversibility, trade-off, multi-domain tension)?
- **Relationship events during compression** — if the simulation compresses time, do relationship events surface? Are the candidates well-chosen?
- **Character profile need** — watch whether persona embodiment feels sufficiently deep without `state/characters/<id>.json` profiles. If characters feel thin or inconsistent, generating profiles is the tuning lever.

## Development Work Queued (after playtest resolves)

### Editor Agent Tuning
First real test happens during this playtest's synthesis passes. May need:
- Calibration of what counts as a "correction" vs. a style preference
- Adjustment of how aggressively it revises vs. flags
- Assessment of whether it adds enough value to justify the processing cost

### Character Profile Generation (conditional)
If persona embodiment feels thin during playtest, generate `state/characters/<id>.json` profiles for well-established characters (Carol, Marcus, Sofia as first candidates). The birth command's character scope is the mechanism — it would be the first real use of that capability.

### Remaining Requirements
Unchecked items in requirements.md:
- Ancestry mechanics (stubs, retroactive resolution, self-concept integration)
- AI/hybrid player modes
- Snapshot rewinding (depends on world simulation architecture)
- World simulation beyond single character
- Non-historical birth validation
- Multi-perspective coordination (forked instances sharing a timeline)
- Infrastructure (Bun, GitHub Pages)

## Definition of Done (for the dev session after playtest)

- Playtest observations reviewed against new mechanics
- Chronicle directory loading assessed — any context efficiency issues?
- Editor agent quality assessed — does it improve codex output?
- Persona depth evaluated — do characters need generated profiles?
- Friction points categorized (architectural vs. tuning vs. instruction wording)
- Adjustments implemented based on findings
- Requirements.md updated
