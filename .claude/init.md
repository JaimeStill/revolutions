# Next Session: Playtest — Prose Voice Tuning + Extended Arc

## Context

Session 12 was a focused tuning session targeting AI-identifiable prose patterns. Four files updated:

1. **`codex-style.md`** — Anti-patterns section restructured into structural anti-patterns and a new AI voice fingerprints catalog. Nine specific patterns named with examples from the drew-1993 chronicle and concrete fix guidance: the "not X but Y" antithetical, the psychological narrator, "the way" connective, "the particular quality of," excessive em-dash parentheticals, thematic callback chains, omniscient narrator of significance, rhythmic monotony, exhaustive significance.

2. **`orchestrator.md`** — New Voice block in Phase 1: Scene. Six principles: show don't decode, trust the reader, vary rhythm, let details be details, resist the retrospective, end on image not insight. Pointer to the style guide's anti-pattern catalog.

3. **`editor-agent.md`** — Literary quality review now includes specific AI voice fingerprints to check for, with the six most damaging patterns named.

4. **`codex-agent.md`** — Verify step now references the full anti-pattern catalog and prompts self-audit.

## Playtest Notes (for the human)

Run the drew-1993 simulation for an extended arc. Drew is 14, late October 2007. The concert and Reyes lobby just happened. Identity consolidation is the active inflection. Push through a significant stretch of Drew's life — the goal is to see how the engine performs across different scene types, pacing modes, and developmental stages, not just a single moment.

Things to pay attention to:

- **Prose voice** — the primary target. Does the orchestrator's scene prose feel less patterned? Less decoded? Does the narrator trust you more? Are there moments that land on an image instead of an insight? Is there rhythmic variety?
- **Overcorrection risk** — did the anti-patterns flatten the prose? The drew-1993 writing was emotionally resonant and psychologically rich. If scenes feel sparse, dry, or tentative, the tuning went too far.
- **Voice across scene types** — does the improvement hold across relationship events, pivotal moments, time compression narration, and routine scenes? Or does it only work in one mode?
- **Editor agent** — when synthesis fires, does the editor catch AI voice patterns? Does it improve the codex output without over-correcting?
- **Higher-level engine observations** — pacing, delegation quality, persona embodiment, event selection during compression. General notes on what feels right and what doesn't across a longer arc.

## Development Work Queued (after playtest resolves)

### Voice Tuning Iteration (conditional)
If the prose voice didn't shift enough, or overcorrected:
- May need reference prose passages in the style guide (exemplars, not just anti-patterns)
- May need a "voice palette" the orchestrator loads at session start
- May need softening of specific anti-pattern entries

### Character Profile Generation (conditional)
If persona embodiment feels thin during extended play, generate `state/characters/<id>.json` profiles for established characters.

### Editor Agent Tuning (conditional)
First extended test of the editor during synthesis. May need calibration.

### Remaining Requirements
- Ancestry mechanics
- AI/hybrid player modes
- Snapshot rewinding
- World simulation beyond single character
- Non-historical birth validation
- Multi-perspective coordination
- Infrastructure (Bun, GitHub Pages)

## Definition of Done (for the dev session after playtest)

- Extended playtest observations reviewed
- Prose voice shift assessed: did the anti-pattern catalog land?
- Overcorrection check: is the prose still rich, or did it go flat?
- Higher-level engine feedback categorized (architectural vs. tuning vs. instruction wording)
- Adjustments implemented based on findings
- Requirements.md updated if new items emerged
