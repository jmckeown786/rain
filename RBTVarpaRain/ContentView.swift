import FirebaseAnalytics
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
                        NavigationSplitView {
                            VarpaWorkbenchSidebar(selection: $section, language: language)
                        } detail: {
                            NavigationStack {
                                screen(for: section)
                                    .id(section)
                            }
                            .background(BrandPalette.ink.ignoresSafeArea())
                        }
                        .navigationSplitViewStyle(.balanced)
                        .background(BrandPalette.ink.ignoresSafeArea())
                    } else {
                        ZStack(alignment: .bottom) {
                            NavigationStack {
                                screen(for: section)
                                    .id(section)
                            }
                            .safeAreaInset(edge: .bottom, spacing: 0) {
                                Color.clear
                                    .frame(height: keyboard.isVisible ? 0 : ThrowBenchTabRail.metrics.height)
                            }

                            ThrowBenchTabRail(selection: $section, language: language)
                                .opacity(keyboard.isVisible ? 0 : 1)
                                .allowsHitTesting(!keyboard.isVisible)
                                .accessibilityHidden(keyboard.isVisible)
                                .offset(y: keyboard.isVisible ? ThrowBenchTabRail.metrics.height : 0)
                        }
                        .animation(.easeOut(duration: 0.18), value: keyboard.isVisible)
                        .background(BrandPalette.ink.ignoresSafeArea())
                    }
                }
                .environmentObject(store)
                .tint(BrandPalette.glowBlue)
                .onAppear {
                    logWorkbenchVisit(section)
                }
                .onChange(of: section) { newSection in
                    logWorkbenchVisit(newSection)
                }
            } else {
                OnboardingView {
                    onboardingDone = true
                    Analytics.logEvent("varpa_onboarding_completed", parameters: nil)
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
        case .more:
            MoreView(language: language)
        case .almanac:
            CultureView()
        case .kit:
            StoneforgeView()
        case .profile:
            ProfileView()
        }
    }

    private func logWorkbenchVisit(_ item: AppSection) {
        Analytics.logEvent(
            "varpa_workbench_opened",
            parameters: [
                "section": item.rawValue,
                "language": language.rawValue
            ]
        )
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

struct ThrowBenchTabRail: View {
    @Binding var selection: AppSection
    let language: AppLanguage

    static let metrics = Metrics()

    struct Metrics {
        let height: CGFloat = 82
    }

    var body: some View {
        HStack(spacing: 4) {
            ForEach(AppSection.menuCases) { item in
                Button {
                    withAnimation(.spring(response: 0.25, dampingFraction: 0.86)) {
                        selection = item
                    }
                } label: {
                    VStack(spacing: 5) {
                        Image(systemName: item.symbol)
                            .font(.system(size: selection == item ? 20 : 18, weight: .black))
                            .frame(height: 22)
                        Text(L.sectionTitle(item, language))
                            .font(.system(size: 10, weight: .black, design: .rounded))
                            .lineLimit(1)
                            .minimumScaleFactor(0.72)
                    }
                    .foregroundStyle(selection == item ? BrandPalette.ink : BrandPalette.textSoft)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(selection == item ? BrandPalette.glowBlue : BrandPalette.white.opacity(0.001))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .stroke(selection == item ? BrandPalette.white.opacity(0.58) : .clear, lineWidth: 1)
                            )
                    )
                }
                .buttonStyle(.plain)
                .accessibilityLabel(L.sectionTitle(item, language))
            }
        }
        .padding(.horizontal, 11)
        .padding(.top, 10)
        .padding(.bottom, 11)
        .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(BrandPalette.ink.opacity(0.92))
                .overlay(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(BrandPalette.glowBlue.opacity(0.22), lineWidth: 1)
                )
                .shadow(color: BrandPalette.rainBlue.opacity(0.22), radius: 18, x: 0, y: -4)
        )
        .padding(.horizontal, 10)
        .padding(.bottom, 8)
    }
}

struct VarpaWorkbenchSidebar: View {
    @Binding var selection: AppSection
    let language: AppLanguage

    var body: some View {
        List {
            BrandLockup(compact: true)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .padding(.top, 18)

            Section {
                ForEach(AppSection.menuCases) { item in
                    Button {
                        selection = item
                    } label: {
                        sidebarRow(for: item)
                    }
                    .buttonStyle(.plain)
                    .listRowBackground(rowBackground(for: item))
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(
            LinearGradient(
                colors: [BrandPalette.ink, BrandPalette.midnight.opacity(0.72)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
        .navigationTitle("Varpa Bench")
    }

    private func sidebarRow(for item: AppSection) -> some View {
        HStack(spacing: 12) {
            Image(systemName: item.symbol)
                .font(.headline.weight(.black))
                .frame(width: 26)
            Text(L.sectionTitle(item, language))
                .font(.headline.weight(.black))
                .lineLimit(1)
            Spacer()
        }
        .foregroundStyle(selection == item ? BrandPalette.ink : BrandPalette.text)
        .padding(.vertical, 7)
    }

    private func rowBackground(for item: AppSection) -> some View {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
            .fill(selection == item ? BrandPalette.glowBlue.opacity(0.9) : BrandPalette.white.opacity(0.06))
            .overlay(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(selection == item ? BrandPalette.white.opacity(0.5) : BrandPalette.glowBlue.opacity(0.08), lineWidth: 1)
            )
            .padding(.vertical, 2)
    }
}

struct MoreView: View {
    let language: AppLanguage

    private var items: [AppSection] {
        [.almanac, .kit, .profile]
    }

    var body: some View {
        AppScreen {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 14) {
                    BrandLockup(compact: true)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(L.sectionTitle(.more, language))
                            .font(.system(size: 30, weight: .black, design: .rounded))
                            .foregroundStyle(BrandPalette.white)
                        Text(language == .english ? "Learning, equipment, and local settings." : "Kunskap, utrustning och lokala inställningar.")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(BrandPalette.textSoft)
                    }
                }

                ForEach(items) { item in
                    NavigationLink {
                        destination(for: item)
                    } label: {
                        RainCard {
                            HStack(spacing: 14) {
                                Image(systemName: item.symbol)
                                    .font(.title2.weight(.black))
                                    .foregroundStyle(BrandPalette.glowBlue)
                                    .frame(width: 48, height: 48)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                                            .fill(BrandPalette.glowBlue.opacity(0.14))
                                    )
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(L.sectionTitle(item, language))
                                        .font(.headline.weight(.black))
                                        .foregroundStyle(BrandPalette.white)
                                    Text(subtitle(for: item))
                                        .font(.subheadline)
                                        .foregroundStyle(BrandPalette.textSoft)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.caption.weight(.black))
                                    .foregroundStyle(BrandPalette.textMuted)
                            }
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    @ViewBuilder
    private func destination(for item: AppSection) -> some View {
        switch item {
        case .almanac:
            CultureView()
        case .kit:
            StoneforgeView()
        case .profile:
            ProfileView()
        default:
            EmptyView()
        }
    }

    private func subtitle(for item: AppSection) -> String {
        switch (item, language) {
        case (.almanac, .english): "History, rules, illustrated guides, and glossary."
        case (.kit, .english): "Favorite varpa, material, weight, and field notes."
        case (.profile, .english): "Language, local profile, achievements, and reset."
        case (.almanac, .swedish): "Historia, regler, illustrerade guider och ordlista."
        case (.kit, .swedish): "Favoritvarpa, material, vikt och fältanteckningar."
        case (.profile, .swedish): "Språk, lokal profil, mål och nollställning."
        default: ""
        }
    }
}
