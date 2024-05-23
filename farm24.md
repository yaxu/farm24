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
T. M. Krishna, "Music and Justice" [@krishnaMusicJustice2020]

# From Konnakol Rhythms to Live Coding of the Self

The above quote from T. M. Krishna brings out a tension between music traditions
that are transmitted orally, and those transmitted via written notation. This
tension is particularly interesting from the perspective of the computer music
practice of live coding, which centres around the manipulation of notation but
where those notations themselves are written, manipulated and deleted live,
gaining an improvisatory, time-bound, ephemeral quality. In these respects, live
coding is closer to active speech than printed notation.

In the following I compare the Carnatic (South Indian) musical practice of
Konnakol with contemporary algorithmic music, as a means to open up and develop
new live coding practice. The conduit for this work is the software development
of the TidalCycles and Strudel live coding environments, adapting their
representations for musical pattern inspired by Carnatic rhythmic structures. I
will conclude with a search for musical meaning in this work, including
consideration of cultural appropriation, and the possibilities of 'auto live
coding' or live coding of the self.

## Konnakol

Konnakol is a Carnatic musical practice, developing since around 200 CE
[@sankaranArtKonnakkolSolkattu2010a, p. 3]. Konnakol involves the oral recitation
of _solkattu_ phrase groups of vocable words, which are non-lexical, but
generally associated with articulations of the Mrdigangam drum, as well as
movements within the bharata natyam dance tradition. Konnakol is an oral
tradition, generally transmitted and learned through recitation and listening
rather than via notation. Konnakol performances are rhythmically highly complex
and heavily syncopated with frequent changes of speeds, and
e.g. addition/subtraction of beats from successive repetitions. Still, there is
always a steady underlying pulse, where Konnakol artists are able to perfectly
match their rhythmic transformations to a particular _tala_ structure. While
performing, konnakol artists mark the tala with their hands, for example by
repeating a sequence of clap-finger counts (laghu) and clap-waves (drutam).

There are not a great deal of English texts on the artform, but "The Art of
Konnakkol" by Trichy @sankaranArtKonnakkolSolkattu2010a is an excellent
practical introduction which covers some historical and cultural context,
includes recordings of exercises, and which would go well with some of the many
video tutorials available online. Vocalist and activist T.M. Krishna, quoted at
the beginning of this paper, is a key reference for cultural and political
background on carnatic music [@krishnaSouthernMusic2017]. For Western
viewpoints, Lisa Young has made her Masters and PhD theses on the topic
available online
[@youngKonakkolHistoryDevelopment1998,@youngKonakkolHistoryDevelopment1998]. In
Italy, (?) Rafael Reina has a book on applying Karnatic rhythmical techniques to
Western Classical music [@reinaApplyingKarnaticRhythmical2015a], and in
Australia, David Nelson has published a Solkattu Manual
[@nelsonSolkattuManual2008]. For a computer music perspective, an interview by
Rotherham-based musician Mark Fell with the Glasgow-based, Indian musican Nakul
Krishnamurthy explores improvisation, notation and tradition in challenging ways
[@fellStructureSynthesisAnatomy2022, pp. 243-259].

Nothing can stand in for actually learning and practicing konnakol
rhythms. Indeed, we should take care not to be too distracted by what Kofi Agawu
calls "paper rhythms"; those rhythmic transformations which are apparent on
paper, but have no living reality when performed, listened to and danced to. I
have been lucky to take elementary konnakol lessons with world reknowned
percussionist B C Manjunath, an experience that has changed how I think about
and make music, and music software. I use the phrase _konnakol rhythms_
advisedly; konnakol is a rich artform, the majority of which I have not touched
on. So far my focus has only been on rhythmic aspects of konnakol.

Nonetheless learning konnakol rhythms has allowed me to build a sense of
internal pulse within a tala, and of how the rhythm moves around within that
tala. It has felt like learning a rhythm from multiple perspectives; it is one
thing to learn to recite a sequence, and something quite different to learn to
recite it while clapping the tala. It also feels completely different depending
on whether I am attending to the syllables, the rhythmic structure, or the
tala. I might write the syllables down to understand the structure of a rhythm,
but it is only when I leave that notation behind that I begin to really learn
and feel a rhythm. It is hard to explain in words, but taking in a new rhythm
can at times be a slightly frustrating cyclic process of learning and forgetting
as I come at it from different directions.

These konnakol rhythms are fundamentally algorithmic, and this is why it is
possible to recite long, complex compositions without notation. Numerical
calculation becomes part of an embodied experience, so that complex patterns
emerge from simple parts. Or as B C Manjunath puts it:

"You cannot be complex just for the sake of being complex ... [The Spanish dish]
paella is complex, it has a lot of elements in it ... but it is built out of
many simple things. [If they are] imbided into each other, then that becomes
complex. ... So you have to get bored by doing a lot of simple things. ... If
you understand that you are trying to make something complex then that is a
failure of a musician. The complexity should be for others, but for me it should
be simple."

<!-- Improvisation - quote from Mark Fell's interview with Narkul -->

<!-- "Rules are always redefined ... You learn a rule, and that becomes the -->
<!-- new norm - that becomes the rule. Then the already defined rule, the -->
<!-- area ... becomes larger, and then you teach it to wsomeone else. They -->
<!-- learn this rule, some people want to stay in the same circle but some -->
<!-- people want to forget half of it, maybe they remember half of it; they -->
<!-- break the rule, and that becomes a new norm, you know? So rules are -->
<!-- always being set. But, there are always some rules which ... must not -->
<!-- be broken. These rules are so strong because it's hard to break them -->
<!-- ... these are time-tested rules. If you try to question them, there is -->
<!-- always an answer, but you have to be intelligent enough to find the -->
<!-- answer. So only someone who knows the rules really well can break the -->
<!-- rules." - live coding is up to this challenge. -->

<!-- Paraphrasing; any computer sound can be formalised in konnakol but not -->
<!-- vice-versa, because the body is a much more advanced system for -->
<!-- thinking about sound than any computer. -->

Next we turn to live coding technologies of TidalCycles and Strudel, on the way
of looking at some Carnatic rhythmic structures in konnakol.

## TidalCycles and Strudel - live coding languages for pattern

TidalCycles (also known as Tidal for short) is a domain specific language
embedded in the functional Haskell programming language. Tidal was developed by
myself from 2009, becoming a thriving free/open source project with many
contributors [@mcleanMakingProgrammingLanguages2014]. In recent years, Tidal has
been ported to several multiparadigm languages, most notably to Javascript as
"Strudel" [@roosStrudelLiveCoding2023]. Strudel has largely reached feature
parity with Tidal, with some differences following from the different
constraints and opportunities of Javascript, as well as some additional
e.g. user interface, visualisation, and tonality features.

As systems for making music (and other time-based media), Tidal and Strudel
enjoy vibrant communities of practice around their use, supporting performances
and workshops worldwide. Technical and cultural development are inseparable, in
that Tidal proposed a new way to think about and creating music, but it was its
end-user community of musicians that established its musical-cultural
meaning. It has been a privilege to be involved in these the cultural
developments, including through online community building, festival organisation
and development of the algorave movement
[@collinsAlgoraveSurveyHistory2014a]. These technical and cultural aspects had
to develop together; one could not have been imagined without the other.

That said, there are many cultural precendents for contemporary algorithmic
music, and live coding environments have a great deal to gain from a living
heritage practice such as Konnakol.

# Musical patterns as functions of time

The affordances of Tidal, Strudel and other ports follow from its core
representation of patterns, as functions of time. This is inspired by signals in
Functional Reactive Programming [@elliottPushpullFunctionalReactive2009], but
with support for both discrete events and continuously varying values within the
same `Pattern` datatype. For readers familiar with the Haskell programming
language, here are the types, followed by a short explanation, which others
might wish to skip:

```haskell
type Time = Rational
data TimeSpan = TimeSpan {begin :: Time, end :: Time}
data Event a = Event {whole :: Maybe TimeSpan, active :: TimeSpan, value :: a}
data Pattern a = Pattern {query :: TimeSpan -> [Event a]}
```

A pattern then, is a function that is queried with a timespan window, and
returns events taking place within that window. All events have a value and a
timespan during which that event is active within the query window. Discrete
events have an additional timespan representing an event's 'whole'
timespan. This is needed to represent an event fragment, which occurs where an
event is partly active outside the window, or through some pattern
transformations.

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
music. Rather than concatenating whole patterns then, successive cycles are
concatenated, resulting in a cyclic interleaving of patterns.

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

s_expand

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
