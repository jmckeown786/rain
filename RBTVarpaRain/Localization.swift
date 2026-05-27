import SwiftUI

enum AppLanguage: String, CaseIterable, Identifiable {
    case english = "en"
    case swedish = "sv"

    var id: String { rawValue }

    var shortTitle: String {
        switch self {
        case .english: "EN"
        case .swedish: "SV"
        }
    }

    var title: String {
        switch self {
        case .english: "English"
        case .swedish: "Svenska"
        }
    }
}

enum L {
    static func sectionTitle(_ section: AppSection, _ language: AppLanguage) -> String {
        switch language {
        case .english:
            switch section {
            case .dashboard: "Home"
            case .planner: "Planner"
            case .results: "Results"
            case .more: "More"
            case .almanac: "Almanac"
            case .kit: "Kit"
            case .profile: "Profile"
            }
        case .swedish:
            switch section {
            case .dashboard: "Hem"
            case .planner: "Planering"
            case .results: "Resultat"
            case .more: "Mer"
            case .almanac: "Almanacka"
            case .kit: "Utrustning"
            case .profile: "Profil"
            }
        }
    }

    static func surface(_ surface: SurfaceType, _ language: AppLanguage) -> String {
        switch language {
        case .english: surface.title
        case .swedish:
            switch surface {
            case .grass: "Gräs"
            case .gravel: "Grus"
            case .clay: "Lera"
            case .indoor: "Inomhus"
            }
        }
    }

    static func weather(_ weather: WeatherCondition, _ language: AppLanguage) -> String {
        switch language {
        case .english: weather.title
        case .swedish:
            switch weather {
            case .dry: "Torrt"
            case .lightRain: "Lätt regn"
            case .heavyRain: "Kraftigt regn"
            case .wind: "Vind"
            }
        }
    }

    static func text(_ key: Key, _ language: AppLanguage) -> String {
        switch language {
        case .english: en(key)
        case .swedish: sv(key)
        }
    }

    enum Key {
        case language
        case homeHeroTitle, homeToolsTitle, homeToolsSubtitle, planMatch, productTools
        case planned, wins, bestMiss
        case onboardingTitle, onboardingBody, onboardingButton, classicLane, kitItems, localData
        case plannerTitle, plannerSubtitle, newMatch, opponentTeam, venueLane, date, matchFormat
        case targetDistance, notes, saveMatchPlan, upcoming, upcomingSubtitle
        case surface, weather, target
        case resultsTitle, resultsSubtitle, recordGame, opponent, venue, yourThrow1, yourThrow2, yourThrow3
        case opponentThrow1, opponentThrow2, opponentThrow3, yourBest, best, average, history, historySubtitle
        case saveResult, win, chase
        case kitTitle, kitSubtitle, favoriteMatchVarpa, weight, diameter, material
        case profileTitle, profileSubtitle, localProfile, playerName, clubName, games, avgMiss
        case readiness, readinessSubtitle, plannerOpened, firstResultSaved, kitFavoriteSet, measuredUnderHalf
        case data, dataSubtitle, saveProfile, replayOnboarding, resetLocalData, resetTitle, cancel, reset
        case resetMessage, ready, open
        case almanacTitle, almanacSubtitle, readLane, articles, rules, glossary, fieldTakeaways
        case closestWins, nearestEdge
    }

    private static func en(_ key: Key) -> String {
        switch key {
        case .language: "Language"
        case .homeHeroTitle: "Next Varpa session is mapped."
        case .homeToolsTitle, .productTools: "Product tools"
        case .homeToolsSubtitle: "The app covers the full club loop: learn the sport, plan matches, log throws, and manage varpa equipment."
        case .planMatch: "Plan match"
        case .planned: "planned"
        case .wins: "wins"
        case .bestMiss: "best miss"
        case .onboardingTitle: "Plan, play, record, and understand Varpa."
        case .onboardingBody: "Varpa Rain is a complete local companion for the Swedish precision sport: history, rules, match planning, result logging, and kit notes in one app."
        case .onboardingButton: "Enter Varpa Rain"
        case .classicLane: "classic lane"
        case .kitItems: "kit items"
        case .localData: "local data"
        case .plannerTitle: "Match Planner"
        case .plannerSubtitle: "Build a real Varpa match card before players arrive: opponent, lane, format, conditions, and tactical notes."
        case .newMatch: "New match"
        case .opponentTeam: "Opponent or team"
        case .venueLane: "Venue or lane"
        case .date: "Date"
        case .matchFormat: "Match format"
        case .targetDistance: "Target distance"
        case .notes: "Notes"
        case .saveMatchPlan: "Save match plan"
        case .upcoming: "Upcoming"
        case .upcomingSubtitle: "Tap delete after a match is complete or when the fixture changes."
        case .surface: "surface"
        case .weather: "weather"
        case .target: "target"
        case .resultsTitle: "Result Journal"
        case .resultsSubtitle: "Record match outcomes by measured distance from the marker. Småller distance wins, so the app treats lower as better."
        case .recordGame: "Record game"
        case .opponent: "Opponent"
        case .venue: "Venue"
        case .yourThrow1: "Your throw 1"
        case .yourThrow2: "Your throw 2"
        case .yourThrow3: "Your throw 3"
        case .opponentThrow1: "Opponent throw 1"
        case .opponentThrow2: "Opponent throw 2"
        case .opponentThrow3: "Opponent throw 3"
        case .yourBest: "your best"
        case .best: "best"
        case .average: "average"
        case .history: "History"
        case .historySubtitle: "Local match log with best throw, average miss, surface, and weather."
        case .saveResult: "Save result"
        case .win: "Win"
        case .chase: "Chase"
        case .kitTitle: "Varpa Kit"
        case .kitSubtitle: "A product-ready club companion needs equipment memory: material, weight, diameter, and field notes."
        case .favoriteMatchVarpa: "Favorite match varpa"
        case .weight: "weight"
        case .diameter: "diameter"
        case .material: "material"
        case .profileTitle: "Profile"
        case .profileSubtitle: "Local player identity, club stats, onboarding, and privacy-friendly data controls."
        case .localProfile: "Varpa Rain local profile"
        case .playerName: "Player name"
        case .clubName: "Club name"
        case .games: "games"
        case .avgMiss: "avg miss"
        case .readiness: "Readiness"
        case .readinessSubtitle: "Simple local achievements that reflect actual product usage."
        case .plannerOpened: "Planner opened"
        case .firstResultSaved: "First result saved"
        case .kitFavoriteSet: "Kit favorite set"
        case .measuredUnderHalf: "Measured under 0.5 m"
        case .data: "Data"
        case .dataSubtitle: "All plans, results, kit notes, and profile details are stored locally on this device."
        case .saveProfile: "Save profile"
        case .replayOnboarding: "Replay onboarding"
        case .resetLocalData: "Reset local data"
        case .resetTitle: "Reset local data?"
        case .cancel: "Cancel"
        case .reset: "Reset"
        case .resetMessage: "This restores the sample match, sample result, kit list, and profile defaults."
        case .ready: "Ready"
        case .open: "Open"
        case .almanacTitle: "Varpa Almanac"
        case .almanacSubtitle: "Articles, illustrated rules, and a practical vocabulary for match day."
        case .readLane: "Read the lane before the throw."
        case .articles: "Articles"
        case .rules: "Rules"
        case .glossary: "Glossary"
        case .fieldTakeaways: "Field takeaways"
        case .closestWins: "closest wins"
        case .nearestEdge: "nearest edge"
        }
    }

    private static func sv(_ key: Key) -> String {
        switch key {
        case .language: "Språk"
        case .homeHeroTitle: "Nästa varpapass är planerat."
        case .homeToolsTitle, .productTools: "Produktverktyg"
        case .homeToolsSubtitle: "Appen täcker hela klubbflödet: lär dig sporten, planera matcher, logga kast och håll ordning på varporna."
        case .planMatch: "Planera match"
        case .planned: "planerade"
        case .wins: "vinster"
        case .bestMiss: "bästa avvikelse"
        case .onboardingTitle: "Planera, spela, registrera och första varpa."
        case .onboardingBody: "Varpa Rain är en komplett lokal följeslagare för den svenska precisionssporten: historia, regler, matchplanering, resultatlogg och utrustningsanteckningar i samma app."
        case .onboardingButton: "Öppna Varpa Rain"
        case .classicLane: "klassisk bana"
        case .kitItems: "utrustning"
        case .localData: "lokal data"
        case .plannerTitle: "Matchplanering"
        case .plannerSubtitle: "Bygg ett riktigt matchkort innan spelarna kommer: motståndare, bana, format, förhållanden och taktiska anteckningar."
        case .newMatch: "Ny match"
        case .opponentTeam: "Motståndare eller lag"
        case .venueLane: "Plats eller bana"
        case .date: "Datum"
        case .matchFormat: "Matchformat"
        case .targetDistance: "Målavstånd"
        case .notes: "Anteckningar"
        case .saveMatchPlan: "Spara matchplan"
        case .upcoming: "Kommande"
        case .upcomingSubtitle: "Tryck på radera när matchen är klar eller när spelplanen ändras."
        case .surface: "underlag"
        case .weather: "väder"
        case .target: "mål"
        case .resultsTitle: "Resultatjournal"
        case .resultsSubtitle: "Registrera matchutfall med uppmätt avstånd från markören. Mindre avstånd vinner, så appen behandlar lägre värde som bättre."
        case .recordGame: "Registrera spel"
        case .opponent: "Motståndare"
        case .venue: "Plats"
        case .yourThrow1: "Ditt kast 1"
        case .yourThrow2: "Ditt kast 2"
        case .yourThrow3: "Ditt kast 3"
        case .opponentThrow1: "Motståndarens kast 1"
        case .opponentThrow2: "Motståndarens kast 2"
        case .opponentThrow3: "Motståndarens kast 3"
        case .yourBest: "ditt bästa"
        case .best: "bäst"
        case .average: "snitt"
        case .history: "Historik"
        case .historySubtitle: "Lokal matchlogg med bästa kast, genomsnittlig avvikelse, underlag och väder."
        case .saveResult: "Spara resultat"
        case .win: "Vinst"
        case .chase: "Jakt"
        case .kitTitle: "Varpa-utrustning"
        case .kitSubtitle: "En produktklar klubbapp behöver minne för utrustning: material, vikt, diameter och fältanteckningar."
        case .favoriteMatchVarpa: "Favoritvarpa för match"
        case .weight: "vikt"
        case .diameter: "diameter"
        case .material: "material"
        case .profileTitle: "Profil"
        case .profileSubtitle: "Lokal spelaridentitet, klubbstatistik, introduktion och integritetsvanliga datakontroller."
        case .localProfile: "Lokal profil i Varpa Rain"
        case .playerName: "Spelarnamn"
        case .clubName: "Klubbnamn"
        case .games: "matcher"
        case .avgMiss: "snittavvikelse"
        case .readiness: "Beredskap"
        case .readinessSubtitle: "Enkla lokala mål som visar verklig användning av produkten."
        case .plannerOpened: "Planeringen öppnad"
        case .firstResultSaved: "Första resultatet sparat"
        case .kitFavoriteSet: "Favoritutrustning vald"
        case .measuredUnderHalf: "Uppmätt under 0,5 m"
        case .data: "Data"
        case .dataSubtitle: "Alla planer, resultat, utrustningsanteckningar och profiluppgifter sparas lokalt på den här enheten."
        case .saveProfile: "Spara profil"
        case .replayOnboarding: "Visa introduktion igen"
        case .resetLocalData: "Nollställ lokal data"
        case .resetTitle: "Nollställ lokal data?"
        case .cancel: "Avbryt"
        case .reset: "Nollställ"
        case .resetMessage: "Detta återställer exempelmatch, exempelresultat, utrustningslista och profilstandarder."
        case .ready: "Klar"
        case .open: "Öppna"
        case .almanacTitle: "Varpaalmanacka"
        case .almanacSubtitle: "Artiklar, illustrerade regler och ett praktiskt språk för matchdagen."
        case .readLane: "Läs banan före kastet."
        case .articles: "Artiklar"
        case .rules: "Regler"
        case .glossary: "Ordlista"
        case .fieldTakeaways: "Att ta med till banan"
        case .closestWins: "närmast vinner"
        case .nearestEdge: "närmaste kant"
        }
    }
}

struct LanguageSwitcher: View {
    @Binding var language: AppLanguage

    var body: some View {
        HStack(spacing: 6) {
            ForEach(AppLanguage.allCases) { item in
                Button {
                    withAnimation(.spring(response: 0.22, dampingFraction: 0.86)) {
                        language = item
                    }
                } label: {
                    Text(item.shortTitle)
                        .font(.caption.weight(.black))
                        .foregroundStyle(language == item ? BrandPalette.ink : BrandPalette.textSoft)
                        .frame(width: 44, height: 34)
                        .background(
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(language == item ? BrandPalette.glowBlue : BrandPalette.white.opacity(0.08))
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(BrandPalette.ink.opacity(0.62))
        )
    }
}
