---
bibliography: src/Alpaca.json
csl: acm-sig-proceedings.csl
...

"In all Indian musical traditions, learning, rationalization and sharing are part
of an internal process within and between artists. The magnificence of this
non-scribal technique is the acceptance of diversity and the possibility of
continuous musical change. The internalization of structure and form in the art,
the role of memory and rediscovering without written reference keeps the music
moving and varied. Every voice is not identical; the possibility of music
bending and swaying across regions, traditions and time is real. At no point is
the music etched in stone, trapped in time, a stone tablet of commandments."
TM Krishna, "Music and Justice" [@ref]

# From Konnakol Rhythms to Live Coding of the Self

This work explores commonalities between contemporary live coding of algorithmic
music, the Carnatic practice of Konnakol, towards establishing new musical
practice. This work involves software development of the TidalCycles and Strudel
live coding environments, adapting their representations for musical pattern
inspired by Carnatic (South Indian) rhythmic structures, and supporting
consideration of a new musical practice of 'auto live coding' or live coding of
the self.

## Konnakol

Konnakol is a South Indian, Carnatic musical practice, developing since around
200 CE. Konnakol involves the oral recitation of solkattu, which are groups of
non-lexical syllables or vocables associated with the Mrdigangam drum. Konnakol
is an oral tradition, transmitted and learned through recitation and listening
rather than by reading notation. Konnakol rhythms may be extremely complex,
heavily syncopated with frequent changes of speeds and addition/subtraction of
beats from successive repetitions. Still, Konnakol artists are able to perfectly
match their rhythm to the tala cycle. While performing, konnakol artists mark
the tala (roughly the metric cycle) by clapping, in particular by repeating a
sequence of clap-finger counts (laghu) and clap-waves (drutam).

I came to konnakol relatively late in life, and have only been learning konnakol
rhythms for approximately one year, but have already gained a great deal from my
studies. Unfortunately, I do not know any Indian languages, but there are
some texts in English on the artform. "The Art of Konnakkol", is a great
practical introduction which covers some historical and cultural context, and
which would go well with some of the many video tutorials available that you can
find online. Vocalist and activist TM Krishna is a key reference for cultural
and political background on carnatic music. For Western viewpoints, Lisa Young
has made her Masters and PhD theses on the topic available online. Rafael Reina
has a book on applying Karnatic rhythmical techniques to Western Classical
music, and David Nelson has published a Solkattu Manual. There is also software
with illuminating documentation, such as the Carnatic Music Typesetter by Arun
K. These texts aside, as a British person exploring Karnatic music without
having ever travelled to India, I am mindful that I am missing much of the
context of this artform, and feel at the start of a journey in many respects.

Nothing can stand in for actually learning and practicing konnakol rhythms. I am
mindful of what Kofi Agawu calls "paper rhythms"; those rhythmic transformations
which are apparent on paper, but have no living reality when performed or
listened/danced to. I have been lucky to take elementary konnakol lessons with
world reknowned percussionist B C Manjunath, an experience that has changed how
I think about and make music, and music software. I use the phrase _konnakol
rhythms_ advisedly; konnakol is rich with carnatic structures, for example the
concept of tala has many components to it, the major of which I have not touched
on. My focus in learning has only been on rhythmic aspects of konnakol.

So while as a beginner I have only touched on certain aspects of Konnakol,
focussing on rhythm, it has allowed me to build a sense of internal pulse within
a tala, and feeling how the rhythm moves around within that tala. It has felt
like learning a rhythm from multiple perspectives; it’s one thing to learn it
without clapping, then another to learn it while clapping, and it feels
completely different depending on whether I’m attending to the syllables, the
rhythmic structure, or the tala. It hard to explain in words, but taking in a
new rhythm can be an at times frustrating process of both learning and
forgetting as I come at it from different directions.

These konnakol rhythms are fundamentally algorithmic, and this is why it is
possible to recite long, complex compositions without notation. Complex patterns
emerge from the simple parts, and ways of transforming and combining them that
the konnakol artist is internally calculating. Numerical calculation becomes
part of an embodied experience, where notation is only used as a last resort.

"You cannot be complex just for the sake of being complex ... Paella is complex,
it has a lot of elements in it ... but it is built out of many simple
things. [If they are] imbided into each other, then that becomes complex. ... So
you have to get bored by doing a lot of simple things. ... If you understand
that you are trying to make something complex then that is a failure of a
musician. The complexity should be for others, but for me it should be simple."

"Rules are always redefined ... You learn a rule, and that becomes the new
norm - that becomes the rule. Then the already defined rule, the area
... becomes larger, and then you teach it to wsomeone else. They learn this
rule, some people want to stay in the same circle but some people want to forget
half of it, maybe they remember half of it; they break the rule, and that
becomes a new norm, you know? So rules are always being set. But, there are
always some rules which ... must not be broken. These rules are so strong
because it's hard to break them ... these are time-tested rules. If you try to
question them, there is always an answer, but you have to be intelligent enough
to find the answer. So only someone who knows the rules really well can break
the rules." - live coding is up to this challenge.

Paraphrasing; any computer sound can be formalised in konnakol but not
vice-versa, because the body is a much more advanced system for thinking about
sound than any computer.

## TidalCycles

TidalCycles (also known as Tidal for short) is a domain specific language
embedded in the functional Haskell programming language. Tidal was initially
developed by myself from 2009, and is now a thriving free/open source project
with many contributors. In recent years, Tidal has been ported to several
multiparadigm languages, most notably to Javascript as "Strudel" [@ref]. Strudel
has largely reached feature parity with Tidal, with some differences following
from the different constraints and opportunities of Javascript, as well as some
additional features e.g. around visualisation, and tonality.

As systems for making music (and other time-based media), Tidal and Strudel
enjoy vibrant communities of practice around their use, supporting performances
and workshops worldwide. Technical and cultural development are inseparable, in
that Tidal proposed a new way to think about and creating music, but would be
nothing without actual musicians adopting and applying it in working out what
that means in practice. It has been a privilege to be involved both in the
development of the algorave movement including through online community building
and festival organisation, and in the development of technology used in algorave
performances. These had to develop together; one could not have been imagined
without the other.

That said, there are many cultural precendents for contemporary algorithmic
music, and TidalCycles has a great deal to gain from a living heritage practice
such as Konnakol.

# Musical patterns as functions of time

The affordances of Tidal, and the ports which have followed, have come from its
core representation of patterns as functions of time. This is inspired by the
representation of signals in Functional Reactive Programming, but with support
for both discrete events and continuously varying values within the same
`Pattern` datatype:

```haskell
type Time = Rational
data TimeSpan = TimeSpan {begin :: Time, end :: Time}
data Event a = Event {whole :: Maybe TimeSpan, active :: TimeSpan, value :: a}
data Pattern a = Pattern {query :: TimeSpan -> [Event a]}
```

Occordingly, a pattern is a function from a timespan windows, to events taking
place within a given window. All events have a value and a timespan during which
that event is active within the query window. Discrete events have an additional
timespan representing an event's 'whole' timespan. this is needed to represent
an event fragment, which happens where event is partly active outside the
window, or through some pattern transformations.

Because patterns are fuctions, they are highlighly composable, in both the
computer scientific and musical sense. However one problem with patterns is that
there are a diverse multitude of ways to compose them together. As a result,
Tidal defines a range of applicative function application and monadic bind/join
functions. With a rich combinator library of pattern transformations, Tidal
provides rich and flexible domain-specific libary, designed to terse and
expressive enough to be used during live performance.

## Expanding Tidal to support Carnatic-esque patterns

One limitation of representing patterns with functions rather than
datastructures, is that functions are opaque. Take for example concatenation -
appending one pattern to another. The first problem we hit is that functions of
time are in principle infinite, so we can never reach the end of the first
pattern in order to play the second one. Tidal's answer to this is cycle-based
composition, where a cycle is roughly equivalent to a measure or bar in Western
classical music, and perhaps closer to the idea of a tala cycle in Indian
Classical Music (inspired by Bol Processor). Rather than concatenating whole
patterns then, successive cycles are concatenated, resulting in a cyclic
interleaving of patterns.

```hs
cat ["red green", "blue orange purple"]
```

As seen in the above example, each cycle is split in half, with the first half
containing two events of one quarter of cycle each, and the second half taking
three events of one sixth of a cycle each. Sometimes however, we might want
divide time up 'stepwise', so that each event in the resulting pattern has equal
duration, taking up one fifth of a cycle. Indeed, stepwise transformation and
composition of patterns is a pervasive feature of Carnatic music, as we will
later see.

Two different attempts were taken to support stepwise functionality. The first
was to create a pattern type class, with the existing functional patterns as one
instance (called `Signal`), plus additional type instance based on data
structures (called `Sequence`). This worked to a large extent, with a great deal
of functionality implemented relative to the Pattern instance, so that many of
the pattern transformations could work for both signals and sequences.

However despite much work, I settled on a simpler approach, based on the idea of
maintaining the 'tactus' of a pattern.

### Musical tactus

In music, the _tactus_ is a high-level pulse felt in the music, known as the
'clapping rate', or the pulse that an individual or crowd chooses to clap along
with a piece of music. There is work to automatically infer the tactus from a
piece of music or audio signal in the Music Information Retreival field, but in
many cases, it is ambiguous. One person might clap twice or half the speed of
another, and more problematically, in polyrhythmic music, the listener chooses
which rhythm to clap to. A trained musician might even mark multiple tactuses
with different limbs. Including tactus in a musical representation therefore
requires this ambiguity to be confronted.

In Tidal and Strudel, the tactus is added to the `Pattern` datatype as an
optional field, along with an additional `pureValue` field. In Haskell:

```haskell
data Pattern a = Pattern {query :: State -> [Event a],
                          tactus :: Maybe Time,
                          pureValue :: Maybe a
                         }
```

The `pureValue` field holds a value only for 'stable' patterns, i.e. those of a
single value that repeats once per cycle. This is maintained to support tactus
calculation; a tactus can only be calculated by pattern transforming functions
where certain arguments are stable.

On this basis, a range of additional pattern combinators have been defined, all
prefixed by `s_`, indicating that they work on a _stepwise_, rather than cyclic
basis, where a step is assumed to have the duration of each `clap`, i.e. `1 /
tactus`. Referring back to our earlier example with `cat`, we now have a `s_cat`
function:

```hs
s_cat ["red green", "blue orange purple"]
```

The result is the equivalent of `"red green blue orange purple"`, with a tactus
of `5`, being the sum of its component tactuses. What though, would be the
tactus of our original pattern?

```hs
cat ["red green", "blue orange purple"]
```

There at least four possibilities:- a) clapping the onsets of both components
would give two; b) clapping according to the elements of the first component
would give four; c) clapping with the elements of the second would give six; or
d) clapping the lowest common multiple, would give twelve. In Tidal, a) is the
default, and either b) or c) can be specified by marking one or the other as
being the 'strong' component with a caret (`^`) symbol (e.g. `cat ["^red green",
"blue orange purple"]` for b). d) is the result when both are marked as
'strong'.

## Stepwise combinators

The combinators are in a fairly early stage of development, with the aim of
making Carnatic-style rhythms easy to express. For example, the `s_taper`
function is inspired by `yati` structures, where phrase lengths are successively
reduced or increased by one.

s_taper

s_tour

steps

## Fitting the tala

According to Trichy Sankaran [@ref pg. 36], the term _tala_ is used in a broad
sense to describe all important principles concerning rhythm, but also to refer
to specific metrical cycles "composed of traditionally determined rhythmic units
which are indicated through concentionally followed hand gestures." The tala
provides the ground for rhythm, influencing our experience of rhythmic patterns
significantly, being "the foundation upon which intricate devices of
cross-rhythm and syncopation are built."

It is important for a piece to align with the cyclic time-measure of a
particular tala, by having a total number of beats divisible by the duration of
the tala. In other words, the piece should perfectly end on the _sam_, the name
for the beginning and therefore also the end of a cycle. A section in a piece
might not fall on the sam, however. A Korvai is divided into two sections, with
the second part containing groups of three repetitions of a phrase, each group
repeated three times divided by gaps. The piece can then fit the tala by
adjusting the repeated phrase or the duration of gaps between groups. The
konnakol or mridangam artist calculates how to best fit the piece to the tala
through such adjustments.

From a computer scientific perspective, this looks like a problem to solve; we
could formalise an algorithm for fitting a korvai to a tala. However, at this
point we should pause and consider where we draw the line of automation.

## Calculation as music

The notional 'line of automation' divides aspects abstracted and automated by a
computer, from those that we creatively engage with as humans. Konnakol is by
its nature computational, requiring calculation as part of its artistry, but
this does not mean that we wish to automate it. Just as people do not generally
start to learn to play the guitar by building a robot, we should be careful not
to approach music as a problem to solve. As we know from Christopher Small
[@ref], music is an activity, and as music-makers, we want to immersed ourselves
in that activity.

Indeed, live coders use programming languages not to automate the generation of
music, but to turn programming itself into music-making, as a means of creating
music in and for the moment. In this I argue that they are not only lead by
ideas but perhaps more importantly by perception of musical outcomes. Live
coding environments support immediately turning an idea into music, but it is
perception of the musical outcome with all its unexpected rhythmic complexities
and juxtapositions that inspire the next edits to drive the music forward.

Rather than attempting to codifying the rules of Konnakol then, I focus on
allowing music to be expressed within and without those rules, so that rules can
be freely adapted or pushed against.

## Developing practice

The technical development of computer music language should be part of a wider
development of a creative practice and indeed culture of practice around it. To
approach this, I decided to adopt a rule that I would not ask my computer to
perform a musical algorithm that I could not perform myself. This constraint
works to define a creative space, push my physical skill forward, and create
possibilities for shifting between and integrating code-driven and vocal
performance of an algorithm.

## Cultural appropriation

Developing live coding practice inspired by Konnakol is an act of cultural
appropriation. Although intermixing of cultural sources is common and broadly
accepted as a function of music, it can be problematic, whether through
misattribution, exploitation, or copyright theft, or in the case of Deep
Forest's "Sweet Lullaby", all three [@ref]. Kofi Agawu provides an informative
perspective on the pervasive spread of musics of Africa and the African diaspora
in the global north. Agawu weighs appropriation against homage, and issues of
copyright around traditional music where the notion of ownership does not
normally apply. He sees use of traditional African 'timeline' rhythms in western
minimalist compositions as potentially positive in drawing affinities with
traditional music while making something new in a new context, but it is a
complicated picture.

Returning to Carnatic music, it is certainly important to understand some of the
wider context of its rhythms when making systems inspired by konnakol. This
includes the spiritual background of its roots in Hinduism, and ongoing debates
on the role of caste privilege in music between traditional and progressive
voices. For now, I simply acknowledge that towards my aim of enriching
algorithmic music with heritage algorithms I _am_ appropriating culture, explore
the resulting tensions through scholarship and collaboration, while opening
myself to criticism. By sharing my work under a free/open source and creative
commons licenses, I explicitly encourage others enact reciprocity by appropriate
this work in turn.
