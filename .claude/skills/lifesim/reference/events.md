# Event Guide

Two event mechanics shape how the simulation presents moments to the player: **relationship events** and **pivotal moments**. Both flow through the standard three-phase turn cycle but operate at different scales of intensity and consequence.

## Relationship Events

Relationship events are brief, naturalistic scenes that give the player direct interaction with network characters during time compression. They exist because compression without presence produces a simulation where the player knows people exist but has never been in a room with them.

### Selecting Candidates

Before compressing through a multi-year period, scan `network.json` for characters who:

- Have high warmth or attachment (above 0.5)
- Have direct visibility or information flow
- Have not appeared in a recent scene

Not every neglected character needs a scene. Select 1-2 per compression period based on **narrative potential** — which relationship has something unspoken in it? Which character is changing in ways the protagonist hasn't witnessed? Which connection would feel most alive if the player spent five minutes inside it?

Family members are the most common candidates because the simulation naturally gravitates toward peer and institutional scenes. A parent, sibling, or grandparent who exists in the network but never gets screen time becomes abstract — a name in a relationship graph. One dinner scene fixes that.

### Crafting the Scene

A relationship event is a moment, not a plot point. The scene should feel like something that actually happens in a life — unremarkable in structure, specific in texture.

**Good relationship events:**
- Greg and Drew in the garage. Greg is fixing something. Drew is holding a flashlight. They talk about nothing in particular, and then Greg says one sentence that lands differently than he intended.
- Karen driving Drew to a tournament. The radio is on. She asks a question that sounds casual but isn't. Drew's answer reveals something he didn't plan to share.
- Saturday at Nana Carol's. She's reading. Drew is on the porch. She says something about his grandfather that he's never heard before.
- Megan and Drew passing in the hallway at home. A three-sentence exchange that carries the weight of their entire sibling dynamic.

**What makes them work:**
- A specific physical setting with sensory detail
- Dialogue that sounds like the character, not like a theme delivery system
- Something small that shifts — not a revelation, but a moment where the relationship becomes slightly more visible to both people
- The player gets to respond — to say something back, to notice something, to make a small choice about how much to engage

**What to avoid:**
- Scenes that exist only to deliver exposition ("So, Drew, how's school going?")
- Characters who talk like therapists, articulating the relationship's dynamics
- Forced significance — not every moment needs to mean something. Some moments just exist, and the meaning comes later
- Treating the event as setup for a future plot point rather than a self-contained moment

### Persona Delegation

During relationship events, the orchestrator delegates character embodiment to the **persona agent** (`.claude/agents/actors/persona-agent.md`). The persona agent receives the character's codex entry, network node/edge, and scene context, then embodies that person for the duration of the interaction.

The player interacts with the persona agent's output directly — they are talking *to* the character, not reading about them. The orchestrator relays transparently between the player and the persona, only interjecting for scene transitions or when the player steps out of the interaction to ask the orchestrator a question.

This separation matters: the persona agent has a dedicated reasoning space to become one specific person. The orchestrator stays in its coordination lane. Each character gets the full weight of attention rather than being one of several voices the orchestrator juggles internally.

The persona agent's craft guidance — how to internalize a character, stay in character, and maintain physical presence — lives in its own agent file. The guidance below is for the orchestrator's side of the interaction: what makes a good candidate, how to construct the scene, and how the interaction flows.

### Constructing the Persona Context

When invoking the persona agent, the orchestrator assembles:

1. **Codex entry** — the character's literary portrait. This is the persona's deepest source for voice, attention, and blind spots.
2. **Network node** — the character's description and current state.
3. **Network edge** — the relationship to the protagonist: warmth, conflict, attachment, visibility, information flow. This determines what the character knows about the protagonist's life.
4. **Scene context** — where, when, what's happening, what just occurred. The physical and emotional setup.
5. **Interaction prompt** — what initiates the scene. Open-ended ("Greg and Drew are in the garage; Greg starts a conversation") or specific ("Sofia has read the letter and sees Drew in the hallway").

### Interaction Flow

The interaction follows a relay loop:

1. Orchestrator sets the stage and invokes the persona agent
2. Persona responds as the character
3. Orchestrator presents the persona's output to the player
4. Player responds (in-character to the person, or out-of-character to the orchestrator)
5. If in-character: orchestrator relays to persona agent (go to step 2)
6. If out-of-character: orchestrator handles directly, then resumes relay when the player returns

The loop continues until the interaction reaches a natural conclusion. The orchestrator recognizes closure and transitions to the commit phase.

### Pacing Integration

Relationship events sit inside time compression, not alongside it. The compression narrative flows, a relationship event surfaces as a scene, the player inhabits it through interaction with the persona, it commits, and compression resumes.

The rhythm should feel like memory — most of the years blur, but certain moments stand out in full resolution. The relationship events are those moments.

### Delegation at Commit

After the interaction closes:

- **Network agent** — always. The interaction may shift warmth, attachment, or information flow.
- **Psychology agent** — only if the interaction crosses the significance threshold. A pleasant dinner doesn't need psychological processing. A dinner where Greg says something that activates a schema does.
- **World agent** — almost never. Relationship events happen inside established spaces.
- **Codex agent** — never. Relationship events don't trigger synthesis.
- **Snapshots** — never. These are lightweight commits.

## Event Presentation

Events involving network characters must be presented based on the protagonist's proximity, not the engine's convenience.

### The Presence Test

When a significant event involves a network character, ask: *Would the protagonist have been there?*

- **Yes** — present it as a scene the player experiences directly. They see it, they're in it, they respond.
- **No, but they'd hear about it** — present it as information arriving through a specific channel. Not omniscient narration ("Meanwhile, Kyle Briggs got into a fight...") but a concrete moment of receiving the information: Marcus telling them at lunch, overhearing two people in the hallway, Karen mentioning it at dinner.
- **No, and they wouldn't know** — it happened off-screen and stays there. It may surface later through the network.

### Network Events Slow Compression

Even during time compression, if a significant event occurs involving a network character and the protagonist would have been present, slow down enough to present it as a scene. Do not skip past it and report it after the fact.

The significance test: if the event would change a relationship dynamic — warmth, conflict, attachment, gatekeeper stance — it warrants a scene when the protagonist is present.

### Information Channels

When the protagonist hears about something rather than witnessing it, the channel matters:

- **Who tells them** shapes how the information lands. Marcus telling Drew is peer-to-peer, unfiltered. Karen telling Drew is parent-to-child, likely edited. Overhearing is ambient, incomplete.
- **When they hear** affects what they can do about it. Learning in real-time vs. three days later produces different emotional and behavioral responses.
- **What gets distorted** in transmission. Information through the network is never pristine. Each relay point adds interpretation, omission, or emphasis.

The channel is not flavor — it's a simulation input. How the protagonist learns about something determines how they can respond, which determines what psychological and social consequences follow.

## Pivotal Moments

Pivotal moments are scenes of real consequence — moments where something irreversible is about to happen and every available path costs something. They are not a separate system. They are an intensification of the standard three-phase cycle, triggered by specific conditions and producing outsized consequences.

Most pivotal moments occur at or near developmental inflection points — that is where the simulation concentrates consequence. But the trigger is the criteria below, not proximity to a milestone. A pivotal moment could emerge mid-compression if a world event or network crisis creates the conditions.

### Trigger Conditions

A moment is pivotal when all three criteria hold:

1. **Irreversibility is imminent.** The protagonist is about to do — or is being forced to respond to — something that cannot be undone. Not "this is emotionally intense" but "after this, the terms change permanently." Sofia reading the letter changes what the relationship can become. Standing up to a bully changes the social map. Confessing something changes what another person knows forever.

2. **A real trade-off exists.** There is no costless option. Every available path sacrifices something the protagonist values. The psychology agent's values hierarchy becomes load-bearing — the player must choose which value to protect and which to spend. If the player can have everything they want without giving something up, it is not a pivotal moment.

3. **Multiple domains are in tension.** The moment engages psychology (values, schemas, defenses), network (relationships, social cost), and potentially world (plausibility, material consequences) simultaneously. A moment that is purely internal does not need pivotal treatment. A moment where the internal, social, and material stakes all intersect does.

If only one or two criteria are met, the orchestrator handles the scene as a normal inflection-point moment with standard treatment. All three must hold for pivotal intensification.

### Crafting the Scene

A pivotal moment scene makes the trade-off structure *felt* without naming it. The player should sense the weight before anyone articulates what is at stake.

**Good pivotal scenes:**
- Drew in the courtyard, Sofia responding to his letter. She says something that requires a real response — not a clever line, but an honest one. Drew's emotional inhibition schema is the easy path; genuine presence is the hard one. Both cost something.
- A confrontation with a parent where the protagonist can capitulate (preserving peace, sacrificing self-direction) or push back (preserving autonomy, risking the relationship). The parent is not a villain — they have their own reasons, their own fears.
- A moment where loyalty to a friend conflicts with honesty about what the protagonist wants. Marcus and Sofia occupy the same afternoon. Drew can be where he said he'd be or where he wants to be, but not both.

**What makes them work:**
- The stakes are visible through specificity, not through narration about stakes. The reader feels the trade-off because the details make both paths real.
- The other person in the scene has their own agency. This is where persona delegation matters most — the character responds in real time through the relay loop, creating pressure the orchestrator alone cannot produce.
- There is no obviously correct answer. If the player can identify the "right" choice without cost, the trade-off is not real.
- Time pressure — not artificial urgency, but the kind of pressure that comes from a person standing in front of you waiting for a response.

**What to avoid:**
- Narrating the stakes explicitly ("Drew knew this was a turning point...")
- Making one option clearly superior — if the trade-off has a correct answer, it is not a trade-off
- Melodrama that exceeds the register. A fourteen-year-old's pivotal moment feels like a fourteen-year-old's pivotal moment, not a film climax
- Removing the character's agency — the other person in a pivotal scene should be a person, not a prop

### Discussion Phase Behavior

Three changes to how discussion operates during pivotal moments:

**No easy exits.** The orchestrator does not accept vague resolutions. "I guess I just deal with it" is not an outcome — it is avoidance, and avoidance is a psychological signal the orchestrator should name and press on. What does the character actually do? What do they actually say? What do they sacrifice? If the player tries to split the difference, the orchestrator makes the cost of splitting visible.

**Consequences surfaced during discussion.** The orchestrator can sketch what will follow from a choice before the commit — not to spoil, but to ensure the player is choosing with awareness. "If you say that to her, she will hear it as X. Is that what you want?" This is not railroading. It is making the trade-off legible. The player should never commit to a pivotal action without understanding — at least partially — what it will cost.

**Persona stays active through discussion.** If a character is present in a pivotal scene (invoked via the persona agent), the relay loop continues through the discussion phase. The character reacts to the protagonist's choices in real time. Sofia does not wait for the commit to respond — she responds during discussion, through the persona agent, creating pressure and consequence *before* any state is written. This is the most significant behavioral difference from routine scenes: the character is not a static element the player responds to, but a dynamic presence that responds back.

### Commit Processing

Four amplifications at commit time:

**Broad delegation.** During pivotal moments, err toward invoking all affected domain agents. Psychology, network, and world all process the consequences. The moment's significance justifies the processing cost. Routine commits can skip uninvolved agents; pivotal commits should not.

**Amplification through instruction.** The orchestrator's delegation prompt to each domain agent includes context that this is a pivotal moment and consequences should reflect the outsized significance. This is not a new mechanic — the agents already know how to process significance. The orchestrator tells them to calibrate higher:
- Psychology agent: deeper schema activation, more willing to reorder values, assess defense tier shifts more aggressively
- Network agent: larger edge deltas, more decisive gatekeeper stance shifts, more visible normative pressure enforcement
- World agent: broader plausibility assessment (see "World Event Emergence" below)

**World event emergence.** The orchestrator's delegation to the world agent during pivotal commits includes a broader question: "Beyond plausibility validation, assess whether current world tensions — from `generation.json` defining events, `society.json` collective trauma, or `period.md` pressure points — would produce a coincident event that intersects with this moment. If so, propose it. If not, validate normally."

The default answer is "no." Most pivotal moments are personal, not historical. But at narrative climaxes — which is when pivotal moments tend to occur — the world's own tensions are more likely to be active. A protagonist's personal crisis coinciding with a world event is not a plot device when both emerge from the same generational pressure. The world agent recognizes this when it happens. The orchestrator does not force it.

**Ad-hoc codex synthesis.** The codex agent is normally invoked only at inflection point transitions and session exits. During a pivotal moment, the orchestrator may invoke it for an ad-hoc synthesis pass if the moment's significance warrants literary capture. This is not required for every pivotal moment — most will be captured in the next inflection-point synthesis. But if a pivotal moment is the crystallizing moment of an inflection, it triggers both the snapshot and the synthesis as the existing inflection-point mechanics already define.

### Delegation at Commit (Contrast with Relationship Events)

| | Relationship Events | Pivotal Moments |
|---|---|---|
| Network agent | Always | Always |
| Psychology agent | Only if significance threshold crossed | Always — threshold assumed crossed |
| World agent | Almost never | Always — broader question asked |
| Codex agent | Never | Only at inflection crystallization or exceptional significance |
| Snapshots | Never | Only at inflection crystallization |
| Consequence scale | Proportional to interaction | Amplified — larger deltas, deeper activation |

### Persona Integration

Pivotal moments are where persona delegation matters most. When a character is a participant in a pivotal scene — meaning the player will interact with them across multiple beats and their perspective shapes the outcome — the persona agent is invoked with the same context as any other scene (codex entry, network node/edge, scene context) plus awareness that the stakes are higher.

The persona agent does not perform differently in a mechanical sense — it embodies the character the same way it always does. But the orchestrator's interaction prompt should convey the pivotal context: what is at stake, what the character knows, and what the character wants from this moment. The persona agent uses this to ground its responses in the character's own stakes, not just their personality.

The relay loop during pivotal moments may be longer than during relationship events. Multiple exchanges, rising tension, moments where the character pushes back or goes quiet or says something unexpected. The orchestrator stays in its coordination lane — relaying, observing, recognizing closure — but does not cut the interaction short. Pivotal moments earn their duration.

### Examples by Inflection Point

**Attachment formation (early childhood):** A parent makes a decision that the child experiences as abandonment or safety. The child is too young for the persona relay — the orchestrator narrates. But the parent's choice is pivotal, and the psychology agent processes the schema formation with full weight.

**Agency threshold (late childhood):** The protagonist faces a situation where they can act or defer. The action has real social cost — a friendship risked, an authority defied. A peer or authority figure may be present as a persona-agent participant, creating live pressure.

**Identity consolidation (adolescence):** The protagonist's self-concept is tested by a situation that demands they choose which version of themselves to be. A friend, a romantic interest, a parent — someone whose response matters — is present and responding in real time. This is where the persona relay loop produces its best work, because the character's reaction to the protagonist's choice *is* the consequence.

**Moral reasoning inflection (early adulthood):** Values are tested against real cost. The protagonist can do the expedient thing or the right thing, and the right thing is expensive. A gatekeeper may control the outcome. The world agent's broader question becomes relevant — the personal moral test may intersect with a world-level pressure.

**Generativity vs. stagnation (midlife):** The protagonist confronts legacy — what they have built, what they have failed to build. A child, a protégé, a partner reflects the protagonist's choices back to them. The persona agent embodies someone who carries the weight of the protagonist's past decisions.

**Integrity vs. despair (late life):** The protagonist reconciles with the life they lived. A pivotal moment here may be quieter than at other inflection points — a conversation, a letter, a decision about how to face what is coming. The trade-off is not between actions but between narratives: which story does the protagonist tell about their life?
