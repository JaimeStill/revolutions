# Session: Prose Voice Tuning

## Context

Playtest of drew-1993 (session 11, age 14, the concert) was solid — no mechanical issues, good pacing, persona delegation working. One signal: the orchestrator's prose is too easily identifiable as AI. This is not about quality (the writing is emotionally resonant and structurally sound) but about voice signature — recurring tics that mark the prose as machine-generated to a reader who knows what to look for.

## The Problem: AI Prose Fingerprints

Reading the chronicle chapters (especially 06-carols-kitchen and 07-the-concert), I can catalog specific recurring patterns:

### 1. The "not X but Y" antithetical construction
Used constantly to define things by negation before affirmation:
- "not surprise, not pleasure exactly, but the careful registration of something"
- "not a wave, not a smile — a look"
- "not an event to be processed but a state to be inhabited"
- "Not a quick nod — a slow one, the kind that meant he was processing"
- "not the relief of surviving, but the beginning of knowing"

### 2. The psychological narrator track
Real-time commentary explaining what every gesture means. The narrator acts as a therapist annotating the scene rather than trusting the reader:
- "It was the self-sacrifice schema talking, wrapping a genuine anxiety in the logic of someone else's burden"
- "the crossing was deliberate — not rushed, not casual, but the movement of someone who had decided where she was going before she entered the room"
- "She was not asking him to watch a performance. She was asking him to step into the world she went home to."

### 3. The "the way" connective
Used as filler to bridge a concrete detail to its interpretation:
- "the way she said most things"
- "the way Marcus looked at a piece of code that had an obvious solution"
- "the way truths had been coming out of him lately"
- "the way you feel a change in barometric pressure"

### 4. "The particular/specific quality of"
Abstract filler phrase:
- "the particular quality of her attention"
- "the specific quality she could read"
- "the particular formality of young musicians"
- "the particular chaos of a school event winding down"

### 5. Excessive em-dash parentheticals explaining subtext
Nearly every paragraph has one or more em-dash asides that decode the subtext of what just happened:
- "the one with cracked vinyl that Karen had been threatening to throw out since the summer"
- "the Christian station she listened to when she was thinking"
These range from good (texture) to bad (over-explanation). The problem is density, not the device itself.

### 6. Thematic callback chains
Every new scene moment is immediately linked to previous scenes, creating a closed loop of self-reference:
- "Not the same as the courtyard's 'I want — that. Yeah.' Not the adrenaline-driven version. It was closer to what had happened at Carol's"
- "The letter had been a leap. The courtyard had been a catch. Carol's kitchen had been a mirror. The concert lobby had been something else"

### 7. The narrator always knows
No ambiguity, no narrative uncertainty. Every moment's significance is identified and explained. Real literary fiction has moments where the prose doesn't fully understand what's happening — the reader feels the meaning before the narrator names it.

### 8. Rhythmic monotony
Paragraphs follow the same arc: concrete detail → interpretation → significance. Sentence lengths cluster in the medium-long range. Few short, declarative sentences. Few genuinely long, flowing ones. Everything sits in the same comfortable middle.

### 9. Register of exhaustive significance
Nothing is allowed to be merely what it is. Every gesture, word choice, silence, and physical detail is decoded. Real life and real fiction have waste — moments that resist interpretation, details that are just details.

## What to Change

### File 1: `codex-style.md` — Anti-pattern catalog with examples
The style guide already has anti-patterns but they're abstract. Add a concrete section with before/after examples drawn from the actual patterns above. This is the shared reference that both the codex agent and editor agent load.

### File 2: `orchestrator.md` — Scene voice guidance
The orchestrator renders the prose the player actually reads during play. Currently has almost nothing about prose voice — just "render a life unfolding" and "end with a moment that invites response." Add a focused section on scene prose voice with the same anti-pattern awareness, adapted for live narration (which is different from codex composition — it's immediate, present-tense-feeling, and needs to leave room for the player to interpret).

### File 3: `editor-agent.md` — Specific pattern detection
The editor's review dimensions are right but generic. Add the specific AI-voice patterns to its literary quality review so it can catch them during synthesis passes.

### File 4: `codex-agent.md` — Reinforcement
Brief addition reminding the codex agent to check its own output against the anti-pattern catalog before finalizing. The style guide does the heavy lifting; this is a pointer.

## Approach

The core work is in `codex-style.md` — building a detailed, example-rich anti-pattern section that names the specific AI prose fingerprints and shows what the alternative looks like. The other three files point to or reinforce that catalog.

The goal is not to make the prose "less good" but to make it less predictable — more varied in rhythm, more willing to let moments land without interpretation, more trusting of the reader, and less structurally uniform.

## Verification

No automated tests — this is instruction tuning. Verification happens in the next playtest. The init.md should note what to watch for: whether the prose patterns have shifted, whether the writing feels less patterned, and whether anything was lost in the process.
