import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject private var store: VarpaStore
    @AppStorage("settings.language") private var languageRawValue = AppLanguage.english.rawValue
    let onStart: () -> Void

    private var language: AppLanguage {
        AppLanguage(rawValue: languageRawValue) ?? .english
    }

    var body: some View {
        ZStack {
            RainBackground()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 22) {
                    Spacer(minLength: 18)

                    BrandLockup()

                    LanguageSwitcher(
                        language: Binding(
                            get: { language },
                            set: { languageRawValue = $0.rawValue }
                        )
                    )

                    RainCard {
                        VStack(alignment: .leading, spacing: 18) {
                            Text(L.text(.onboardingTitle, language))
                                .font(.system(size: 31, weight: .black, design: .rounded))
                                .foregroundStyle(BrandPalette.white)
                                .fixedSize(horizontal: false, vertical: true)

                            Text(L.text(.onboardingBody, language))
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(BrandPalette.textSoft)
                                .fixedSize(horizontal: false, vertical: true)

                            MatchLaneView(surface: .gravel, weather: .lightRain, quality: 0.82)

                            HStack(spacing: 10) {
                                StatPill(value: "20 m", label: L.text(.classicLane, language), color: BrandPalette.rainBlue)
                                StatPill(value: "\(store.gear.count)", label: L.text(.kitItems, language), color: BrandPalette.gold)
                                StatPill(value: "Offline", label: L.text(.localData, language), color: BrandPalette.mint)
                            }
                        }
                    }

                    Button {
                        onStart()
                    } label: {
                        Label(L.text(.onboardingButton, language), systemImage: "arrow.right.circle.fill")
                    }
                    .buttonStyle(PrimaryButtonStyle())

                    Spacer(minLength: 18)
                }
                .frame(maxWidth: 720)
                .padding(18)
                .frame(maxWidth: .infinity)
            }
        }
    }
}
