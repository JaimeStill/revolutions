# Codex Style Guide

The codex is the literary face of the simulation. State files are for the engine. The codex is for anyone who reads it — player, future AI agent, or a stranger who has never heard of the time and place this life is set in. Every entry must carry its own weight.

## Core Principles

### 1. Never rely on the reader's prior knowledge

Historical events, cultural norms, and institutional structures must be rendered from the ground up. Name an event and you've communicated nothing — the reader may not know what it was, what it meant, or why it mattered. Instead, show how the event changed the character's sensory world: the new lock on the classroom door, the neighbor's house going quiet, the herbs mother burns in the doorway that she never burned before.

A reader from any culture or era should feel the weight of what happened, because the prose builds that weight from concrete, lived detail — not from assumed shared knowledge.

This applies equally to social norms, economic conditions, religious practices, and political structures. Don't name them and expect understanding. Show what they look like from inside a life.

### 2. Moments must be earned by their context

Significant moments land because of what surrounds them, not because of their own dramatic content. The ordinary texture of a life — the routines, the unremarkable Tuesdays, the ambient hum of a household — is the soil that makes the significant moments feel discovered rather than placed.

Resist the impulse to trim everything to its thematic essence. A life is not a curated exhibit of character-revealing vignettes. It is a continuous experience in which meaning accumulates through repetition, habit, and slow change. When every paragraph makes a point and exits cleanly, the prose reads like an essay about a person rather than a person living.

Let some ordinary detail survive. Not as padding — as ground.

### 3. Characters are people, not caricatures

Every person in the codex had a morning routine, a way of holding a coffee cup, a phrase they overused, a thing they did when they were nervous. Distinctiveness comes from these specific, observed details — not from exaggerated traits or single defining characteristics.

A character entry should make you feel like you've met this person. Not because it tells you what they're like, but because it shows you the particular way they move through the world. The difference between "Greg was stoic" and "Greg showed pride through delegation, not words" is the difference between a label and a person.

Avoid the trap of making every character a symbol. Karen is not "the anxious mother." She is a specific woman whose love vibrates at a specific frequency, who applies mascara unevenly after crying, who picks up extra real estate shifts when money gets tight. The anxiety is visible through these details, not stated as a trait.

### 4. Events produce two outputs

When the simulation encounters a significant historical or cultural event:

- **A world entry** documents the event with full historical context — what happened, why it mattered, what it changed. Written so any reader, from any background, understands it.
- **A chronicle passage** renders how that event filtered into the character's daily experience — not the event itself, but the behavioral residue it left in the adults, the institutions, the physical environment.

The world entry carries the factual and historical weight. The chronicle carries the experiential truth. They complement each other without duplicating.

## Chronicle Craft

The chronicle is the narrative spine of a life. It is organized by developmental chapters, not by calendar.

**Chapter structure.** Each chapter corresponds to a developmental period or inflection point. Chapters have organic titles that capture the character of the period, not clinical labels. "The Absorbent Years" rather than "Early Childhood (1993-2000)."

**Time compression.** Between inflection points, the chronicle compresses time. Years pass in paragraphs. But compression doesn't mean summary — it means selecting the details that capture the texture of a period and letting them stand for the whole. A single well-chosen afternoon can represent three years of a routine.

**Ordinary texture.** The chronicle must include enough unremarkable detail that the remarkable moments feel earned. What did the house smell like? What was the drive to school? What did Saturdays feel like? These details are not filler — they are the medium through which a life is experienced.

**Sensory entry points.** Every event, every shift, every change enters the chronicle through something the character can perceive. Not "the economy worsened" but "father started checking the mailbox twice a day." Not "the culture became more fearful" but "the neighbor kids stopped playing in the front yard." The character's age and cognitive development determine what they can perceive and what they make of it.

**Connective tissue.** Transitions between events and periods should feel organic, not arranged. One thing leads to another because that's how the life unfolded, not because the author needed to get to the next scene. If two events are separated by three unremarkable months, acknowledge the months. Don't just cut.

## Character Entries

Each entry in `characters/` captures who someone is *to the character* — not an objective biography, but a portrait filtered through the relationship.

**Voice and mannerism.** Every person has a way of speaking, moving, and being in the world. Capture it in specific detail. How do they greet people? What do they do with their hands when they're uncomfortable? What phrases do they repeat? These details make a person recognizable across scenes without needing to be re-described.

**Observation over description.** Show behavior and let the reader draw conclusions. "She arrived at school with her mascara applied unevenly, as if she'd been crying and then tried to fix it in the car" is observation. "She was upset but trying to hide it" is description. The first trusts the reader. The second doesn't.

**Evolution.** Character entries are living documents. When a person's role in the character's life shifts — when a parent becomes distant, when a friend drifts away, when an antagonist becomes irrelevant — the entry should reflect the current state of the relationship while preserving the history of how it got there.

## Psychology Portrait

The portrait in `psychology/` is a developmental assessment — the kind a thoughtful, literary-minded clinician might write. It weaves psychological theory into readable prose without jargon.

**Voice.** Clinical but warm. Precise but not cold. The portrait should read like it was written by someone who understands both the theory and the person — who can see the schema operating and also feel the human cost of it.

**Theory integration.** Name the theoretical framework only when it illuminates. "Drew's primary defense is sublimation" is useful shorthand for someone who knows the term, but the sentence that follows should make the concept clear to anyone: "he transforms uncomfortable feelings into productive activity." Theory serves the portrait, not the other way around.

**Developmental horizon.** Every portrait should end with what's coming — the tensions that are building, the tests that haven't arrived yet, the questions the character doesn't know they'll be asked. This orients the reader (and the engine) toward the narrative future.

## World Entries

Entries in `world/` are reference documents — self-contained, discoverable, and complete enough to stand alone.

**The self-sufficiency test.** Could a reader with zero background knowledge of this time, place, or culture read this entry and understand what it describes and why it mattered? If not, the entry isn't finished.

**Places** (`world/places/`) — the physical and cultural texture of a location. What it looks like, what it feels like to live there, what it rewards and punishes, what opportunities it offers and forecloses. Not a Wikipedia article — a portrait of a place as a living system that shapes the people in it.

**Events** (`world/events/`) — what happened, why it mattered, what it changed. The historical and cultural weight rendered in full, so the chronicle doesn't have to carry that burden. An event entry should make a reader understand why adults started acting differently, why institutions changed their rules, why the ambient mood of a household shifted.

**Institutions** (`world/institutions/`) — schools, churches, employers, government bodies. What they are, how they function, what role they play in the character's life, what values they encode and enforce. Institutions are the structures through which society acts on individuals.

## README Indexes

Every codex subdirectory contains a `README.md` that indexes its contents. Each entry gets a one-line description — enough to decide whether to read the full file. Keep the index current as entries are added or revised.

## Anti-Patterns

These are the tells of generic AI prose. Avoid them.

### Structural anti-patterns

- **Thematic over-tidiness.** Every paragraph making a point and exiting cleanly. Real lives don't organize themselves into vignettes. Leave room for mess, for details that don't resolve neatly, for threads that dangle.
- **Summary masquerading as narrative.** "The next three years were defined by..." is compression. "He became more withdrawn" is summary. Compression selects vivid details and lets them stand for a period. Summary tells you what happened without showing you anything.
- **Assumed cultural knowledge.** Naming an event (Columbine, the Black Death, the Cultural Revolution) and expecting the reader to supply the weight. Build it from the ground.
- **Character-as-symbol.** Reducing a person to their narrative function. Karen is not "the anxious mother." Kyle is not "the bully." They are people who, among other things, worry and intimidate.

### AI voice fingerprints

These are specific, recurring patterns that mark prose as machine-generated. They are not inherently bad in isolation — most are legitimate rhetorical devices. The problem is frequency, predictability, and clustering. When they appear together, on every page, the prose develops a recognizable signature that pulls the reader out of the life and into awareness of the engine.

**The "not X but Y" antithetical.**
Defining things by negation before affirmation. Powerful once per chapter. Deadening when it becomes the default sentence shape.

> ✗ "Not a wave, not a smile — a look. Not surprise, not pleasure exactly, but the careful registration of something that matched what she'd been hoping to find."

The fix is not to avoid the construction entirely — it's to notice when you're reaching for it and choose a different shape. Sometimes the affirmative version is stronger: "She looked at him. The expression was one he was learning to read." Sometimes the detail speaks without framing: "She looked back once, long enough to be unmistakable, and then she was through the doors."

**The psychological narrator.**
A running commentary track that decodes every gesture, silence, and word choice in real time. The narrator functions as a therapist annotating the scene rather than a camera recording it.

> ✗ "It was the self-sacrifice schema talking, wrapping a genuine anxiety in the logic of someone else's burden."
> ✗ "She was not asking him to watch a performance. She was asking him to step into the world she went home to."
> ✗ "The crossing was deliberate — not rushed, not casual, but the movement of someone who had decided where she was going before she entered the room."

The fix: show the behavior and let the reader do the interpreting. "Mom's plate is full with Megan" is already the self-sacrifice schema talking — the reader can hear it without being told. Sofia crossing the lobby to Drew already shows deliberateness — the narrator doesn't need to annotate the crossing. Trust that a reader who has lived inside this character for chapters will understand what a gesture means.

Not every moment needs its significance identified. Some of the best moments in fiction are ones where the reader feels the weight before they can name it — and the narrator never names it at all.

**The "the way" connective.**
A bridging phrase that links a concrete detail to its interpretation. Once is invisible. Three times per page is a verbal tic.

> ✗ "the way she said most things — after a pause, with the words already assembled"
> ✗ "the way Marcus looked at a piece of code that had an obvious solution the author couldn't see"
> ✗ "the way you feel a change in barometric pressure before the weather turns"

Usually the fix is to just cut the bridge and let the detail exist on its own, or restructure the sentence so the detail is the sentence.

**"The particular/specific quality of."**
An abstract filler phrase that gestures toward specificity without providing it.

> ✗ "the particular quality of her attention"
> ✗ "the particular formality of young musicians performing something they'd rehearsed to the point of ownership"

If the quality is worth naming, name it concretely. If it's not worth naming, the sentence doesn't need the phrase. "Her attention" is fine. "Young musicians in their concert blacks, careful with their instruments" is better than "the particular formality of young musicians."

**Excessive em-dash parentheticals.**
Em-dash asides that decode the subtext of what just happened. Individually, many of these are good — they add texture, voice, specificity. The problem is density. When every other sentence has a parenthetical aside, the prose develops a lurching rhythm: statement — qualification — statement — qualification.

Ration them. One or two per section. When you catch yourself adding a third, cut the weakest of the three.

**Thematic callback chains.**
Every new scene moment immediately linked to every previous relevant scene, creating a closed loop of self-reference that flatters the prose's own continuity.

> ✗ "The letter had been a leap. The courtyard had been a catch. Carol's kitchen had been a mirror. The concert lobby had been something else."

Real memory doesn't work this way. A person standing in a lobby after a significant moment doesn't compile a retrospective inventory of all previous significant moments and assign each one a metaphor. They feel something. Maybe one previous moment surfaces — the most recent, or the most structurally similar, not the complete set. Resist the urge to connect everything. Let some connections form in the reader's mind without the narrator drawing the lines.

**The omniscient narrator of significance.**
The narrator always knows exactly what everything means. There is no ambiguity, no uncertainty, no moment where the prose registers something without fully understanding it. Every scene arrives pre-interpreted.

Real literary fiction has moments where the narrator — even a close-third narrator — doesn't fully understand what just happened. The reader feels the weight of a moment before its meaning resolves. The prose can describe what someone felt without explaining why. It can end a scene on an image rather than an insight. "He sat on the edge of his bed in the dark" is a complete ending. It doesn't need "and he understood that he had not come home with a story about something that happened to him."

**Rhythmic monotony.**
Sentence lengths clustering in the medium-long range. Paragraphs following the same arc: concrete detail → interpretation → significance. Few short sentences. Few genuinely long, winding ones. Everything in the same comfortable middle.

Vary the rhythm deliberately. A three-word sentence after a long paragraph hits differently than another medium clause. A paragraph that is all concrete detail — no interpretation — changes the texture. Silence between the notes.

**Exhaustive significance.**
Nothing is allowed to be merely what it is. Every gesture, word choice, silence, and physical detail is decoded into meaning. The prose functions as a closed system where everything signifies.

Real lives have waste. Real fiction has details that are just details — the color of a wall, a song on the radio, the way someone folds a napkin — that exist because the world exists, not because the narrator needs them to mean something. These details are what make the significant moments significant: they're the ordinary ground against which meaning becomes visible.

When you catch every detail meaning something, deliberately include some that don't. A sentence about the weather that is just weather. A physical detail that is just a physical detail. Let the reader decide what matters.

**Telling emotional states.**
"He felt sad." "She was anxious." Show the behavior. Trust the reader.

**Excessive parallelism.**
"She was X but also Y. He was A yet somehow B." Once or twice is rhetoric. Every paragraph is a tic.

**Metaphor overload.**
One good metaphor per passage. If every sentence is figurative, none of them land.

**Clinical language in narrative.**
"His attachment style was anxious-avoidant" belongs in the psychology portrait, not the chronicle. In the chronicle, show the attachment pattern through behavior.

## Economy

The codex lives in the simulation's context window. Every sentence must earn its place — not by being maximally information-dense, but by doing real work. Rich prose is not verbose prose. A single concrete detail often does more than a paragraph of description.

The discipline is knowing what to include and what to leave out. Include the detail that makes you see the person, feel the place, understand the moment. Leave out the detail that merely confirms what the reader already suspects.
