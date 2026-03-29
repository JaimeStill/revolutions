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

*This section is a placeholder. Pivotal moment mechanics — the formalized engagement mode for moments of real consequence — are the next major design target. When designed, they will cover: trigger conditions, how the three-phase cycle behaves differently under pressure, forced trade-offs, consequence amplification, and how world events emerge at narrative climaxes.*
