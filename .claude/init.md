# Next Session: Playtest + Pivotal Moment / Persona Agent Design

## Context

Session 6 added three runtime mechanics to the engine:

1. **Load narration** — `load.md` now instructs the orchestrator to present a conversational briefing (like catching a friend up on a game) instead of engine prose. Chronicle is the primary source.
2. **Relationship events** — the orchestrator now inserts 1-2 naturalistic character interaction scenes during time compression, targeting network characters with high warmth/attachment who haven't had recent screen time. Craft guidance lives in `.claude/skills/lifesim/reference/events.md`.
3. **Event presentation** — the orchestrator applies a presence test: if the protagonist would have been there, present it as a scene; if not, present information arriving through a specific network channel. Significant network events slow compression.
4. **Persona agent** — a new actor subagent (`agents/actors/persona-agent.md`) that embodies characters during events. The player interacts with the character directly; the orchestrator relays transparently and only interjects for scene transitions or when the player addresses the orchestrator. Agent directory reorganized into `domain/` (state processors) and `actors/` (character performers).

Additionally: inflection point recognition was refined — the orchestrator now looks for the crystallizing moment (point of no return) rather than treating inflection points as binary thresholds.

The iterative-dev pre-commit review was also updated with a new step (6b) for reconciling simulation state against engine changes.

## Playtest Notes (for the human)

Run the drew-1993 simulation. Drew is 14, first day of eighth grade, just delivered a letter to Sofia Reyes.

Things to pay attention to:
- **Load narration** — does the orientation read like a friend catching you up, or does it still sound like engine prose?
- **Relationship events** — when the simulation compresses time, does the orchestrator insert moments with family or other neglected characters? Do they feel naturalistic or forced?
- **Event presentation** — if a significant event involving a network character happens, does the orchestrator apply the presence test correctly? Does it present the event as a scene when Drew would be there?
- **Inflection point recognition** — Drew is approaching identity consolidation. Does the orchestrator recognize the crystallizing moment when it arrives?
- **Persona agent** — when the orchestrator delegates to the persona agent during events, does the character feel like a real person? Does the relay loop (orchestrator → persona → player → persona) feel natural or stilted? Does the player know when they're talking to a character vs. the orchestrator?

## Development Work Queued (after playtest resolves)

### Primary: Pivotal Moment Mechanics

The five unchecked requirements under Event Mechanics are all pivotal-moment items. The placeholder in `events.md` is waiting for this design. Key questions:
- What triggers the shift from routine pacing to pivotal mode?
- How does the three-phase cycle behave differently under pressure?
- How do world events emerge organically at narrative climaxes?
- How do consequences amplify?

### Secondary: Persona Agent Tuning

The persona agent is built and integrated. Playtest will reveal:
- Does the relay loop feel natural enough, or does the orchestrator mediation create friction?
- Do characters sound distinct from each other and from the orchestrator's narrative voice?
- Is the persona context (codex entry + network node/edge + scene) sufficient, or does the agent need more?
- Should the persona agent be used beyond relationship events — e.g., during pivotal moments where another character's agency matters?

### Tertiary: Evaluate Hook Utility

Carried from session 5. Only add hooks if a real need emerges.

## Future Vision (captured, not active)

- World simulation — full world perspective beyond single character
- Snapshot rewinding — depends on world simulation architecture
- Non-historical birth validation — after core mechanics stabilize
- Bun / GitHub Pages deployment — after state and codex schemas are stable

## Definition of Done (for the dev session after playtest)

- Playtest observations reviewed against new mechanics
- Friction points identified and categorized (architectural vs. tuning)
- Pivotal moment mechanics designed (trigger conditions, behavioral differences, consequence amplification)
- Persona agent tuned based on playtest feedback
- Requirements.md updated
- If designs are clear enough: implement
