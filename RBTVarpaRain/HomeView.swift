import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var store: VarpaStore
    @AppStorage("settings.language") private var languageRawValue = AppLanguage.english.rawValue
    @Binding var selectedSection: AppSection

    private var nextMatch: MatchPlan { store.upcomingPlans.first ?? .sample }
    private var laneReadout: LaneReadout {
        LaneReadout.make(
            surface: nextMatch.surface,
            weather: nextMatch.weather,
            targetDistance: nextMatch.targetDistance,
            gear: store.favoriteGear,
            bestDistance: store.bestDistance,
            language: language
        )
    }
    private var language: AppLanguage {
        AppLanguage(rawValue: languageRawValue) ?? .english
    }

    var body: some View {
        AppScreen {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .center, spacing: 14) {
                    BrandLockup(compact: true)
                    Spacer()
                    VStack(alignment: .trailing, spacing: 2) {
                        Text(store.playerName)
                            .font(.caption.weight(.heavy))
                            .foregroundStyle(BrandPalette.textSoft)
                        Text(store.clubName)
                            .font(.caption2.weight(.bold))
                            .foregroundStyle(BrandPalette.textMuted)
                    }
                }

                RainCard {
                    VStack(alignment: .leading, spacing: 16) {
                        Text(L.text(.homeHeroTitle, language))
                            .font(.system(size: 28, weight: .black, design: .rounded))
                            .foregroundStyle(BrandPalette.white)
                            .fixedSize(horizontal: false, vertical: true)

                        Text(summary(for: nextMatch))
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(BrandPalette.textSoft)
                            .fixedSize(horizontal: false, vertical: true)

                        MatchLaneView(surface: nextMatch.surface, weather: nextMatch.weather, quality: store.bestDistance == 0 ? 0.64 : min(1, 1.1 - store.bestDistance / 2.5))

                        HStack(spacing: 10) {
                            StatPill(value: "\(store.plans.count)", label: L.text(.planned, language), color: BrandPalette.rainBlue)
                            StatPill(value: "\(store.wins)/\(store.results.count)", label: L.text(.wins, language), color: BrandPalette.mint)
                            StatPill(value: store.bestDistance == 0 ? "--" : store.bestDistance.meters, label: L.text(.bestMiss, language), color: BrandPalette.gold)
                        }

                        HStack(spacing: 10) {
                            Button {
                                selectedSection = .planner
                            } label: {
                                Label(L.text(.planMatch, language), systemImage: "calendar.badge.plus")
                            }
                            .buttonStyle(PrimaryButtonStyle())

                            Button {
                                selectedSection = .results
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .frame(width: 44, height: 44)
                            }
                            .buttonStyle(QuietButtonStyle())
                        }
                    }
                }

                LaneReadoutCard(
                    readout: laneReadout,
                    actionTitle: language == .english ? "Open planner with this read" : "Öppna planering med banläsning"
                ) {
                    selectedSection = .planner
                }

                SectionKick(title: L.text(.productTools, language), subtitle: L.text(.homeToolsSubtitle, language))

                ForEach(AppData.features(language: language)) { feature in
                    Button {
                        selectedSection = section(for: feature.id)
                    } label: {
                        RainCard {
                            HStack(alignment: .top, spacing: 14) {
                                Image(systemName: feature.symbol)
                                    .font(.title2.weight(.black))
                                    .foregroundStyle(feature.color)
                                    .frame(width: 46, height: 46)
                                    .background(Circle().fill(feature.color.opacity(0.16)))
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(feature.title)
                                        .font(.headline.weight(.heavy))
                                        .foregroundStyle(BrandPalette.white)
                                    Text(feature.body)
                                        .font(.subheadline)
                                        .foregroundStyle(BrandPalette.textSoft)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private func section(for id: String) -> AppSection {
        switch id {
        case "plan": .planner
        case "record": .results
        default: .more
        }
    }

    private func summary(for plan: MatchPlan) -> String {
        switch language {
        case .english:
            "\(plan.opponent) at \(plan.venue). \(plan.format), \(plan.targetDistance.meters) target, \(L.surface(plan.surface, language).lowercased()) surface."
        case .swedish:
            "\(plan.opponent) på \(plan.venue). \(localizedFormat(plan.format)), mål \(plan.targetDistance.meters), underlag \(L.surface(plan.surface, language).lowercased())."
        }
    }

    private func localizedFormat(_ value: String) -> String {
        language == .swedish && value == "Singles to 12 throws" ? "Singel till 12 kast" : value
    }
}
