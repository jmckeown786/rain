import Foundation
import SwiftUI

enum AppSection: String, CaseIterable, Identifiable, Hashable {
    case dashboard
    case planner
    case results
    case more
    case almanac
    case kit
    case profile

    var id: String { rawValue }

    static let menuCases: [AppSection] = [.dashboard, .planner, .results, .more]

    var title: String {
        switch self {
        case .dashboard: "Home"
        case .planner: "Planner"
        case .results: "Results"
        case .more: "More"
        case .almanac: "Almanac"
        case .kit: "Kit"
        case .profile: "Profile"
        }
    }

    var symbol: String {
        switch self {
        case .dashboard: "house.and.flag.fill"
        case .planner: "calendar.badge.plus"
        case .results: "list.bullet.clipboard.fill"
        case .more: "ellipsis"
        case .almanac: "book.closed.fill"
        case .kit: "seal.fill"
        case .profile: "person.crop.circle.fill"
        }
    }
}

enum SurfaceType: String, CaseIterable, Identifiable, Codable {
    case grass
    case gravel
    case clay
    case indoor

    var id: String { rawValue }
    var title: String { rawValue.capitalized }
    var color: Color {
        switch self {
        case .grass: BrandPalette.mint
        case .gravel: BrandPalette.rainBlue
        case .clay: BrandPalette.clay
        case .indoor: BrandPalette.gold
        }
    }
}

enum WeatherCondition: String, CaseIterable, Identifiable, Codable {
    case dry
    case lightRain
    case heavyRain
    case wind

    var id: String { rawValue }

    var title: String {
        switch self {
        case .dry: "Dry"
        case .lightRain: "Light rain"
        case .heavyRain: "Heavy rain"
        case .wind: "Wind"
        }
    }

    var symbol: String {
        switch self {
        case .dry: "sun.max.fill"
        case .lightRain: "cloud.rain.fill"
        case .heavyRain: "cloud.heavyrain.fill"
        case .wind: "wind"
        }
    }
}

struct MatchPlan: Identifiable, Codable, Equatable {
    var id: UUID
    var opponent: String
    var venue: String
    var date: Date
    var format: String
    var surface: SurfaceType
    var weather: WeatherCondition
    var targetDistance: Double
    var notes: String

    static let sample = MatchPlan(
        id: UUID(),
        opponent: "Visby Varpklubb",
        venue: "South lane, Gotland",
        date: Calendar.current.date(byAdding: .day, value: 3, to: .now) ?? .now,
        format: "Singles to 12 throws",
        surface: .gravel,
        weather: .lightRain,
        targetDistance: 20,
        notes: "Bring a heavier varpa if the lane stays wet."
    )
}

struct GameResult: Identifiable, Codable, Equatable {
    var id: UUID
    var opponent: String
    var venue: String
    var date: Date
    var playerThrows: [Double]
    var opponentThrows: [Double]
    var surface: SurfaceType
    var weather: WeatherCondition
    var notes: String

    var bestThrow: Double { playerThrows.min() ?? 0 }
    var averageThrow: Double {
        guard !playerThrows.isEmpty else { return 0 }
        return playerThrows.reduce(0, +) / Double(playerThrows.count)
    }
    var opponentBest: Double { opponentThrows.min() ?? 0 }
    var didWin: Bool { bestThrow <= opponentBest }
}

struct GearItem: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var material: String
    var weight: Double
    var diameter: Double
    var notes: String
    var favorite: Bool
}

struct LaneReadout {
    let score: Int
    let title: String
    let summary: String
    let checks: [String]

    static func make(
        surface: SurfaceType,
        weather: WeatherCondition,
        targetDistance: Double,
        gear: GearItem,
        bestDistance: Double,
        language: AppLanguage
    ) -> LaneReadout {
        let weatherPenalty: Int = switch weather {
        case .dry: 0
        case .lightRain: 8
        case .heavyRain: 18
        case .wind: 14
        }
        let surfacePenalty: Int = switch surface {
        case .grass: weather == .heavyRain ? 12 : 4
        case .gravel: 5
        case .clay: weather == .heavyRain ? 16 : 8
        case .indoor: 0
        }
        let distancePenalty = max(0, Int((targetDistance - 18) * 1.4))
        let formBonus = bestDistance > 0 ? min(12, Int(max(0, 1.2 - bestDistance) * 10)) : 0
        let score = min(96, max(42, 88 - weatherPenalty - surfacePenalty - distancePenalty + formBonus))

        switch language {
        case .english:
            return LaneReadout(
                score: score,
                title: score >= 78 ? "Lane reads clean" : score >= 62 ? "Lane needs control" : "Lane is demanding",
                summary: "Use \(gear.name) at \(gear.weight.kilograms) for \(targetDistance.meters). \(releaseAdvice(weather: weather, surface: surface, language: language))",
                checks: [
                    "Mark the nearest edge, not the visual center.",
                    frictionCheck(surface: surface, weather: weather, language: language),
                    bestDistance > 0 ? "Your best logged miss is \(bestDistance.meters); play the first frame for confirmation." : "No personal best yet; use the first frame to calibrate release speed."
                ]
            )
        case .swedish:
            return LaneReadout(
                score: score,
                title: score >= 78 ? "Banan läses rent" : score >= 62 ? "Banan kräver kontroll" : "Banan är krävande",
                summary: "Använd \(gear.name) på \(gear.weight.kilograms) för \(targetDistance.meters). \(releaseAdvice(weather: weather, surface: surface, language: language))",
                checks: [
                    "Markera närmaste kant, inte den visuella mitten.",
                    frictionCheck(surface: surface, weather: weather, language: language),
                    bestDistance > 0 ? "Din bästa loggade avvikelse är \(bestDistance.meters); spela första omgången för bekräftelse." : "Ingen personlig bästa notering ännu; använd första omgången för att kalibrera fart."
                ]
            )
        }
    }

    private static func releaseAdvice(weather: WeatherCondition, surface: SurfaceType, language: AppLanguage) -> String {
        switch language {
        case .english:
            switch (weather, surface) {
            case (.wind, _): "Keep the release low and avoid extra height."
            case (.heavyRain, .grass), (.heavyRain, .clay): "Expect the varpa to stop early on wet ground."
            case (.lightRain, _): "Check grip before each throw and favor a smooth low arc."
            case (_, .indoor): "Trust the roll; indoor friction should stay consistent."
            default: "Start with a measured low release and adjust after the first mark."
            }
        case .swedish:
            switch (weather, surface) {
            case (.wind, _): "Håll kastet lågt och undvik extra höjd."
            case (.heavyRain, .grass), (.heavyRain, .clay): "Räkna med att varpan stannar tidigt på vått underlag."
            case (.lightRain, _): "Kontrollera greppet före varje kast och välj en mjuk låg båge."
            case (_, .indoor): "Lita på rullningen; inomhusfriktionen bör vara jämn."
            default: "Börja med ett kontrollerat lågt kast och justera efter första markeringen."
            }
        }
    }

    private static func frictionCheck(surface: SurfaceType, weather: WeatherCondition, language: AppLanguage) -> String {
        switch language {
        case .english:
            switch surface {
            case .grass: weather == .dry ? "Grass should carry; watch bounce on the first landing." : "Wet grass absorbs speed; choose a slightly firmer throw."
            case .gravel: "Gravel can kick sideways; inspect the landing strip before scoring."
            case .clay: "Clay rewards a clean edge; wipe the varpa before each measured throw."
            case .indoor: "Indoor lanes reward repeatable rhythm over power."
            }
        case .swedish:
            switch surface {
            case .grass: weather == .dry ? "Gräs bär bra; följ första studsen noga." : "Vått gräs bromsar fart; välj ett något fastare kast."
            case .gravel: "Grus kan kasta varpan i sidled; kontrollera landningsytan före mätning."
            case .clay: "Lera belönar ren kant; torka varpan före varje uppmätt kast."
            case .indoor: "Inomhusbanor belönar jämn rytm mer än kraft."
            }
        }
    }
}

struct AlmanacArticle: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let symbol: String
    let accent: Color
    let readTime: String
    let imageKind: AlmanacImageKind
    let lead: String
    let sections: [AlmanacSection]
    let takeaways: [String]
}

enum AlmanacImageKind {
    case history
    case rules
    case technique
    case rain
    case training
}

struct AlmanacSection: Identifiable {
    let id: String
    let heading: String
    let paragraphs: [String]
}

struct RuleGuide: Identifiable {
    let id: String
    let title: String
    let summary: String
    let detail: String
    let imageKind: RuleImageKind
}

enum RuleImageKind {
    case marker
    case line
    case measuring
    case equalThrows
    case surface
    case scoring
}

struct GlossaryEntry: Identifiable {
    let id: String
    let term: String
    let definition: String
    let usage: String
    let symbol: String
}

struct FeatureNote: Identifiable {
    let id: String
    let title: String
    let body: String
    let symbol: String
    let color: Color
}

enum TeamSport: String, CaseIterable, Identifiable {
    case football
    case basketball
    case hockey

    var id: String { rawValue }

    var symbol: String {
        switch self {
        case .football: "soccerball"
        case .basketball: "basketball.fill"
        case .hockey: "figure.hockey"
        }
    }
}

struct SportTeam: Identifiable {
    let id: String
    let name: String
    let league: String
    let region: String
    let sport: TeamSport
}

@MainActor
final class VarpaStore: ObservableObject {
    private enum Keys {
        static let plans = "rbtvarparain.plans"
        static let results = "rbtvarparain.results"
        static let gear = "rbtvarparain.gear"
        static let playerName = "rbtvarparain.playerName"
        static let clubName = "rbtvarparain.clubName"
    }

    @Published var plans: [MatchPlan] = []
    @Published var results: [GameResult] = []
    @Published var gear: [GearItem] = []
    @Published var playerName: String = "Varpa Player"
    @Published var clubName: String = "Gotland Varpa Club"

    init() {
        restore()
        seedIfNeeded()
    }

    var upcomingPlans: [MatchPlan] {
        plans.sorted { $0.date < $1.date }
    }

    var wins: Int {
        results.filter(\.didWin).count
    }

    var bestDistance: Double {
        results.map(\.bestThrow).filter { $0 > 0 }.min() ?? 0
    }

    var averageDistance: Double {
        let values = results.flatMap(\.playerThrows)
        guard !values.isEmpty else { return 0 }
        return values.reduce(0, +) / Double(values.count)
    }

    var favoriteGear: GearItem {
        gear.first(where: \.favorite) ?? gear[0]
    }

    func addPlan(_ plan: MatchPlan) {
        plans.append(plan)
        persist()
    }

    func addResult(_ result: GameResult) {
        results.insert(result, at: 0)
        persist()
    }

    func deletePlan(_ plan: MatchPlan) {
        plans.removeAll { $0.id == plan.id }
        persist()
    }

    func toggleFavorite(_ item: GearItem) {
        gear = gear.map { current in
            var copy = current
            copy.favorite = current.id == item.id
            return copy
        }
        persist()
    }

    func resetAll() {
        plans = [Self.defaultPlan]
        results = [Self.defaultResult]
        gear = Self.defaultGear
        playerName = "Varpa Player"
        clubName = "Gotland Varpa Club"
        persist()
    }

    func persistProfile() {
        persist()
    }

    private func restore() {
        let defaults = UserDefaults.standard
        playerName = defaults.string(forKey: Keys.playerName) ?? playerName
        clubName = defaults.string(forKey: Keys.clubName) ?? clubName
        plans = Self.decode([MatchPlan].self, from: defaults.data(forKey: Keys.plans)) ?? []
        results = Self.decode([GameResult].self, from: defaults.data(forKey: Keys.results)) ?? []
        gear = Self.decode([GearItem].self, from: defaults.data(forKey: Keys.gear)) ?? []
    }

    private func seedIfNeeded() {
        if plans.isEmpty { plans = [Self.defaultPlan] }
        if results.isEmpty { results = [Self.defaultResult] }
        if gear.isEmpty { gear = Self.defaultGear }
        persist()
    }

    private func persist() {
        let defaults = UserDefaults.standard
        defaults.set(Self.encode(plans), forKey: Keys.plans)
        defaults.set(Self.encode(results), forKey: Keys.results)
        defaults.set(Self.encode(gear), forKey: Keys.gear)
        defaults.set(playerName, forKey: Keys.playerName)
        defaults.set(clubName, forKey: Keys.clubName)
    }

    private static func encode<T: Encodable>(_ value: T) -> Data? {
        try? JSONEncoder().encode(value)
    }

    private static func decode<T: Decodable>(_ type: T.Type, from data: Data?) -> T? {
        guard let data else { return nil }
        return try? JSONDecoder().decode(type, from: data)
    }

    private static let defaultPlan = MatchPlan.sample

    private static let defaultResult = GameResult(
        id: UUID(),
        opponent: "Practice marker",
        venue: "Home lane",
        date: .now,
        playerThrows: [0.42, 0.76, 1.15],
        opponentThrows: [0.81, 1.04, 1.38],
        surface: .grass,
        weather: .dry,
        notes: "Clean low releases. Best throw stopped inside half a meter."
    )

    private static let defaultGear = [
        GearItem(id: UUID(), name: "Gotland Limestone", material: "Stone", weight: 0.95, diameter: 17.5, notes: "Balanced training varpa for damp grass.", favorite: true),
        GearItem(id: UUID(), name: "Iron Training Varpa", material: "Metal", weight: 1.15, diameter: 16.2, notes: "Stable in crosswind and on gravel.", favorite: false),
        GearItem(id: UUID(), name: "Light Practice Varpa", material: "Composite", weight: 0.72, diameter: 18.0, notes: "Good for juniors and short drills.", favorite: false)
    ]
}
