# Requirements

Capabilities the simulation needs, roughly ordered by dependency.

## Core Loop
- [x] Orchestrator agent coordinates the simulation
- [x] Three-phase turn cycle: Scene → Discussion → Commit
- [x] `/lifesim birth` initializes a character, world, and first formative event
- [x] `/lifesim load` resumes an existing simulation instance
- [x] State files persist to disk at commit time
- [x] Simulation instances are self-contained directories
- [x] Commit trigger is conversational — no explicit command

## Domain Architecture
- [x] Every state file has exactly one owning agent
- [x] Orchestrator owns coordination files only (scene.md, timeline.json)
- [x] Psychology agent owns individual.json
- [x] Network agent owns network.json
- [x] World agent owns world state (society.json, period.md, generation.json)
- [x] Codex agent owns codex/*
- [x] Editor agent reviews codex output for literary quality, voice consistency, and factual accuracy
- [x] Orchestrator delegates to affected domain agents at commit time

## Birth and Character Generation
- [x] Birth supports protagonist scope (full instance creation) and character scope (non-protagonist generation)
- [x] Birth supports any entry point — age 0 through late life
- [x] Late-start entries populate all layers appropriate to the entry age
- [x] Three backstory resolution modes: emergent, established, sparse
- [x] Sparse resolution enables reverse-inference — psychology agent proposes forming contexts during play
- [x] Generated character profiles stored in `state/characters/<id>.json`
- [x] Character scope callable by orchestrator, player, or fork command

## Fork
- [x] `/lifesim fork` promotes a network character to their own simulation
- [x] Fork transforms existing character data (profile, network node, codex entry) into protagonist format
- [x] Network edges inverted to the forked character's perspective
- [x] World state shared from source instance
- [x] Timeline and inflection points calibrated to the forked character's developmental history
- [x] Forked instances are independent after creation

## Event Mechanics
- [x] Relationship events during time compression — orchestrator selects neglected high-warmth/attachment characters
- [x] Relationship event pacing — 1-2 per compression period, woven into compression narrative
- [x] Event presentation principle — presence test determines scene vs. information channel
- [x] Network events slow compression when protagonist would be present
- [x] Event reference guide for craft guidance (`.claude/skills/lifesim/reference/events.md`)
- [x] Persona agent for character embodiment during events — player interacts with characters directly
- [x] Agent directory organized by role: domain (state processors) vs. actors (character performers)
- [x] Formalized engagement mode for pivotal moments — distinct from routine turn cycle
- [x] Mechanics for how pivotal moments play out (stakes, constraints, feedback loops)
- [x] Integration with three-phase cycle (how does discussion/commit behave during pivotal moments?)
- [x] World events that emerge at narrative climaxes — not scripted, but organically timed
- [x] Consequences of pivotal moments have outsized impact on state

## Psychological Engine
- [x] Psychology agent interprets psychological signals from committed actions
- [x] Seven-layer profile updates when significance threshold is crossed
- [x] Events target active psychological tensions
- [x] Formative event lifecycle pacing — compress between inflection points, slow at them

## World Simulation
- [x] World agent validates actions against period.md possibility space
- [x] World-building session at birth supports any setting (historical, fantasy, sci-fi, etc.)
- [x] Period.md captures tonal register alongside factual possibility space
- [x] Society and generation state inform event generation
- [x] Material conditions constrain what's possible

## Tonal Sovereignty
- [x] User sets the narrative register; engine maintains it
- [x] Orchestrator never originates tonal shifts
- [x] World agent validates tonal plausibility alongside factual plausibility
- [x] Tonal register can expand — only when user expands it

## Social Network
- [x] Relationship nodes and edges tracked in network.json
- [x] Social consequences propagate through the network
- [x] Gatekeepers control access to opportunity
- [x] Normative pressure affects decision costs

## State History
- [x] Snapshots capture full state at inflection points and session exits
- [x] Chronicle split into indexed chapter files for efficient context loading
- [ ] Simulation can be rewound to any snapshot point (deferred — depends on world simulation architecture)

## Codex
- [x] Synthesis pass generates codex at inflection transitions
- [x] Synthesis pass runs at session exit (if no inflection-triggered synthesis occurred)
- [x] Chronicle organized by developmental chapters in indexed directory
- [x] Codex entries for characters, world, and psychology
- [x] Codex agent receives domain agent summaries alongside state diffs
- [x] Editor agent reviews codex output before finalization

## Ancestry
- [ ] Ancestry stubs maintained
- [ ] Retroactive trait resolution based on expressed psychology
- [ ] Ancestry integrates with the character's self-concept narrative

## Player Modes
- [x] Human mode — player provides prose responses (default)
- [ ] AI mode — a subagent generates prose responses autonomously
- [ ] Hybrid mode — AI generates default, player can override
- [x] `/lifesim replay` reconstructs life narrative

## Session Continuity
- [x] `/lifesim load` uses conversational briefing style — catches player up like a friend, not engine prose
- [x] Inflection point recognition — orchestrator identifies crystallizing moments, not just binary thresholds

## Quality of Life
- [x] `/lifesim profile` renders a readable psychological portrait
- [x] Configurable parameters in instance `config.json` control fidelity
- [x] Session resume via `/lifesim load`
- [x] `/lifesim exit` saves state and commits

## Future Vision
- [ ] World simulation — full world perspective beyond single character (architecture TBD)
- [ ] Snapshot rewinding with branching (depends on world simulation decisions)
- [ ] Non-historical birth validation (after core mechanics stabilize)
- [ ] Multi-perspective coordination — forked instances sharing a timeline reconcile overlapping events
- [ ] Bun infrastructure / GitHub Pages deployment for codex and simulation state (after state and codex schemas are stable)
