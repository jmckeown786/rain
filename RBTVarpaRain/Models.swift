import Foundation
import SwiftUI

enum AppSection: String, CaseIterable, Identifiable {
    case dashboard
    case planner
    case results
    case almanac
    case kit
    case profile

    var id: String { rawValue }

    var title: String {
        switch self {
        case .dashboard: "Home"
        case .planner: "Planner"
        case .results: "Results"
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
    @Published var clubName: String = "RBT Varpa Club"

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
        clubName = "RBT Varpa Club"
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
        GearItem(id: UUID(), name: "Iron Rain Disc", material: "Metal", weight: 1.15, diameter: 16.2, notes: "Stable in crosswind and on gravel.", favorite: false),
        GearItem(id: UUID(), name: "Light Practice Varpa", material: "Composite", weight: 0.72, diameter: 18.0, notes: "Good for juniors and short drills.", favorite: false)
    ]
}
