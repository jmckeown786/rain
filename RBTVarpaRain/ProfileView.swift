import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var store: VarpaStore
    @AppStorage("rbtvarparain.onboarding.done") private var onboardingDone = true
    @AppStorage("settings.language") private var languageRawValue = AppLanguage.english.rawValue
    @State private var confirmReset = false
    @FocusState private var focusedField: ProfileField?

    private var language: AppLanguage {
        AppLanguage(rawValue: languageRawValue) ?? .english
    }

    private enum ProfileField {
        case playerName
        case clubName
    }

    private var rankTitle: String {
        if language == .swedish {
            switch store.results.count {
            case 0...1: "Banstartare"
            case 2...5: "Markörlasare"
            case 6...12: "Varpakapten"
            default: "Gotländsk matchledare"
            }
        } else {
            switch store.results.count {
            case 0...1: "Lane Starter"
            case 2...5: "Marker Reader"
            case 6...12: "Varpa Captain"
            default: "Gotland Match Lead"
            }
        }
    }

    var body: some View {
        AppScreen {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .center) {
                    SectionKick(title: L.text(.profileTitle, language), subtitle: L.text(.profileSubtitle, language))
                    Spacer()
                    LanguageSwitcher(
                        language: Binding(
                            get: { language },
                            set: { languageRawValue = $0.rawValue }
                        )
                    )
                }

                RainCard {
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(spacing: 14) {
                            LogoMark(size: 72)
                            VStack(alignment: .leading, spacing: 5) {
                                Text(rankTitle)
                                    .font(.title3.weight(.black))
                                    .foregroundStyle(BrandPalette.white)
                                Text(L.text(.localProfile, language))
                                    .font(.subheadline)
                                    .foregroundStyle(BrandPalette.textSoft)
                            }
                        }

                        TextField(
                            L.text(.playerName, language),
                            text: $store.playerName,
                            prompt: Text(L.text(.playerName, language)).foregroundColor(BrandPalette.textMuted)
                        )
                            .textFieldStyle(AppTextFieldStyle())
                            .focused($focusedField, equals: .playerName)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .clubName }
                        TextField(
                            L.text(.clubName, language),
                            text: $store.clubName,
                            prompt: Text(L.text(.clubName, language)).foregroundColor(BrandPalette.textMuted)
                        )
                            .textFieldStyle(AppTextFieldStyle())
                            .focused($focusedField, equals: .clubName)
                            .submitLabel(.done)
                            .onSubmit {
                                store.persistProfile()
                                focusedField = nil
                            }

                        HStack(spacing: 10) {
                            StatPill(value: "\(store.results.count)", label: L.text(.games, language), color: BrandPalette.rainBlue)
                            StatPill(value: "\(store.wins)", label: L.text(.wins, language), color: BrandPalette.mint)
                            StatPill(value: store.averageDistance == 0 ? "--" : store.averageDistance.meters, label: L.text(.avgMiss, language), color: BrandPalette.gold)
                        }
                    }
                }

                SectionKick(title: L.text(.readiness, language), subtitle: L.text(.readinessSubtitle, language))

                achievement(title: L.text(.plannerOpened, language), unlocked: !store.plans.isEmpty, color: BrandPalette.rainBlue)
                achievement(title: L.text(.firstResultSaved, language), unlocked: !store.results.isEmpty, color: BrandPalette.gold)
                achievement(title: L.text(.kitFavoriteSet, language), unlocked: store.gear.contains(where: \.favorite), color: BrandPalette.mint)
                achievement(title: L.text(.measuredUnderHalf, language), unlocked: store.bestDistance > 0 && store.bestDistance < 0.5, color: BrandPalette.coral)

                RainCard {
                    VStack(alignment: .leading, spacing: 14) {
                        SectionKick(title: L.text(.data, language), subtitle: L.text(.dataSubtitle, language))

                        Button {
                            focusedField = nil
                            store.persistProfile()
                        } label: {
                            Label(L.text(.saveProfile, language), systemImage: "square.and.arrow.down.fill")
                        }
                        .buttonStyle(PrimaryButtonStyle())

                        Button {
                            onboardingDone = false
                        } label: {
                            Label(L.text(.replayOnboarding, language), systemImage: "arrow.counterclockwise")
                        }
                        .buttonStyle(QuietButtonStyle())

                        Button(role: .destructive) {
                            confirmReset = true
                        } label: {
                            Label(L.text(.resetLocalData, language), systemImage: "trash")
                        }
                        .buttonStyle(QuietButtonStyle())
                    }
                }
            }
        }
        .alert(L.text(.resetTitle, language), isPresented: $confirmReset) {
            Button(L.text(.cancel, language), role: .cancel) { }
            Button(L.text(.reset, language), role: .destructive) {
                store.resetAll()
            }
        } message: {
            Text(L.text(.resetMessage, language))
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button(L.text(.ready, language)) {
                    store.persistProfile()
                    focusedField = nil
                }
                .font(.headline.weight(.bold))
            }
        }
    }

    private func achievement(title: String, unlocked: Bool, color: Color) -> some View {
        RainCard {
            HStack(spacing: 12) {
                Image(systemName: unlocked ? "checkmark.seal.fill" : "lock.fill")
                    .font(.title2.weight(.black))
                    .foregroundStyle(unlocked ? color : BrandPalette.textMuted)
                    .frame(width: 44, height: 44)
                    .background(Circle().fill((unlocked ? color : BrandPalette.textMuted).opacity(0.16)))

                Text(title)
                    .font(.headline.weight(.heavy))
                    .foregroundStyle(BrandPalette.white)

                Spacer()

                Text(unlocked ? L.text(.ready, language) : L.text(.open, language))
                    .font(.caption.weight(.black))
                    .foregroundStyle(unlocked ? BrandPalette.ink : BrandPalette.textSoft)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .background(Capsule().fill(unlocked ? color : BrandPalette.white.opacity(0.1)))
            }
        }
    }
}
