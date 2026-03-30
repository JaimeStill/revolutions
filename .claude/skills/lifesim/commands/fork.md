# Fork — Promote an Existing Character to Their Own Simulation

Take a character who exists in an active simulation's network, promote them to protagonist, and initialize a new simulation instance from their perspective.

## What Fork Does

Fork is a transformation operation. It takes an existing character — someone with a generated profile in `state/characters/`, a network node, possibly codex entries — and creates a new simulation instance where that character is the protagonist. The world is shared. The network is rebuilt from their vantage point. The timeline may be aligned with the source simulation or offset to a different moment.

## Process

### 1. Select the Source

The player specifies which character to fork and from which instance. The character must exist in the source instance's network.

```
/lifesim fork drew-1993 connor
```

If no instance is specified and a simulation is active, use the active instance. If no character is specified, list available network nodes and let the player choose.

### 2. Load the Character

Read the character's existing data from the source instance:

- **Generated profile** (`state/characters/<id>.json`) — if one exists, this is the primary source. It contains a full seven-layer psychological profile.
- **Network node** (`state/network.json`) — the character's description, role, and alive status.
- **Network edges** — all edges involving this character, which will be inverted (edges *to* this character become edges *from* self; edges *from* this character become edges *to* other nodes).
- **Codex entry** (`codex/characters/<id>.md`) — the literary portrait, which captures how the protagonist perceived this character. Useful as a starting point but will need perspective-shifting.

If no generated profile exists, fork invokes birth in character scope first to generate one from the available data (node description, codex entry, world context, relationship edges).

### 3. Collaborative Session

Brief conversation with the player to establish fork parameters:

- **Timeline position** — fork at the source simulation's current moment? At an earlier point? At a later point that requires world-state extrapolation?
- **Backstory resolution** — same three options as birth (emergent, established, sparse). For a forked character, emergent is the natural default: the source simulation established some facts about this person, but their interior life is largely unknown to the player.
- **What's known vs. what's open** — the source simulation may have established specific facts about this character (Connor skates, Connor drifted from Drew, Connor is at the skater table). These are constraints. Everything else is open for discovery.
- **World divergence** — does the forked instance share exact world state with the source, or does it diverge? A fork at the same moment in the same world shares period.md, society.json, and generation.json exactly. A fork that jumps forward in time may need world-state updates.

### 4. Transform the Profile

Promote the character's generated profile (or newly created one) to protagonist format:

- **individual.json** — the character's profile becomes the instance's primary psychological state. If the profile was generated at lower resolution than a protagonist typically has, the collaborative session fills in depth where needed.
- **Backstory fields** — populated or left sparse based on the backstory resolution parameter. The forming_context fields may reference events from the source simulation (Connor witnessed the same Columbine drills Drew did) but filtered through this character's experience rather than the source protagonist's.

### 5. Rebuild the Network

The network is reconstructed from the forked character's perspective:

- **Self becomes the forked character.** All edges are inverted: `from: "self", to: "drew"` replaces `from: "self", to: "connor"` in the source.
- **The source protagonist becomes a node.** They exist in the forked character's network — the relationship looks different from this side. The edge values may be adjusted during the collaborative session to reflect the forked character's perspective.
- **Shared nodes persist with perspective shift.** Characters who exist in both networks (teachers, shared peers, community figures) carry over, but their descriptions and edge values reflect the forked character's relationship to them rather than the source protagonist's.
- **New nodes emerge.** The forked character's world includes people the source protagonist never met — the skater table kids, a different family, whoever populates the spaces the source protagonist doesn't occupy. These may be generated during the collaborative session or left for emergent discovery.
- **Gatekeepers and normative pressure recalibrate.** The forked character's gatekeeper structure and the behaviors their world rewards and punishes may differ substantially from the source protagonist's, even in the same community.

### 6. Copy and Adapt World State

- **`period.md`** — copied from source. The world is the same world. If the fork's timeline position differs from the source, the world agent may need to extend or adjust the possibility space.
- **`society.json`** — copied from source. Same structural facts.
- **`generation.json`** — copied from source if same birth cohort. If the forked character is from a different generation, generate new cohort data.

### 7. Initialize Timeline

Set timeline.json to the fork point. Inflection points passed reflect the forked character's developmental history, not the source protagonist's.

### 8. Generate the First Scene

Write `state/scene.md` from the forked character's perspective. The same moment the source protagonist experiences one way, the forked character might experience completely differently — a different location, a different concern, a different relationship demanding attention.

### 9. Snapshot and Codex

Create `state/snapshots/turn-0-fork-from-<source>/`. Initialize the codex structure. The chronicle starts fresh — this is a new perspective on a shared world, not a continuation of the source narrative.

### 10. Name and Activate

Suggest a name based on the character and source (`connor-2007-fork`, `connor-plano`). Validate uniqueness. Create the instance directory. Write `sim/.active`.

### 11. Present the Opening

Standard orientation and first scene. The simulation is active and operates in the three-phase turn cycle.

## What Fork Preserves

- World state (period, society, generation) — the world is shared
- The forked character's generated psychological profile — promoted to protagonist resolution
- Established facts about the character from the source simulation
- Network nodes that exist in both worlds — with perspective-shifted descriptions and edge values

## What Fork Does Not Preserve

- The source protagonist's internal state — their schemas are irrelevant to the forked character's simulation
- The source narrative — the chronicle starts empty
- The source's active threads — the forked character's pending threads are their own
- Edge values from the source protagonist's perspective — the forked character's warmth toward the source protagonist is their own number, not the inverse of the source's

## Relationship Between Instances

Forked instances are independent after creation. They share a world origin but diverge freely. The source simulation is not modified by the fork.

Future work (multi-perspective world simulation): forked instances that share a timeline position could be reconciled — events in one instance constrain events in the other when their networks overlap. This requires a coordination layer that does not yet exist.
