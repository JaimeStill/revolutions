# Next Session: Playtest + Pivotal Moment Design

## Context

Session 5 refactored the engine into a three-phase turn cycle (Scene → Discussion → Commit) with dedicated domain agents (psychology, network, world, codex). Two new design principles were encoded: world-agnostic simulation and tonal sovereignty. Compaction hooks were retired — the 1M context window and stateless orchestrator model make them unnecessary for now.

The core interaction model is in place. What's missing: **pivotal moment mechanics** — the formalized engagement mode for how the simulation behaves when the character hits a moment of real consequence.

## Playtest Notes (for the human)

Run the drew-1993 simulation pure. Drew is 14, about to start eighth grade (August 2007). Identity consolidation inflection point is approaching.

Things to pay attention to:
- Does the three-phase cycle feel natural? Does the commit boundary emerge organically?
- Does the orchestrator stay in its coordination lane?
- Does the tonal register hold? Does the engine ever introduce something off-register?
- How does the discussion phase feel? Good rhythm between co-authoring and scene presentation?
- **When the simulation hits a moment that should be pivotal** — does it shift gears? Does it feel different? What's missing mechanically? What would make it feel like "roll for initiative" — that moment where you know the stakes just changed and every choice matters?

## Development Work Queued (after playtest resolves)

### Primary: Pivotal Moment Mechanics

Design and implement the engagement mode for pivotal moments:
- What triggers the shift from routine pacing to pivotal mode?
- How does the three-phase cycle behave differently during a pivotal moment? (Tighter discussion loops? Constraints on available actions? Time pressure? Forced trade-offs?)
- How do world events emerge organically at narrative climaxes — not scripted, but timed to the character's trajectory?
- How do consequences of pivotal moments propagate with outsized impact?

This is the next critical simulation component beyond the three-phase cycle itself.

### Secondary: Evaluate Hook Utility

Hooks were retired because compaction isn't an issue at 1M context. But hooks can do more than compaction recovery — automated behaviors, invariant enforcement, pre/post processing. Evaluate whether any simulation mechanics would benefit from hook-level automation. Don't force it; only add hooks if there's a real need.

## Future Vision (captured, not active)

These are directions discussed during the session 5 closeout. None are active development targets — they're here so they don't get lost:

- **World simulation** — expanding beyond single-character perspective to simulate the full world. Architecture TBD. Affects how snapshot rewinding and branching would work.
- **Snapshot rewinding** — depends on world simulation architecture decisions.
- **Non-historical birth validation** — test the world-building session with fantasy/sci-fi settings. After core mechanics stabilize.
- **Bun / GitHub Pages deployment** — bring the codex and simulation state to life as a deployed site. After state and codex schemas are stable and unlikely to change.

## Definition of Done (for the dev session after playtest)

- Playtest observations reviewed against simulation state and codex updates
- Friction points identified and categorized (architectural vs. tuning)
- Pivotal moment mechanics designed (at minimum: trigger conditions, behavioral differences, consequence amplification)
- Requirements.md updated with refined pivotal moment requirements
- If design is clear enough: implement the mechanics
