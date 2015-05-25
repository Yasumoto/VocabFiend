//
//  WordDictionary.swift
//  VocabFiend
//
//  Created by Joseph Smith on 3/8/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import Foundation
import Realm

class Entry: RLMObject, NSCoding {
    var word : String?
    var partOfSpeech : String?
    var definition : String?
    
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(word, forKey: "word")
        aCoder.encodeObject(partOfSpeech, forKey: "partOfSpeech")
        aCoder.encodeObject(definition, forKey: "definition")
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        self.word = aDecoder.decodeObjectForKey("word") as? String
        self.partOfSpeech = aDecoder.decodeObjectForKey("partOfSpeech") as? String
        self.definition = aDecoder.decodeObjectForKey("definition") as? String
    }
    
    convenience init(word: String, partOfSpeech: String, definition: String) {
        self.init()
        self.word = word
        self.partOfSpeech = partOfSpeech
        self.definition = definition
    }
}

func getRandomIndex() -> Int {
    let sizeOfOptions = UInt32(wordList.count)
    let generatedIndex = Int(arc4random_uniform(sizeOfOptions))
    return generatedIndex
}

let wordList = [
    Entry(word: "aberrant", partOfSpeech: "adj.", definition: "deviating from normal or correct."),
    Entry(word: "abscond", partOfSpeech: "v.", definition: "to leave secretly and hide, often to avoid the law."),
    Entry(word: "advocate", partOfSpeech: "v., n.", definition: "to speak, plead, or argue for a cause, or in another’s behalf. (n) -- one who advocates."),
    Entry(word: "aggrandize", partOfSpeech: "v.", definition: "to make greater, to increase, thus, to exaggerate."),
    Entry(word: "amalgamate", partOfSpeech: "v.", definition: "to unite or mix. (n) -- amalgamation."),
    Entry(word: "ambiguous", partOfSpeech: "adj.", definition: "vague; subject to more than one interpretation"),
    Entry(word: "ambrosial", partOfSpeech: "adj.", definition: "extremely pleasing to the senses, divine (as related to the gods) or delicious (n: ambrosia)"),
    Entry(word: "anachronism", partOfSpeech: "n.", definition: "a person or artifact appearing after its own time or out of chronological order (adj: anachronistic)"),
    Entry(word: "anomalous", partOfSpeech: "adj.", definition: "peculiar; unique, contrary to the norm (n: anomaly)"),
    Entry(word: "antediluvian", partOfSpeech: "adj.", definition: "ancient; outmoded; (literally,before the flood)"),
    Entry(word: "antipathy", partOfSpeech: "n.", definition: "hostility toward, objection, or aversion to"),
    Entry(word: "arbitrate", partOfSpeech: "v.", definition: "to settle a dispute by impulse (n: arbitration)"),
    Entry(word: "assuage", partOfSpeech: "v.", definition: "to make less severe; to appease or satisfy"),
    Entry(word: "attenuate", partOfSpeech: "v.", definition: "weaken (adj: attenuated)"),
    Entry(word: "audacious", partOfSpeech: "adj.", definition: "extremely bold; fearless, especially said of human behavior (n: audacity)"),
    Entry(word: "aver", partOfSpeech: "v.", definition: "to declare"),
    Entry(word: "banal", partOfSpeech: "adj.", definition: "commonplace or trite (n: banality)"),
    Entry(word: "barefaced", partOfSpeech: "adj.", definition: "unconcealed, shameless, or brazen"),
    Entry(word: "blandishment", partOfSpeech: "n.", definition: "speech or action intended to coax someone into doing something"),
    Entry(word: "bombast", partOfSpeech: "n.", definition: "pompous speech (adj: bombastic)"),
    Entry(word: "breach", partOfSpeech: "n., v.", definition: "a lapse, gap or break, as in a fortress wall. To break or break through.ex: Unfortunately, the club members never forgot his breach of ettiquette."),
    Entry(word: "burgeon", partOfSpeech: "v., n.", definition: "to grow or flourish; a bud or new growth (adj: burgeoning )"),
    Entry(word: "buttress", partOfSpeech: "v., n.", definition: "to support. a support"),
    Entry(word: "cadge", partOfSpeech: "v.", definition: "to get something by taking advantage of someone"),
    Entry(word: "caprice", partOfSpeech: "n.", definition: "impulse (adj: capricious)"),
    Entry(word: "castigate", partOfSpeech: "v.", definition: "to chastise or criticize severely"),
    Entry(word: "catalyst", partOfSpeech: "n.", definition: "an agent of change (adj: catalytic; v. catalyze)"),
    Entry(word: "caustic", partOfSpeech: "adj.", definition: "capable of dissolving by chemical action; highly critical: \"His caustic remarks spoiled the mood of the party.\""),
    Entry(word: "chicanery", partOfSpeech: "n.", definition: "deception by trickery"),
    Entry(word: "complaisant", partOfSpeech: "adj.", definition: "willingly compliant or accepting of the status quo (n: complaisance)"),
    Entry(word: "conflagration", partOfSpeech: "n.", definition: "a great fire"),
    Entry(word: "corporeal", partOfSpeech: "adj.", definition: "of or having to do with material, as opposed to spiritual; tangible. (In older writings, coeporeal could be a synonym for corporal. This usage is no longer common)"),
    Entry(word: "corporal", partOfSpeech: "adj.", definition: "of the body: \"corporal punishment.\" a non-commissioned officer ranked between a sergeant and a private."),
    Entry(word: "corroborate", partOfSpeech: "v.", definition: "to strengthen or support: \"The witness corroborted his story.\" (n: corroboration)"),
    Entry(word: "craven", partOfSpeech: "adj., n.", definition: "cowardly; a coward"),
    Entry(word: "culpable", partOfSpeech: "adj.", definition: "deserving of blame (n: culpability)"),
    Entry(word: "dearth", partOfSpeech: "n.", definition: "lack, scarcity: \"The prosecutor complained about the dearth of concrete evidence against the suspect.\""),
    Entry(word: "deference", partOfSpeech: "n.", definition: "submission or courteous yielding: \"He held his tongue in deference to his father.\" (n: deferential. v. defer)"),
    Entry(word: "depict", partOfSpeech: "v.", definition: "to show, create a picture of."),
    Entry(word: "deprecation", partOfSpeech: "n.", definition: "belittlement. (v. deprecate)"),
    Entry(word: "depredation", partOfSpeech: "n.", definition: "the act of preying upon or plundering: \"The depredations of the invaders demoralized the population.\""),
    Entry(word: "descry", partOfSpeech: "v.", definition: "to make clear, to say"),
    Entry(word: "desiccate", partOfSpeech: "v.", definition: "to dry out thoroughly (adj: desiccated)"),
    Entry(word: "diatribe", partOfSpeech: "n.", definition: "a bitter abusive denunciation."),
    Entry(word: "diffident", partOfSpeech: "adj.", definition: "lacking self-confidence, modest (n: diffidence)"),
    Entry(word: "disabuse", partOfSpeech: "adj.", definition: "to free a person from falsehood or error: \"We had to disabuse her of the notion that she was invited.\""),
    Entry(word: "disparaging", partOfSpeech: "adj.", definition: "belittling (n: disparagement. v. disparage)"),
    Entry(word: "dispassionate", partOfSpeech: "adj.", definition: "calm; objective; unbiased"),
    Entry(word: "dissemble", partOfSpeech: "v.", definition: "to conceal one's real motive, to feign"),
    Entry(word: "dogged", partOfSpeech: "adj.", definition: "stubborn or determined: \"Her dogged pursuit of the degree eventually paid off.\""),
    Entry(word: "dogmatic", partOfSpeech: "adj.", definition: "relying upon doctrine or dogma, as opposed to evidence"),
    Entry(word: "eclectic", partOfSpeech: "adj.", definition: "selecting or employing individual elements from a variety of sources: \"Many modern decorators prefer an eclectic style.\" (n: eclecticism)"),
    Entry(word: "efficacy", partOfSpeech: "n.", definition: "effectiveness; capability to produce a desired effect"),
    Entry(word: "effluent", partOfSpeech: "adj., n", definition: "the quality of flowing out. something that flows out, such as a stream from a river (n: effluence)"),
    Entry(word: "emollient", partOfSpeech: "adj., n.", definition: "softening; something that softens"),
    Entry(word: "emulate", partOfSpeech: "v.", definition: "to strive to equal or excel (n: emulation)"),
    Entry(word: "encomium", partOfSpeech: "n.", definition: "a formal eulogy or speech of praise"),
    Entry(word: "endemic", partOfSpeech: "adj.", definition: "prevalent in or native to a certain region, locality, or people: \"The disease was endemic to the region.\" Don't confuse this word with epidemic."),
    Entry(word: "enervate", partOfSpeech: "v.", definition: "to weaken or destroy the strength or vitality of: \"The heatenervated everyone.\" (adj: enervating)"),
    Entry(word: "engender", partOfSpeech: "v.", definition: "to give rise to, to propagate, to cause: \"His slip of the toungue engendered much laughter.\""),
    Entry(word: "enigma", partOfSpeech: "n.", definition: "puzzle; mystery: \"Math is an enigma to me.\" (adj: enigmatic)"),
    Entry(word: "ephemeral", partOfSpeech: "adj.", definition: "lasting for only a brief time, fleeting (n: ephemera)"),
    Entry(word: "equivocal", partOfSpeech: "adj.", definition: "ambiguous; unclear; subject to more than one interpretation -- often intentionally so: \"Republicans complained that Bill Clinton's answers were equivocal.\" (v. equivocate)"),
    Entry(word: "erudite", partOfSpeech: "adj.", definition: "scholarly; displaying deep intensive learning. (n: erudition)"),
    Entry(word: "esoteric", partOfSpeech: "adj.", definition: "intended for or understood by only a few: \"The esoteric discussion confused some people.\" (n: esoterica)"),
    Entry(word: "eulogy", partOfSpeech: "n.", definition: "a spoken or written tribute to the deceased (v. eulogize)"),
    Entry(word: "exacerbate", partOfSpeech: "v.", definition: "to increase the bitterness or violence of; to aggravate: \"The decision to fortify the border exacerbated tensions.\""),
    Entry(word: "exculpate", partOfSpeech: "v.", definition: "to demonstrate or prove to be blameless:  \"The evidence tended to exculpate the defendant.\"(adj: exculpatory)"),
    Entry(word: "exorbitant", partOfSpeech: "adj.", definition: "exceeding customary or normal limits, esp. in quantity or price: \"The cab fare was exorbitant.\""),
    Entry(word: "explicit", partOfSpeech: "adj.", definition: "fully and clearly expressed"),
    Entry(word: "extant", partOfSpeech: "adj.", definition: "in existence, still existing: \"The only extant representative of that species.\""),
    Entry(word: "fathom", partOfSpeech: "n., v.", definition: "a measure of length (six feet) used in nautical settings. to penetrate to the depths of something in order to understand it: \"I couldn't fathom her reasoning on that issue.\""),
    Entry(word: "fawn", partOfSpeech: "v.", definition: "to seek favor or attention; to act subserviantly (n, adj: fawning)"),
    Entry(word: "feign", partOfSpeech: "v.", definition: "to give false appearance or impression: \"He feigned illness to avoid going to school.\" (adj: feigned)"),
    Entry(word: "fervent", partOfSpeech: "adj.", definition: "highly emotional; hot: \"The partisans displayed a fervent patriotism.\" (n: fervor)"),
    Entry(word: "fervid", partOfSpeech: "adj.", definition: "highly emotional; hot: \"The partisans displayed a fervent patriotism.\" (n: fervor)"),
    Entry(word: "fledgling", partOfSpeech: "n., adj.", definition: "a baby bird; an inexperienced person; inexperienced."),
    Entry(word: "florid", partOfSpeech: "adj.", definition: "flushed with a rosy color, as in complexion; very ornate and flowery: \"florid prose.\""),
    Entry(word: "floundering", partOfSpeech: "adj.", definition: "struggling: \"We tried to save the floundering business.\""),
    Entry(word: "garrulous", partOfSpeech: "adj.", definition: "verbose; talkative; rambling: \"We tried to avoid our garrulous neighbor.\""),
    Entry(word: "gossamer", partOfSpeech: "n., adj.", definition: "fine cobweb on foliage; fine gauzy fabric; very fine: \"She wore a gossamer robe.\""),
    Entry(word: "guile", partOfSpeech: "n.", definition: "skillful deceit: \"He was well known for his guile.\" (v. bequile; adj: beguiling. Note, however, that these two words have an additional meaning: to charm (v.) or charming (adj:), while the word guile does not generally have any such positive connotations)"),
    Entry(word: "guileless", partOfSpeech: "adj.", definition: "honest; straightforward (n: guilelessness)"),
    Entry(word: "hapless", partOfSpeech: "adj.", definition: "unfortunate"),
    Entry(word: "headlong", partOfSpeech: "adj., adv.", definition: "headfirst; impulsive; hasty. impulsively; hastily; without forethought: \"They rushed headlong into marriage.\""),
    Entry(word: "homogenous", partOfSpeech: "adj.", definition: "similar in nature or kind; uniform: \"a homogeneous society.\""),
    Entry(word: "iconoclast", partOfSpeech: "n.", definition: "one who attacks traditional ideas or institutions or one who destroys sacred images (adj: iconoclastic)"),
    Entry(word: "impecunious", partOfSpeech: "adj.", definition: "penniless; poor"),
    Entry(word: "imperious", partOfSpeech: "adj.", definition: "commanding"),
    Entry(word: "implication", partOfSpeech: "n.", definition: "insinuation or connotation (v. implicate)"),
    Entry(word: "imply", partOfSpeech: "v.", definition: "to suggest indirectly; to entail:  \"She implied she didn't believe his story.\" (n: implication)"),
    Entry(word: "improvidence", partOfSpeech: "n.", definition: "an absence of foresight; a failure to provide for future needs or events: \"Their improvidence resulted in the loss of their home.\""),
    Entry(word: "inchoate", partOfSpeech: "adj.", definition: "in an initial or early stage; incomplete; disorganized: \"The act of writing forces one to clarify incohate thoughts.\""),
    Entry(word: "incorrigible", partOfSpeech: "adj.", definition: "not capable of being corrected: \"The school board finally decided the James was incorrigible and expelled him from school.\""),
    Entry(word: "indelible", partOfSpeech: "adj.", definition: "permanent; unerasable; strong: \"The Queen made an indelible impression on her subjects.\""),
    Entry(word: "ineffable", partOfSpeech: "adj.", definition: "undescribable; inexpressible in words; unspeakable"),
    Entry(word: "infer", partOfSpeech: "v.", definition: "to deduce: \"New genetic evidence led some zoologists to infer that the red wolf is actually a hybrid of the coyote and the gray wolf.\""),
    Entry(word: "ingenious", partOfSpeech: "adj.", definition: "clever: \"She developed an ingenious method for testing her hypothesis.\"(n: ingenuity)"),
    Entry(word: "ingenuous", partOfSpeech: "adj.", definition: "unsophisticated; artless; straightforward; candid: \"Wilson's ingenuous response to the controversial calmed the suspicious listeners.\""),
    Entry(word: "inhibit", partOfSpeech: "v.", definition: "to hold back, prohibit, forbid, or restrain (n: inhibition, adj: inhibited)"),
    Entry(word: "innocuous", partOfSpeech: "adj.", definition: "harmless; having no adverse affect; not likely to provoke strong emotion"),
    Entry(word: "insensible", partOfSpeech: "adj.", definition: "numb; unconscious: \"Wayne was rendered insensible by a blow to the head.\" unfeeling; insensitive: \"They were insensibile to the suffering of others.\""),
    Entry(word: "insipid", partOfSpeech: "adj.", definition: "lacking zest or excitement; dull"),
    Entry(word: "insular", partOfSpeech: "adj.", definition: "of or pertaining to an island, thus, excessively exclusive: \"Newcomers found it difficult to make friends in the insular community.\""),
    Entry(word: "intransigent", partOfSpeech: "adj.", definition: "stubborn; immovable; unwilling to change: \"She was so intransigent we finally gave up trying to convince her.\" (n: intransigence)"),
    Entry(word: "irascible", partOfSpeech: "adj.", definition: "prone to outbursts of temper, easily angered"),
    Entry(word: "laconic", partOfSpeech: "adj.", definition: "using few words; terse: \"a laconic reply.\""),
    Entry(word: "latent", partOfSpeech: "adj.", definition: "present or potential but not evident or active (n: latency)"),
    Entry(word: "laudable", partOfSpeech: "adj.", definition: "praiseworthy; commendable (v. laud)"),
    Entry(word: "leviathan", partOfSpeech: "n.", definition: "giant whale, therefore, something very large"),
    Entry(word: "loquacious", partOfSpeech: "adj.", definition: "talkative"),
    Entry(word: "lucid", partOfSpeech: "adj.", definition: "clear; translucent: \"He made a lucid argument to support his theory.\""),
    Entry(word: "lugubrious", partOfSpeech: "adj.", definition: "weighty, mournful, or gloomy, especially to an excessive degree: \"Jake's lugubrious monologues depressed his friends.\""),
    Entry(word: "magnanimity", partOfSpeech: "n.", definition: "generosity and nobility. (adj: magnanimous)"),
    Entry(word: "malevolent", partOfSpeech: "adj.", definition: "malicious; evil; having or showing ill will: \"Some early American colonists saw the wilderness as malevolent and sought to control it.\""),
    Entry(word: "misanthrope", partOfSpeech: "n.", definition: "one who hates people: \"He was a true misanthrope and hated even himself.\""),
    Entry(word: "misnomer", partOfSpeech: "n.", definition: "incorrect name or word for something"),
    Entry(word: "misogynist", partOfSpeech: "n.", definition: "one who hates women"),
    Entry(word: "mitigate", partOfSpeech: "v.", definition: "to make less forceful; to become more moderate; to make less harsh or undesirable: \"He was trying to mitigate the damage he had done.\" (n: mitigation)"),
    Entry(word: "nefarious", partOfSpeech: "adj.", definition: "wicked, evil: \"a nefarious plot.\""),
    Entry(word: "noisome", partOfSpeech: "adj.", definition: "harmful, offensive, destructive: \"The noisome odor of the dump carried for miles.\""),
    Entry(word: "obdurate", partOfSpeech: "adj.", definition: "hardened against influence or feeling; intractable."),
    Entry(word: "obviate", partOfSpeech: "v.", definition: "to prevent by anticipatory measures; to make unnecessary:"),
    Entry(word: "occlude", partOfSpeech: "v.", definition: "to close or shut off; to obstruct (n: occlusion)"),
    Entry(word: "opaque", partOfSpeech: "adj.", definition: "not transparent or transluscent; dense; difficult to comprehend, as inopaque reasoning"),
    Entry(word: "ossified", partOfSpeech: "adj.", definition: "turned to bone; hardened like bone; Inflexible: \"The ossified culture failed to adapt to new economic conditions and died out.\""),
    Entry(word: "panegyric", partOfSpeech: "n.", definition: "a writing or speech in praise of a person or thing"),
    Entry(word: "peccadillo", partOfSpeech: "n.", definition: "a small sin or fault"),
    Entry(word: "pedantic", partOfSpeech: "adj.", definition: "showing a narrow concern for rules or formal book learning; making an excessive display of one's own learning: \"We quickly tired of his pedantic conversation.\" (n: pedant, pedantry)."),
    Entry(word: "perfidious", partOfSpeech: "adj.", definition: "deliberately treacherous; dishonest (n: perfidy)"),
    Entry(word: "petulant", partOfSpeech: "adj.", definition: "easily or frequently annoyed, especially over trivial matters; childishly irritable"),
    Entry(word: "philanthropy", partOfSpeech: "n.", definition: "tendency or action for the benefit of others, as in donating money or property to a charitible organization"),
    Entry(word: "phlegmatic", partOfSpeech: "adj.", definition: "not easily excited; cool; sluggish"),
    Entry(word: "placate", partOfSpeech: "v.", definition: "to calm or reduce anger by making concessions: \"The professor tried to placate his students by postponing the exam.\""),
    Entry(word: "plastic", partOfSpeech: "adj.", definition: "related to being shaped or molded; capable of being molded. (n: plasticity n: plastic)"),
    Entry(word: "plethora", partOfSpeech: "n.", definition: "excessively large quantity; overabundance: \"We received a p lethora of applications for the position.\""),
    Entry(word: "ponderous", partOfSpeech: "adj.", definition: "heavy; massive; awkward; dull: \"A ponderous book is better than a sleeping pill.\""),
    Entry(word: "pragmatic", partOfSpeech: "adj.", definition: "concerned with facts; practical, as opposed to highly principled or traditional: \"His pragmatic approach often offended idealists.\" (n: pragmatism)"),
    Entry(word: "precipice", partOfSpeech: "n.", definition: "cliff with a vertical or nearly vertical face; a dangerous place from which one is likely to fall; metaphorically, a very risky circumstance"),
    Entry(word: "precipitate", partOfSpeech: "v., n.", definition: "to fall; to fall downward suddenly and dramatically; to bring about or hasten the occurrence of something: \"Old World diseases precipitated a massive decline in the American Indian population.\""),
    Entry(word: "precursor", partOfSpeech: "n.", definition: "something (or someone) that precedes another: \"The assasination of the Archduke was a precursor to the war.\""),
    Entry(word: "prevaricate", partOfSpeech: "v.", definition: "to stray away from or evade the truth: \"When we asked him what his intentions were, he prevaricated.\"(n: prevarication; prevaricator)"),
    Entry(word: "prodigal", partOfSpeech: "adj.", definition: "rashly wasteful: \"Americans' prodigal devotion to the automobile is unique.\""),
    Entry(word: "propitiate", partOfSpeech: "v.", definition: "to conciliate; to appease: \"They made sacrifices to propitiate angry gods.\""),
    Entry(word: "ulchritudinous", partOfSpeech: "adj.", definition: "beautiful (n: pulchritude)"),
    Entry(word: "pusillanimous", partOfSpeech: "adj.", definition: "cowardly, timid, or irreselute; petty: \"The pusillanimous leader soon lost the respect of his people.\""),
    Entry(word: "quiescence", partOfSpeech: "n.", definition: "inactivity; stillness; dormancy (adj: quiescent)"),
    Entry(word: "rarefy", partOfSpeech: "v.", definition: "to make or become thin; to purify or refine (n: rarefaction, adj: rarefied)"),
    Entry(word: "reproof", partOfSpeech: "n.", definition: "the act of censuring, scolding, or rebuking. (v. reprove)."),
    Entry(word: "rescind", partOfSpeech: "v.", definition: "to repeal or annul"),
    Entry(word: "sagacious", partOfSpeech: "adj.", definition: "having a sharp or powerful intellect or discernment. (n: sagacity)."),
    Entry(word: "sanguine", partOfSpeech: "adj.", definition: "cheerful; confident: \"Her sanguine attitude put everyone at ease.\"(Sangfroid (noun) is a related French word meaning unflappibility. Literally, it means cold blood)"),
    Entry(word: "sate", partOfSpeech: "v.", definition: "to satisfy fully or to excess"),
    Entry(word: "saturnine", partOfSpeech: "adj.", definition: "having a gloomy or morose temperament"),
    Entry(word: "savant", partOfSpeech: "n.", definition: "a very knowledgable person; a genious"),
    Entry(word: "sedulous", partOfSpeech: "adj.", definition: "diligent; persevering; persistent: \"Her sedulous devotion to overcoming her background impressed many.\" (n: sedulity; sedulousness; adv. sedulously)"),
    Entry(word: "specious", partOfSpeech: "adj.", definition: "seemingly true but really false; deceptively convincing or attractive: \"Her argument, though specious, was readily accepted by many.\""),
    Entry(word: "superficial", partOfSpeech: "adj.", definition: "only covering the surface: \"A superficial treatment of the topic was all they wanted.\""),
    Entry(word: "tacit", partOfSpeech: "adj.", definition: "unspoken: \"Katie and carmella had a tacit agreement that they would not mention the dented fender to their parents.\""),
    Entry(word: "taciturn", partOfSpeech: "adj.", definition: "habitually untalkative or silent (n: taciturnity)"),
    Entry(word: "temperate", partOfSpeech: "adj.", definition: "exercising moderation and self-denial; calm or mild (n: temperance)"),
    Entry(word: "tirade", partOfSpeech: "n.", definition: "an angry speech: \"His tirade had gone on long enough.\""),
    Entry(word: "tortuous", partOfSpeech: "adj.", definition: "twisted; excessively complicated: \"Despite public complaints, tax laws and forms have become increasingly tortuous.\" Note: Don't confuse this with torturous."),
    Entry(word: "tractable", partOfSpeech: "adj.", definition: "ability to be easily managed or controlled: \"Her mother wished she were more tractable.\" (n: tractibility)"),
    Entry(word: "turpitude", partOfSpeech: "n.", definition: "depravity; baseness: \"Mr. Castor was fired for moral turpitude.\""),
    Entry(word: "tyro", partOfSpeech: "n.", definition: "beginner; person lacking experience in a specific endeavor: \"They easily took advantage of the tyro.\""),
    Entry(word: "vacuous", partOfSpeech: "adj.", definition: "empty; without contents; without ideas or intelligence:: \"He flashed a vacuous smile.\""),
    Entry(word: "venerate", partOfSpeech: "v.", definition: "great respect or reverence: \"The Chinese traditionally venerated their ancestors; ancestor worship is merely a popular misnomer for this tradition.\" (n: veneration, adj: venerable)"),
    Entry(word: "verbose", partOfSpeech: "adj.", definition: "wordy: \"The instructor asked her verbose student make her paper more concise.\" (n: verbosity)"),
    Entry(word: "vex", partOfSpeech: "v.", definition: "to annoy; to bother; to perplex; to puzzle; to debate at length: \"Franklin vexed his brother with his controversial writings.\""),
    Entry(word: "viscous", partOfSpeech: "adj.", definition: "slow moving; highly resistant to flow: \"Heintz commercials imply that their catsup is more viscous than others'.\" (n: viscosity)"),
    Entry(word: "volatile", partOfSpeech: "adj.", definition: "explosive; fickle (n: volatility)."),
    Entry(word: "voracious", partOfSpeech: "adj.", definition: "craving or devouring large quantities of food, drink, or other things. She is a voracious reader."),
    Entry(word: "waver", partOfSpeech: "v.", definition: "to hesitate or to tremble"),
    Entry(word: "wretched", partOfSpeech: "adj.", definition: "extremely pitiful or unfortunate (n: wretch)"),
    Entry(word: "zeal", partOfSpeech: "n.", definition: "enthusiastic devotion to a cause, ideal, or goal (n: zealot; zealoutry. adj: zealous)"),
]
