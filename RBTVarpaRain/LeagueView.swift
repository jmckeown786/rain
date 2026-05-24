import SwiftUI

struct LeagueView: View {
    @EnvironmentObject private var store: VarpaStore
    @AppStorage("settings.language") private var languageRawValue = AppLanguage.english.rawValue
    @State private var opponent = ""
    @State private var venue = ""
    @State private var date = Date()
    @State private var surface: SurfaceType = .gravel
    @State private var weather: WeatherCondition = .dry
    @State private var playerOne = 0.5
    @State private var playerTwo = 0.9
    @State private var playerThree = 1.2
    @State private var opponentOne = 0.8
    @State private var opponentTwo = 1.1
    @State private var opponentThree = 1.4
    @State private var notes = ""
    @FocusState private var focusedField: ResultField?
    private var language: AppLanguage {
        AppLanguage(rawValue: languageRawValue) ?? .english
    }

    private enum ResultField {
        case opponent
        case venue
        case notes
    }

    var body: some View {
        AppScreen {
            VStack(alignment: .leading, spacing: 16) {
                SectionKick(title: L.text(.resultsTitle, language), subtitle: L.text(.resultsSubtitle, language))

                RainCard {
                    VStack(alignment: .leading, spacing: 14) {
                        Text(L.text(.recordGame, language))
                            .font(.title2.weight(.black))
                            .foregroundStyle(BrandPalette.white)
                        TextField(
                            L.text(.opponent, language),
                            text: $opponent,
                            prompt: Text(L.text(.opponent, language)).foregroundColor(BrandPalette.textMuted)
                        )
                            .textFieldStyle(AppTextFieldStyle())
                            .focused($focusedField, equals: .opponent)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .venue }
                        TextField(
                            L.text(.venue, language),
                            text: $venue,
                            prompt: Text(L.text(.venue, language)).foregroundColor(BrandPalette.textMuted)
                        )
                            .textFieldStyle(AppTextFieldStyle())
                            .focused($focusedField, equals: .venue)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .notes }
                        FormDatePicker(title: L.text(.date, language), date: $date)

                        SurfaceSegmentedControl(selection: $surface, language: language)

                        WeatherMenu(selection: $weather, language: language)

                        throwSlider(title: L.text(.yourThrow1, language), value: $playerOne, color: BrandPalette.mint)
                        throwSlider(title: L.text(.yourThrow2, language), value: $playerTwo, color: BrandPalette.mint)
                        throwSlider(title: L.text(.yourThrow3, language), value: $playerThree, color: BrandPalette.mint)
                        throwSlider(title: L.text(.opponentThrow1, language), value: $opponentOne, color: BrandPalette.coral)
                        throwSlider(title: L.text(.opponentThrow2, language), value: $opponentTwo, color: BrandPalette.coral)
                        throwSlider(title: L.text(.opponentThrow3, language), value: $opponentThree, color: BrandPalette.coral)

                        TextField(
                            L.text(.notes, language),
                            text: $notes,
                            prompt: Text(L.text(.notes, language)).foregroundColor(BrandPalette.textMuted),
                            axis: .vertical
                        )
                            .lineLimit(3...5)
                            .textFieldStyle(AppTextFieldStyle())
                            .focused($focusedField, equals: .notes)
                            .submitLabel(.done)

                        HStack(spacing: 10) {
                            StatPill(value: [playerOne, playerTwo, playerThree].min()?.meters ?? "--", label: L.text(.yourBest, language), color: BrandPalette.mint)
                            StatPill(value: [opponentOne, opponentTwo, opponentThree].min()?.meters ?? "--", label: L.text(.opponent, language), color: BrandPalette.coral)
                        }

                        Button {
                            saveResult()
                        } label: {
                            Label(L.text(.saveResult, language), systemImage: "checkmark.seal.fill")
                        }
                        .buttonStyle(PrimaryButtonStyle())
                        .disabled(opponent.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || venue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                }

                SectionKick(title: L.text(.history, language), subtitle: L.text(.historySubtitle, language))

                ForEach(store.results) { result in
                    RainCard {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(localizedResultText(result.opponent))
                                        .font(.headline.weight(.black))
                                        .foregroundStyle(BrandPalette.white)
                                    Text("\(localizedResultText(result.venue)) - \(result.date.shortMatchDate)")
                                        .font(.caption.weight(.heavy))
                                        .foregroundStyle(BrandPalette.textSoft)
                                }
                                Spacer()
                                Text(result.didWin ? L.text(.win, language) : L.text(.chase, language))
                                    .font(.caption.weight(.black))
                                    .foregroundStyle(result.didWin ? BrandPalette.ink : BrandPalette.white)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 7)
                                    .background(Capsule().fill(result.didWin ? BrandPalette.mint : BrandPalette.coral))
                            }
                            HStack(spacing: 10) {
                                StatPill(value: result.bestThrow.meters, label: L.text(.best, language), color: BrandPalette.gold)
                                StatPill(value: result.averageThrow.meters, label: L.text(.average, language), color: BrandPalette.rainBlue)
                                StatPill(value: L.surface(result.surface, language), label: L.weather(result.weather, language), color: result.surface.color)
                            }
                            MatchLaneView(surface: result.surface, weather: result.weather, quality: min(1, 1.08 - result.bestThrow / 2.7))
                            if !result.notes.isEmpty {
                                Text(localizedResultText(result.notes))
                                    .font(.caption.weight(.semibold))
                                    .foregroundStyle(BrandPalette.textSoft)
                            }
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button(L.text(.ready, language)) {
                    focusedField = nil
                }
                .font(.headline.weight(.bold))
            }
        }
    }

    private func throwSlider(title: String, value: Binding<Double>, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(title)
                    .font(.subheadline.weight(.heavy))
                    .foregroundStyle(BrandPalette.white)
                Spacer()
                Text(value.wrappedValue.meters)
                    .font(.caption.weight(.black))
                    .foregroundStyle(color)
            }
            Slider(value: value, in: 0...4, step: 0.05)
                .tint(color)
        }
    }

    private func saveResult() {
        focusedField = nil
        let result = GameResult(
            id: UUID(),
            opponent: opponent.trimmingCharacters(in: .whitespacesAndNewlines),
            venue: venue.trimmingCharacters(in: .whitespacesAndNewlines),
            date: date,
            playerThrows: [playerOne, playerTwo, playerThree],
            opponentThrows: [opponentOne, opponentTwo, opponentThree],
            surface: surface,
            weather: weather,
            notes: notes.trimmingCharacters(in: .whitespacesAndNewlines)
        )
        store.addResult(result)
        opponent = ""
        venue = ""
        notes = ""
    }

    private func localizedResultText(_ value: String) -> String {
        guard language == .swedish else { return value }
        return switch value {
        case "Practice marker": "Träningsmarkör"
        case "Home lane": "Hemmabana"
        case "Clean low releases. Best throw stopped inside half a meter.": "Rena låga utslapp. Basta kastet stannade inom en halv meter."
        default: value
        }
    }
}
