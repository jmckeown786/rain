import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @StateObject private var store = VarpaStore()
    @StateObject private var keyboard = KeyboardObserver()
    @State private var section: AppSection = .dashboard
    @AppStorage("rbtvarparain.onboarding.done") private var onboardingDone = false
    @AppStorage("settings.language") private var languageRawValue = AppLanguage.english.rawValue

    private var language: AppLanguage {
        AppLanguage(rawValue: languageRawValue) ?? .english
    }

    var body: some View {
        Group {
            if onboardingDone {
                Group {
                    if horizontalSizeClass == .regular {
                        HStack(spacing: 0) {
                            AppSidebar(selection: $section, language: language)
                            NavigationStack {
                                screen(for: section)
                                    .id(section)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .background(BrandPalette.ink.ignoresSafeArea())
                    } else {
                        ZStack(alignment: .bottom) {
                            NavigationStack {
                                screen(for: section)
                                    .id(section)
                            }
                            .safeAreaInset(edge: .bottom, spacing: 0) {
                                Color.clear
                                    .frame(height: keyboard.isVisible ? 0 : AppTabBar.metrics.height)
                            }

                            AppTabBar(selection: $section, language: language)
                                .opacity(keyboard.isVisible ? 0 : 1)
                                .allowsHitTesting(!keyboard.isVisible)
                                .accessibilityHidden(keyboard.isVisible)
                                .offset(y: keyboard.isVisible ? AppTabBar.metrics.height : 0)
                        }
                        .animation(.easeOut(duration: 0.18), value: keyboard.isVisible)
                        .background(BrandPalette.ink.ignoresSafeArea())
                    }
                }
                .environmentObject(store)
                .tint(BrandPalette.glowBlue)
            } else {
                OnboardingView {
                    onboardingDone = true
                }
                .environmentObject(store)
            }
        }
    }

    @ViewBuilder
    private func screen(for item: AppSection) -> some View {
        switch item {
        case .dashboard:
            HomeView(selectedSection: $section)
        case .planner:
            MatchCenterView()
        case .results:
            LeagueView()
        case .almanac:
            CultureView()
        case .kit:
            StoneforgeView()
        case .profile:
            ProfileView()
        }
    }
}

final class KeyboardObserver: ObservableObject {
    @Published var isVisible = false

    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func keyboardWillShow() {
        isVisible = true
    }

    @objc private func keyboardWillHide() {
        isVisible = false
    }
}

struct AppTabBar: View {
    @Binding var selection: AppSection
    let language: AppLanguage

    static let metrics = Metrics()

    struct Metrics {
        let height: CGFloat = 70
    }

    var body: some View {
        HStack(spacing: 4) {
            ForEach(AppSection.allCases) { item in
                Button {
                    withAnimation(.spring(response: 0.25, dampingFraction: 0.86)) {
                        selection = item
                    }
                } label: {
                    VStack(spacing: 5) {
                        Image(systemName: item.symbol)
                            .font(.system(size: 19, weight: .black))
                            .frame(height: 22)
                        Text(L.sectionTitle(item, language))
                            .font(.system(size: 10, weight: .black, design: .rounded))
                            .lineLimit(1)
                            .minimumScaleFactor(0.72)
                    }
                    .foregroundStyle(selection == item ? BrandPalette.ink : BrandPalette.textSoft)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 9)
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(selection == item ? BrandPalette.glowBlue : BrandPalette.white.opacity(0.001))
                    )
                }
                .buttonStyle(.plain)
                .accessibilityLabel(L.sectionTitle(item, language))
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 8)
        .padding(.bottom, 10)
        .background(
            BrandPalette.ink
                .overlay(alignment: .top) {
                    Rectangle()
                        .fill(BrandPalette.glowBlue.opacity(0.16))
                        .frame(height: 1)
                }
        )
    }
}

struct AppSidebar: View {
    @Binding var selection: AppSection
    let language: AppLanguage

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            BrandLockup(compact: true)
                .padding(.top, 26)
                .padding(.horizontal, 18)

            VStack(spacing: 8) {
                ForEach(AppSection.allCases) { item in
                    Button {
                        withAnimation(.spring(response: 0.25, dampingFraction: 0.86)) {
                            selection = item
                        }
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: item.symbol)
                                .font(.headline.weight(.black))
                                .frame(width: 26)
                            Text(L.sectionTitle(item, language))
                                .font(.headline.weight(.black))
                                .lineLimit(1)
                            Spacer()
                        }
                        .foregroundStyle(selection == item ? BrandPalette.ink : BrandPalette.textSoft)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 13)
                        .background(
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(selection == item ? BrandPalette.glowBlue : BrandPalette.white.opacity(0.06))
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 14)

            Spacer()
        }
        .frame(width: 244)
        .background(
            BrandPalette.ink
                .overlay(alignment: .trailing) {
                    Rectangle()
                        .fill(BrandPalette.glowBlue.opacity(0.14))
                        .frame(width: 1)
                }
        )
    }
}
