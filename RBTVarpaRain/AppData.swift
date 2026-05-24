import SwiftUI

enum AppData {
    static let almanac = [
        AlmanacArticle(
            id: "history",
            title: "History of Varpa",
            subtitle: "From Gotlandic stone throwing to organized precision play.",
            symbol: "map.fill",
            accent: BrandPalette.gold,
            readTime: "6 min read",
            imageKind: .history,
            lead: "Varpa is a Swedish precision throwing sport most closely tied to Gotland. Its appeal is old and direct: choose a flat stone or metal varpa, read the ground, and finish closer to the marker than the other side.",
            sections: [
                AlmanacSection(
                    id: "roots",
                    heading: "Gotland roots",
                    paragraphs: [
                        "The sport is widely associated with Gotland, where traditional games became part of local identity rather than a museum piece. Varpa sits beside other Gotlandic sports such as park and stangstortning: simple equipment, outdoor lanes, and a strong culture of local competition.",
                        "Many introductions describe varpa as a very old game, sometimes linked with Viking-age or older throwing traditions. The safest way to treat that claim is as cultural memory rather than a precisely dated rulebook: the modern sport has inherited an old idea and shaped it into organized play."
                    ]
                ),
                AlmanacSection(
                    id: "object",
                    heading: "From stone to metal",
                    paragraphs: [
                        "Early play used suitable flat stones. Organized play later introduced metal varpor because metal can be made more consistent in weight, diameter, balance, and grip. That consistency lets players compare skill instead of merely comparing lucky stones.",
                        "The object still behaves like a stone: it flies, lands, bites, skips, and slides. This is why varpa feels different from rolling games. The throw is not over when the object touches the ground."
                    ]
                ),
                AlmanacSection(
                    id: "today",
                    heading: "The modern game",
                    paragraphs: [
                        "Modern varpa can be played casually on a short lane or in match formats built around agreed distance, equal throws, and measurement to the marker. The classic full lane is commonly described around 20 meters, though training distances should adapt to age, space, and skill.",
                        "The sport rewards controlled power. A dramatic throw that flies well but slides long is usually worse than a quiet throw that lands flat and stays near the pin."
                    ]
                )
            ],
            takeaways: [
                "Varpa is mainly a precision sport, not a strength contest.",
                "Gotlandic tradition matters, but modern play needs clear local rules.",
                "The flat object makes landing and slide as important as the release."
            ]
        ),
        AlmanacArticle(
            id: "rules",
            title: "How a Match Works",
            subtitle: "The flow from lane setup to scoring a frame.",
            symbol: "checklist.checked",
            accent: BrandPalette.rainBlue,
            readTime: "5 min read",
            imageKind: .rules,
            lead: "A good varpa match starts with agreement: distance, surface, format, number of throws, and how measurements will be settled. Once that is clear, the game becomes beautifully clean.",
            sections: [
                AlmanacSection(
                    id: "setup",
                    heading: "Set the lane",
                    paragraphs: [
                        "Place the marker where both sides can see it clearly, then mark a throwing line. The line should be stable enough that players do not creep forward during a tense exchange.",
                        "Agree the distance before the first throw. Twenty meters is a common reference point for full-distance play, but a shorter distance is better for training, children, narrow grounds, or slippery conditions."
                    ]
                ),
                AlmanacSection(
                    id: "throwing",
                    heading: "Throw in equal turns",
                    paragraphs: [
                        "Each side receives the same number of throws in a frame. Singles can use one or more varpor per player; team formats should define order before the frame starts.",
                        "A legal throw begins behind the line. If someone steps over early, the group should apply its agreed fault rule: replay, count as a miss, or cancel the throw."
                    ]
                ),
                AlmanacSection(
                    id: "score",
                    heading: "Measure after rest",
                    paragraphs: [
                        "Measure only after the varpa has stopped. Use the nearest edge of the varpa and the nearest point of the marker. If the match is close, measure instead of guessing.",
                        "The closest legal throw wins the frame or scores according to the chosen match format. The app records lower miss distance as better because the target is proximity, not length."
                    ]
                )
            ],
            takeaways: [
                "Agree the format before throwing.",
                "Measure from the closest edge after the varpa stops.",
                "Keep equal throws and record conditions for fair comparison."
            ]
        ),
        AlmanacArticle(
            id: "technique",
            title: "Technique and Tactics",
            subtitle: "Release shape, landing angle, lane reading, and match decisions.",
            symbol: "scope",
            accent: BrandPalette.mint,
            readTime: "7 min read",
            imageKind: .technique,
            lead: "A strong varpa player is a good reader of small things: wrist angle, ground texture, wind, dampness, and opponent pressure. Technique is less about one perfect throw and more about repeatable adjustment.",
            sections: [
                AlmanacSection(
                    id: "release",
                    heading: "Release",
                    paragraphs: [
                        "The release should be clean enough that the varpa leaves the hand with a stable face. Too much wobble makes the first contact unpredictable; too flat and hard can create a long slide.",
                        "Many players think in three parts: line, height, and landing. Line sends the varpa toward the marker, height controls the first contact, and landing angle decides whether it bites or runs."
                    ]
                ),
                AlmanacSection(
                    id: "surface",
                    heading: "Reading the surface",
                    paragraphs: [
                        "Gräss can cushion a throw, gravel can kick the varpa sideways, clay can hold a landing when damp, and indoor lanes often reward repeatable speed. A match plan should name the surface because tactics change immediately.",
                        "Before a serious frame, look for slope, wet patches, loose stones, compacted strips, and shiny clay. These are not background details; they are part of the lane."
                    ]
                ),
                AlmanacSection(
                    id: "pressure",
                    heading: "Playing the frame",
                    paragraphs: [
                        "If the opponent is already close, a safe landing short of the marker may be better than a risky direct attack that slides past. If the frame is open, use the first throw to learn the lane.",
                        "The best journal notes are practical: what weight worked, where the varpa landed, how much it slid, and whether rain or wind changed the answer."
                    ]
                )
            ],
            takeaways: [
                "Stable face beats raw speed.",
                "Choose weight and line from the surface, not from habit.",
                "Record the miss pattern, then adjust one variable at a time."
            ]
        ),
        AlmanacArticle(
            id: "rain",
            title: "Rain and Weather Playbook",
            subtitle: "How dry lanes, light rain, heavy rain, and wind change decisions.",
            symbol: "cloud.rain.fill",
            accent: BrandPalette.glowBlue,
            readTime: "4 min read",
            imageKind: .rain,
            lead: "RBT Varpa Rain treats weather as match intelligence. Wet ground can slow the object, heavy rain can make release less reliable, and wind can expose throws with too much height.",
            sections: [
                AlmanacSection(
                    id: "dry",
                    heading: "Dry lanes",
                    paragraphs: [
                        "Dry ground usually gives the longest slide and the clearest feedback. If throws keep running past the marker, lower the speed before changing everything else.",
                        "On very dry gravel, avoid landing on loose patches if the lane lets you choose a firmer strip."
                    ]
                ),
                AlmanacSection(
                    id: "wet",
                    heading: "Rain",
                    paragraphs: [
                        "Light rain can make grass and clay more forgiving, but it can also make a metal varpa harder to hold. Keep a towel ready and note whether misses come from grip or from surface response.",
                        "Heavy rain often reduces slide but increases release error. A lower, calmer throw may beat a high throw that catches weather and lands unpredictably."
                    ]
                ),
                AlmanacSection(
                    id: "wind",
                    heading: "Wind",
                    paragraphs: [
                        "Wind punishes throws that spend too long in the air. Use a flatter, more direct line when possible, and watch whether crosswind affects the face angle at landing.",
                        "If the wind changes during a match, note it in the result journal. A good later review separates poor technique from genuinely different conditions."
                    ]
                )
            ],
            takeaways: [
                "Wet conditions are not automatically bad; they change the correct throw.",
                "Grip management matters in rain.",
                "Wind favors lower, more stable trajectories."
            ]
        ),
        AlmanacArticle(
            id: "training",
            title: "Training Sessions",
            subtitle: "Useful drills for distance control and match confidence.",
            symbol: "figure.strengthtraining.traditional",
            accent: BrandPalette.coral,
            readTime: "6 min read",
            imageKind: .training,
            lead: "A productive varpa practice is small and measurable. Pick one lane, one target, one goal, and write down the result. Repetition without notes is just exercise; repetition with feedback becomes skill.",
            sections: [
                AlmanacSection(
                    id: "ladder",
                    heading: "Distance ladder",
                    paragraphs: [
                        "Start at a comfortable short distance and throw three varpor. Move the marker farther only when the average miss is acceptable. This builds control without turning every practice into a full-distance struggle.",
                        "Use the app target distance slider to save the session distance and compare results later."
                    ]
                ),
                AlmanacSection(
                    id: "landing",
                    heading: "Landing zone drill",
                    paragraphs: [
                        "Place a visible landing zone before the marker. The goal is not to hit the marker directly, but to land in the zone and let the slide finish close.",
                        "This drill teaches the relationship between first contact and final position, which is the heart of varpa judgment."
                    ]
                ),
                AlmanacSection(
                    id: "pressure",
                    heading: "Pressure finish",
                    paragraphs: [
                        "End practice with a simple match simulation: three throws, only the best counts, and anything beyond the marker by more than a chosen limit is a dead throw.",
                        "Pressure drills should be short. The aim is to practice decision making, not to exhaust the throwing motion."
                    ]
                )
            ],
            takeaways: [
                "Practice one variable at a time.",
                "Track average miss, best miss, surface, and weather.",
                "Train landing zones, not only final distance."
            ]
        )
    ]

    static let features = [
        FeatureNote(id: "plan", title: "Match planning", body: "Schedule future matches with venue, format, surface, weather, target distance, and tactical notes.", symbol: "calendar.badge.plus", color: BrandPalette.rainBlue),
        FeatureNote(id: "record", title: "Result journal", body: "Record throw distances for both sides, compare best throws, and track win rate and average miss.", symbol: "list.bullet.clipboard.fill", color: BrandPalette.gold),
        FeatureNote(id: "gear", title: "Varpa kit", body: "Keep a local kit list with weight, diameter, material, notes, and a favorite match varpa.", symbol: "seal.fill", color: BrandPalette.mint),
        FeatureNote(id: "learn", title: "Almanac", body: "Read the sport history, core rules, unique details, and practical glossary without leaving the app.", symbol: "book.closed.fill", color: BrandPalette.coral)
    ]

    static let rulesChecklist: [RuleGuide] = [
        RuleGuide(
            id: "marker",
            title: "Set marker and distance",
            summary: "Agree the target point and lane length before the frame begins.",
            detail: "The marker must be visible and fixed. For full-distance play, 20 meters is a common reference distance; for practice, shorten the lane and record the exact distance in the planner.",
            imageKind: .marker
        ),
        RuleGuide(
            id: "line",
            title: "Throw from behind the line",
            summary: "Release must begin behind the throwing line.",
            detail: "A player should not step over the line before release. Decide before the match whether a foot fault is replayed, cancelled, or counted as a miss.",
            imageKind: .line
        ),
        RuleGuide(
            id: "measure",
            title: "Measure closest edge",
            summary: "Measure from the marker to the nearest edge of the stopped varpa.",
            detail: "Do not measure while the object is still moving. In close frames, use a tape or cord and compare the shortest distance from the marker to each varpa.",
            imageKind: .measuring
        ),
        RuleGuide(
            id: "equal",
            title: "Use equal throws",
            summary: "Each side gets the same number of attempts in the frame.",
            detail: "Singles, pairs, and team play can use different orders, but the count should remain equal. The app result journal works best when both sides log the same agreed set.",
            imageKind: .equalThrows
        ),
        RuleGuide(
            id: "surface",
            title: "Declare conditions",
            summary: "Surface and weather belong to the match record.",
            detail: "Gräss, gravel, clay, indoor lanes, rain, and wind can all change the correct throw. Recording conditions makes later performance review fairer and more useful.",
            imageKind: .surface
        ),
        RuleGuide(
            id: "score",
            title: "Closest legal throw wins",
            summary: "Lower distance from the marker is better.",
            detail: "If the closest legal throw belongs to your side, you win the frame or score under the chosen local format. RBT Varpa Rain therefore treats smaller measured distance as the better result.",
            imageKind: .scoring
        )
    ]

    static let glossary: [GlossaryEntry] = [
        GlossaryEntry(id: "varpa", term: "Varpa", definition: "The flat throwing object, traditionally a stone and often a metal object in organized play.", usage: "Log weight and diameter in Kit because each varpa lands and slides differently.", symbol: "seal.fill"),
        GlossaryEntry(id: "marker", term: "Marker", definition: "The target pin, stick, or visible point that all throws are measured against.", usage: "A clear marker prevents arguments in close frames.", symbol: "scope"),
        GlossaryEntry(id: "lane", term: "Lane", definition: "The throwing area between the line and the marker, including its slope, texture, and hazards.", usage: "Planner notes should name the lane when a venue has several surfaces.", symbol: "map.fill"),
        GlossaryEntry(id: "throwing-line", term: "Throwing line", definition: "The boundary behind which a legal throw begins.", usage: "Mark it with tape, chalk, rope, or a stable natural edge.", symbol: "line.diagonal"),
        GlossaryEntry(id: "frame", term: "Frame", definition: "One scoring exchange after both sides complete their agreed throws.", usage: "Use the same number of throws per frame for clean comparison.", symbol: "rectangle.stack.fill"),
        GlossaryEntry(id: "miss-distance", term: "Miss distance", definition: "The measured distance between the marker and the nearest edge of a stopped varpa.", usage: "In this app, lower miss distance means a better throw.", symbol: "ruler.fill"),
        GlossaryEntry(id: "bite", term: "Bite", definition: "How strongly the varpa catches the surface at first contact.", usage: "Wet clay usually gives more bite than loose dry gravel.", symbol: "hand.tap.fill"),
        GlossaryEntry(id: "slide", term: "Slide", definition: "The final travel after the first ground contact.", usage: "A throw can look perfect in the air and still lose by sliding long.", symbol: "arrow.right.to.line"),
        GlossaryEntry(id: "landing zone", term: "Landing zone", definition: "The intended first-contact area before the marker.", usage: "Advanced players aim for a landing zone, not only for the pin.", symbol: "target"),
        GlossaryEntry(id: "face angle", term: "Face angle", definition: "The tilt of the flat varpa as it lands.", usage: "A stable face angle makes bounce and slide more predictable.", symbol: "rotate.3d"),
        GlossaryEntry(id: "weight", term: "Weight", definition: "The heaviness of the varpa, which affects flight, bite, and response to wind.", usage: "Use heavier gear notes for wet or windy match days if it performs better.", symbol: "scalemass.fill"),
        GlossaryEntry(id: "diameter", term: "Diameter", definition: "The width of the varpa across its face.", usage: "Diameter changes grip comfort and how the object presents to the ground.", symbol: "circle.dotted"),
        GlossaryEntry(id: "surface", term: "Surface", definition: "The ground type: grass, gravel, clay, indoor mat, sand, or a local mix.", usage: "Always save surface with results so averages are meaningful.", symbol: "square.grid.3x3.fill"),
        GlossaryEntry(id: "wet-lane", term: "Wet lane", definition: "A lane changed by rain, dew, or standing moisture.", usage: "Treat it as a new tactical problem, not as the same lane with worse weather.", symbol: "cloud.rain.fill"),
        GlossaryEntry(id: "foot-fault", term: "Foot fault", definition: "A throw where the player crosses the line too early or breaks the agreed stance rule.", usage: "Agree the penalty before the first competitive throw.", symbol: "figure.walk"),
        GlossaryEntry(id: "replay", term: "Replay", definition: "A repeated throw used when local rules cancel a fault or outside interference.", usage: "Use sparingly; too many replays make match records unclear.", symbol: "arrow.counterclockwise"),
        GlossaryEntry(id: "best throw", term: "Best throw", definition: "The closest legal throw recorded by a side in a frame or match.", usage: "The Result Journal compares your best throw with the opponent best.", symbol: "star.fill"),
        GlossaryEntry(id: "average miss", term: "Average miss", definition: "The mean distance of a group of throws from the marker.", usage: "Average miss is better for training review than one lucky perfect throw.", symbol: "chart.line.uptrend.xyaxis"),
        GlossaryEntry(id: "safe throw", term: "Safe throw", definition: "A controlled attempt that avoids a big miss even if it may not win immediately.", usage: "Use it when the opponent has already thrown poorly and you only need a stable score.", symbol: "shield.fill"),
        GlossaryEntry(id: "attack throw", term: "Attack throw", definition: "A higher-risk attempt aimed at beating a strong opponent position.", usage: "Useful late in a frame when safe placement cannot win.", symbol: "bolt.fill"),
        GlossaryEntry(id: "read", term: "Read", definition: "The player's judgment of surface, wind, slope, and previous throws.", usage: "Good notes improve your future lane read.", symbol: "eye.fill"),
        GlossaryEntry(id: "format", term: "Format", definition: "The match structure: singles, pairs, teams, target score, or fixed throw count.", usage: "Save the format in Planner so both players arrive with the same expectation.", symbol: "list.bullet.rectangle.fill")
    ]

    static func almanac(language: AppLanguage) -> [AlmanacArticle] {
        language == .swedish ? swedishAlmanac : almanac
    }

    static func features(language: AppLanguage) -> [FeatureNote] {
        language == .swedish ? swedishFeatures : features
    }

    static func rulesChecklist(language: AppLanguage) -> [RuleGuide] {
        language == .swedish ? swedishRulesChecklist : rulesChecklist
    }

    static func glossary(language: AppLanguage) -> [GlossaryEntry] {
        language == .swedish ? swedishGlossary : glossary
    }

    private static let swedishFeatures = [
        FeatureNote(id: "plan", title: "Matchplanering", body: "Schemalägg kommande matcher med plats, format, underlag, väder, målavstånd och taktiska anteckningar.", symbol: "calendar.badge.plus", color: BrandPalette.rainBlue),
        FeatureNote(id: "record", title: "Resultatjournal", body: "Registrera kastavstånd för båda sidor, jämför bästa kast och följ vinstgrad och genomsnittlig avvikelse.", symbol: "list.bullet.clipboard.fill", color: BrandPalette.gold),
        FeatureNote(id: "gear", title: "Varpa-utrustning", body: "Håll en lokal utrustningslista med vikt, diameter, material, anteckningar och favoritvarpa för match.", symbol: "seal.fill", color: BrandPalette.mint),
        FeatureNote(id: "learn", title: "Almanacka", body: "Läs sportens historia, grundregler, särskilda detaljer och praktisk ordlista utan att lämna appen.", symbol: "book.closed.fill", color: BrandPalette.coral)
    ]

    private static let swedishAlmanac = [
        AlmanacArticle(
            id: "history",
            title: "Varpans historia",
            subtitle: "Från gotländskt stenkastande till organiserat precisionsspel.",
            symbol: "map.fill",
            accent: BrandPalette.gold,
            readTime: "6 min läsning",
            imageKind: .history,
            lead: "Varpa är en svensk precisionssport starkt förknippad med Gotland. Spelets idé är enkel och kräver omdöme: välj en flat sten eller metallvarpa, läs underlaget och stanna närmare markören än motståndaren.",
            sections: [
                AlmanacSection(id: "roots", heading: "Gotländska rötter", paragraphs: [
                    "Varpa hör hemma i den gotländska idrottskulturen, där traditionella lekar har levt vidare som tävling och socialt sammanhang. Den nämns ofta tillsammans med andra gotländska grenar som park och stangstortning.",
                    "Spelet beskrivs ofta som mycket gammalt. Exakta ursprung är svåra att fastslå, men den moderna sporten bär tydligt med sig en äldre kasttradition som senare fått tydligare regler och matchformer."
                ]),
                AlmanacSection(id: "object", heading: "Från sten till metall", paragraphs: [
                    "Tidigt spel använde lämpliga flata stenar. I organiserad varpa används också metallvarpor eftersom vikt, diameter, balans och grepp kan göras mer konsekventa.",
                    "Trots modern utrustning beter sig varpan fortfarande som ett kastat fält objekt: den flyger, landar, biter, studsar och glider. Därför är kastet inte slut när varpan träffar marken."
                ]),
                AlmanacSection(id: "today", heading: "Dagens spel", paragraphs: [
                    "Modern varpa kan spelas avslappnat på kortare bana eller i matchformat med överenskommet avstånd, lika många kast och mätning mot markören. Ett vanligt referensavstånd för full bana är omkring 20 meter.",
                    "Sporten belönar kontrollerad kraft. Ett dramatiskt kast som glider förbi markören är ofta sämre än ett lugnt kast som landar stabilt och stannar nära."
                ])
            ],
            takeaways: [
                "Varpa är främst en precisionssport, inte en styrketävling.",
                "Gotländsk tradition är central, men modern match kräver tydliga lokala regler.",
                "Den flata varpan gör landning och glid lika viktiga som själva utsläppet."
            ]
        ),
        AlmanacArticle(
            id: "rules",
            title: "Så fungerar en match",
            subtitle: "Från banbygge till poäng i en omgång.",
            symbol: "checklist.checked",
            accent: BrandPalette.rainBlue,
            readTime: "5 min läsning",
            imageKind: .rules,
            lead: "En bra varpamatch börjar med en överenskommelse: avstånd, underlag, format, antal kast och hur mätning avgörs. När det är klart blir spelet rent och tydligt.",
            sections: [
                AlmanacSection(id: "setup", heading: "Sätt banan", paragraphs: [
                    "Placera markören så att båda sidor ser den tydligt och markera en kastlinje. Linjen ska vara tillräckligt tydlig för att ingen ska krypa framåt i pressade lagen.",
                    "Kom överens om avstånd före första kastet. Kortare avstånd är ofta bättre för träning, yngre spelare eller hala förhållanden."
                ]),
                AlmanacSection(id: "throwing", heading: "Kasta i lika turer", paragraphs: [
                    "Varje sida får samma antal kast i en omgång. Singel, par och lagspel kan ha olika kastordning, men ordningen ska vara bestämd innan omgångens start.",
                    "Ett giltigt kast börjar bakom linjen. Om någon kliver över för tidigt ska felet hanteras enligt den regel gruppen bestämt före matchen."
                ]),
                AlmanacSection(id: "score", heading: "Mät när varpan ligger still", paragraphs: [
                    "Mät bara när varpan här stannat. Använd närmaste kanten på varpan och närmaste punkt på markören. Vid jämna lagen ska ni mäta, inte gissa.",
                    "Närmaste giltiga kast vinner omgång eller ger poäng enligt valt format. Appen behandlar därför mindre avvikelse som bättre resultat."
                ])
            ],
            takeaways: [
                "Bestäm formatet före första kastet.",
                "Mät från närmaste kant när varpan ligger still.",
                "Spara underlag och väder för rättvis analys senare."
            ]
        ),
        AlmanacArticle(
            id: "technique",
            title: "Teknik och taktik",
            subtitle: "Utsläpp, landningsvinkel, banläsning och matchbeslut.",
            symbol: "scope",
            accent: BrandPalette.mint,
            readTime: "7 min läsning",
            imageKind: .technique,
            lead: "En stark varpaspelare läser små saker: handledsvinkel, markens struktur, vind, fukt och motståndarens press. Teknik handlar om upprepbar justering, inte ett enda perfekt kast.",
            sections: [
                AlmanacSection(id: "release", heading: "Utsläpp", paragraphs: [
                    "Utsläppet ska vara rent nog för att varpan lämnar handen med stabil sida. För mycket vobbel gör första markkontakten svår att förutse.",
                    "Tänk i tre delar: linje, höjd och landning. Linjen skickar varpan mot markören, höjden styr första kontakten och landningsvinkeln avgör om den biter eller rinner."
                ]),
                AlmanacSection(id: "surface", heading: "Läs underlaget", paragraphs: [
                    "Gräs kan dämpa kastet, grus kan sparka varpan i sidled, lera kan hålla landningen när den är fuktig och inomhusbanor belönar ofta jämn fart.",
                    "Titta efter lutning, våta fläckar, lösa stenar, hårdpackade remsor och blank lera. Det är inte bakgrund, det är banan."
                ]),
                AlmanacSection(id: "pressure", heading: "Spela omgångens läge", paragraphs: [
                    "Om motståndaren redan ligger nära kan ett säkert kast kort om markören vara bättre än en riskfylld attack som glider förbi.",
                    "Bra anteckningar är praktiska: vilken vikt fungerade, var landade varpan, hur långt gled den och om regn eller vind ändrade svaret."
                ])
            ],
            takeaways: [
                "Stabil sida är viktigare än ren fart.",
                "Välj vikt och linje efter underlaget, inte vana.",
                "Ändra en variabel i taget när du justerar."
            ]
        ),
        AlmanacArticle(
            id: "rain",
            title: "Regn och väder",
            subtitle: "Hur torrt, lätt regn, kraftigt regn och vind ändrar besluten.",
            symbol: "cloud.rain.fill",
            accent: BrandPalette.glowBlue,
            readTime: "4 min läsning",
            imageKind: .rain,
            lead: "RBT Varpa Rain behandlar väder som matchinformation. Vått underlag kan bromsa varpan, kraftigt regn kan göra greppet sämre och vind avslöjar kast med för hög bana.",
            sections: [
                AlmanacSection(id: "dry", heading: "Torr bana", paragraphs: [
                    "Torr mark ger ofta längst glid och tydligast återkoppling. Om kasten hela tiden rinner förbi markören, sänk farten innan du ändrar allt annat.",
                    "På mycket torrt grus bör du undvika lösa partier om banan ger möjlighet att välja en fastare remsa."
                ]),
                AlmanacSection(id: "wet", heading: "Regn", paragraphs: [
                    "Lätt regn kan göra gräs och lera mer förlåtande, men metallvarpan kan bli svårare att hålla. Ha handduk redo och notera om missarna kommer från grepp eller underlag.",
                    "Kraftigt regn minskar ofta glidet men ökar risken för fel utsläpp. Ett lägre, lugnare kast kan slå ett högt kast som påverkas av väder."
                ]),
                AlmanacSection(id: "wind", heading: "Vind", paragraphs: [
                    "Vind straffar kast som är för länge i luften. Använd en flackare och mer direkt linje när det går.",
                    "Om vinden växlar under matchen ska det in i resultatjournalen. Bra analys skiljer dålig teknik från andra förhållanden."
                ])
            ],
            takeaways: [
                "Vått väder är inte automatiskt dåligt; det ändrar rätt kast.",
                "Greppkontroll är en del av regnspelet.",
                "Vind premierar lägre och stabilare banor."
            ]
        ),
        AlmanacArticle(
            id: "training",
            title: "Träningspass",
            subtitle: "Drillar för avståndskontroll och matchtrygghet.",
            symbol: "figure.strengthtraining.traditional",
            accent: BrandPalette.coral,
            readTime: "6 min läsning",
            imageKind: .training,
            lead: "Ett bra varpapass är litet och mätbart. Välj en bana, ett mål, ett fokus och skriv ner resultatet. Repetition med återkoppling blir skicklighet.",
            sections: [
                AlmanacSection(id: "ladder", heading: "Avståndsstegen", paragraphs: [
                    "Börja på kort bekvamt avstånd och kasta tre varpor. Flytta markören längre bort först när genomsnittlig avvikelse är acceptabel.",
                    "Använd appens målavstånd för att spara träningsdistansen och jämföra senare."
                ]),
                AlmanacSection(id: "landing", heading: "Landningszon", paragraphs: [
                    "Markera en landningszon före markören. Målet är inte att träffa pinnen direkt, utan att landa rätt och låta glidet avsluta nära.",
                    "Drillen lär sambandet mellan första kontakt och slutposition, vilket är kärnan i varpans omdöme."
                ]),
                AlmanacSection(id: "pressure", heading: "Pressavslut", paragraphs: [
                    "Avsluta med en kort matchsimulering: tre kast, bästa räknas och allt som glider för långt förbi markören är dött.",
                    "Pressdrillar ska vara korta. Målet är beslutsfattande, inte att trötta ut kaströrelsen."
                ])
            ],
            takeaways: [
                "Träna en variabel i taget.",
                "Följ genomsnittlig avvikelse, bästa kast, underlag och väder.",
                "Träna landningszoner, inte bara slutavstånd."
            ]
        )
    ]

    private static let swedishRulesChecklist = [
        RuleGuide(id: "marker", title: "Sätt markör och avstånd", summary: "Kom överens om målpunkt och banlängd före omgångens start.", detail: "Markören ska vara synlig och fast. 20 meter är en vanlig referens för full bana; korta banan vid träning och spara exakt avstånd i planeringen.", imageKind: .marker),
        RuleGuide(id: "line", title: "Kasta bakom linjen", summary: "Kastet ska borja bakom kastlinjen.", detail: "Spelaren ska inte kliva över linjen före utsläpp. Bestäm före matchen om fotfel spelas om, stryks eller räknas som miss.", imageKind: .line),
        RuleGuide(id: "measure", title: "Mät närmaste kant", summary: "Mät från markören till närmaste kanten på stillaliggande varpa.", detail: "Mät inte medan varpan rör sig. Vid jämna omgångar används mättband eller snöre för att jämföra kortaste avståndet.", imageKind: .measuring),
        RuleGuide(id: "equal", title: "Lika många kast", summary: "Varje sida får samma antal försök i omgångens ram.", detail: "Singel, par och lag kan ha olika ordning, men antalet ska vara lika. Resultatjournalen fungerar bäst när båda sidor loggar samma överenskomna serie.", imageKind: .equalThrows),
        RuleGuide(id: "surface", title: "Ange förhållanden", summary: "Underlag och väder hör till matchposten.", detail: "Gräs, grus, lera, inomhusbana, regn och vind kan förändra rätt kast. Därför blir analysen bättre när förhållanden sparas.", imageKind: .surface),
        RuleGuide(id: "score", title: "Närmaste giltiga kast vinner", summary: "Lägst avstånd från markören är bäst.", detail: "Om närmaste giltiga kast tillhör din sida vinner du omgång eller får poäng enligt lokalt format. Appen behandlar därför mindre uppmätt avstånd som bättre.", imageKind: .scoring)
    ]

    private static let swedishGlossary: [GlossaryEntry] = [
        GlossaryEntry(id: "varpa", term: "Varpa", definition: "Det flata kastföremålet, traditionellt sten och ofta metall i organiserat spel.", usage: "Spara vikt och diameter i Utrustning eftersom varje varpa landar och glider olika.", symbol: "seal.fill"),
        GlossaryEntry(id: "marker", term: "Markör", definition: "Målpinne eller synlig punkt som alla kast mäts mot.", usage: "En tydlig markör förebygger tvister i jämna omgångar.", symbol: "scope"),
        GlossaryEntry(id: "lane", term: "Bana", definition: "Området mellan kastlinje och markör, inklusive lutning, textur och hinder.", usage: "Skriv banans namn i planeringen när platsen har flera underlag.", symbol: "map.fill"),
        GlossaryEntry(id: "throwing-line", term: "Kastlinje", definition: "Gränsen bakom vilken ett giltigt kast börjar.", usage: "Markera med tejp, krita, rep eller en stabil naturlig kant.", symbol: "line.diagonal"),
        GlossaryEntry(id: "frame", term: "Omgång", definition: "En poängväxling efter att båda sidor gjort sina överenskomna kast.", usage: "Använd lika många kast per omgång för ren jämförelse.", symbol: "rectangle.stack.fill"),
        GlossaryEntry(id: "miss-distance", term: "Avvikelse", definition: "Uppmätt avstånd mellan markör och närmaste kant på en stillaliggande varpa.", usage: "I appen betyder lägre avvikelse ett bättre kast.", symbol: "ruler.fill"),
        GlossaryEntry(id: "bite", term: "Bett", definition: "Hur starkt varpan tar i underlaget vid första kontakten.", usage: "Fuktig lera ger ofta mer bett än löst torrt grus.", symbol: "hand.tap.fill"),
        GlossaryEntry(id: "slide", term: "Glid", definition: "Den sista rörelsen efter första markkontakten.", usage: "Ett kast kan se perfekt ut i luften men förlora genom att glida för långt.", symbol: "arrow.right.to.line"),
        GlossaryEntry(id: "landing-zone", term: "Landningszon", definition: "Den planerade första kontaktytan före markören.", usage: "Avancerade spelare siktar på landningszon, inte bara på pinnen.", symbol: "target"),
        GlossaryEntry(id: "face-angle", term: "Sidvinkel", definition: "Vinkeln på varpans flata sida när den landar.", usage: "Stabil sidvinkel gör studs och glid mer förutsägbara.", symbol: "rotate.3d"),
        GlossaryEntry(id: "weight", term: "Vikt", definition: "Varpans tyngd, som påverkar flykt, bett och vindkänslighet.", usage: "Notera tyngre varpor för regniga eller blåsiga matcher om de fungerar bättre.", symbol: "scalemass.fill"),
        GlossaryEntry(id: "diameter", term: "Diameter", definition: "Varpans bredd över den flata sidan.", usage: "Diameter påverkar grepp och hur föremålet möter marken.", symbol: "circle.dotted"),
        GlossaryEntry(id: "surface", term: "Underlag", definition: "Marktypen: gräs, grus, lera, inomhusmatta, sand eller lokal blandning.", usage: "Spara alltid underlag med resultat så snitt blir meningsfulla.", symbol: "square.grid.3x3.fill"),
        GlossaryEntry(id: "wet-lane", term: "Våt bana", definition: "En bana förändrad av regn, dagg eller fukt.", usage: "Behandla den som ett nytt taktiskt problem, inte bara samma bana i sämre väder.", symbol: "cloud.rain.fill"),
        GlossaryEntry(id: "foot-fault", term: "Fotfel", definition: "Ett kast där spelaren kliver över linjen för tidigt eller bryter överenskommen stance.", usage: "Bestäm straffet före första tävlingskastet.", symbol: "figure.walk"),
        GlossaryEntry(id: "replay", term: "Omkast", definition: "Ett upprepat kast vid lokala regler, fel eller yttre störning.", usage: "Använd sparsamt; för många omkast gör matchloggen otydlig.", symbol: "arrow.counterclockwise"),
        GlossaryEntry(id: "best-throw", term: "Bästa kast", definition: "Det närmaste giltiga kastet för en sida i omgång eller match.", usage: "Resultatjournalen jämför ditt bästa kast med motståndarens bästa.", symbol: "star.fill"),
        GlossaryEntry(id: "average-miss", term: "Snittavvikelse", definition: "Medelavståndet för en grupp kast från markören.", usage: "Snittavvikelse är bättre träningsmått än ett enda lyckokast.", symbol: "chart.line.uptrend.xyaxis"),
        GlossaryEntry(id: "safe-throw", term: "Sakert kast", definition: "Ett kontrollerat försök som undviker stor miss även om det inte direkt vinner.", usage: "Använd när motståndaren redan kastat svagt och du behöver stabilitet.", symbol: "shield.fill"),
        GlossaryEntry(id: "attack-throw", term: "Attackkast", definition: "Ett mer riskfyllt försök för att slå en stark motståndarposition.", usage: "Använd sent i omgångar när säkert läge inte kan vinna.", symbol: "bolt.fill"),
        GlossaryEntry(id: "read", term: "Läsning", definition: "Spelarens bedömning av underlag, vind, lutning och tidigare kast.", usage: "Bra anteckningar förbättrar framtida banläsning.", symbol: "eye.fill"),
        GlossaryEntry(id: "format", term: "Format", definition: "Matchstrukturen: singel, par, lag, målpoäng eller fast kastantal.", usage: "Spara formatet i Planering så alla kommer med samma förväntningar.", symbol: "list.bullet.rectangle.fill")
    ]
}
