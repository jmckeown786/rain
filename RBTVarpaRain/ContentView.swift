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
                ForEach(AppSection.allCases) { item in
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
        .background(BrandPalette.ink.ignoresSafeArea())
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
        .padding(.vertical, 4)
    }

    private func rowBackground(for item: AppSection) -> some View {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
            .fill(selection == item ? BrandPalette.glowBlue.opacity(0.84) : BrandPalette.white.opacity(0.05))
            .padding(.vertical, 2)
    }
}
