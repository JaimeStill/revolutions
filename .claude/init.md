# Next Session: Playtest — Persona Delegation + Pivotal Moments

## Context

Session 8 addressed the two main findings from the previous playtest:

1. **Persona delegation expanded** — no longer scoped exclusively to relationship events during compression. The orchestrator now uses a general **participant test**: "Will the player interact with this character across multiple beats, and does the character's own perspective matter?" This covers relationship events, pivotal moments, and any scene where the narrative becomes a dialogue. Character Embodiment is now a standalone section in the orchestrator with the relay loop described once.

2. **Pivotal moments designed and implemented** — an intensification of the standard three-phase cycle, triggered when three criteria all hold: irreversibility imminent, real trade-off exists, multiple domains in tension. Scene phase heightens specificity. Discussion phase tightens (no vague resolutions, consequences surfaced before commit, persona stays active). Commit phase amplifies (broad delegation, agents calibrate significance higher, world agent asked broader question about world tensions). Full craft guidance in `events.md`.

## Playtest Notes (for the human)

Run the drew-1993 simulation. Drew is 14, second day of eighth grade. Sofia invited him to lunch tomorrow. Marcus knows.

Things to pay attention to:

- **Persona delegation firing** — when Drew and Sofia interact (the next courtyard lunch, any scene where she's present), does the orchestrator invoke the persona agent? Does Sofia feel like a person with her own reasoning, or is she still the orchestrator wearing a mask?
- **Participant test boundary** — does the orchestrator correctly distinguish between scenes where Sofia is a participant (lunch conversation, direct interaction) vs. where she's mentioned in narration? The persona agent should NOT fire for every mention of Sofia — only when the player will interact with her directly.
- **Pivotal moment recognition** — the three criteria (irreversibility, trade-off, multi-domain tension) should trigger during high-stakes scenes. Does the orchestrator intensify correctly? Does discussion tighten? Are consequences surfaced before commit?
- **Discussion phase pressure** — during pivotal moments, the orchestrator should press for specificity and not accept vague resolutions. Does this feel like productive pressure or annoying railroading?
- **Relationship events during compression** — if the simulation compresses time, do relationship events surface with family (Carol, Karen, Greg) using persona delegation?
- **Consequence amplification** — do pivotal moment commits produce proportionally larger state changes? Check `individual.json` and `network.json` deltas after pivotal commits vs. routine ones.

## Development Work Queued (after playtest resolves)

### Persona Agent Quality Tuning

The scoping fix was the critical change — the persona agent should now actually fire. But once it fires, playtest will reveal quality questions:
- Do characters sound distinct from each other and from the orchestrator's narrative voice?
- Is the persona context (codex entry + network node/edge + scene) sufficient?
- Does the relay loop feel natural or does orchestrator mediation create friction?
- How does the persona handle pivotal moment pressure vs. relationship event casualness?

### Remaining Requirements

The unchecked items in requirements.md are mostly deferred/future work:
- Ancestry mechanics (stubs, retroactive resolution, self-concept integration)
- AI/hybrid player modes
- Snapshot rewinding (depends on world simulation architecture)
- World simulation beyond single character
- Non-historical birth validation
- Infrastructure (Bun, GitHub Pages)

### Hook Utility (carried)

Still deferred. Only add hooks if a real need emerges during playtest.

## Definition of Done (for the dev session after playtest)

- Playtest observations reviewed against new mechanics
- Persona agent quality assessed — does it produce better characters than orchestrator voicing?
- Pivotal moment trigger accuracy evaluated — false positives? false negatives?
- Friction points categorized (architectural vs. tuning vs. instruction wording)
- Adjustments implemented based on findings
- Requirements.md updated
