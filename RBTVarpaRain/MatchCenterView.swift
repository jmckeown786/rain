import SwiftUI

struct MatchCenterView: View {
    @EnvironmentObject private var store: VarpaStore
    @AppStorage("settings.language") private var languageRawValue = AppLanguage.english.rawValue
    @State private var opponent = ""
    @State private var venue = ""
    @State private var date = Date()
    @State private var format = "Singles to 12 throws"
    @State private var surface: SurfaceType = .grass
    @State private var weather: WeatherCondition = .lightRain
    @State private var targetDistance = 20.0
    @State private var notes = ""
    @State private var teamSport: TeamSport = .football
    @State private var teamSearch = ""
    @FocusState private var focusedField: PlannerField?
    private var language: AppLanguage {
        AppLanguage(rawValue: languageRawValue) ?? .english
    }
    private var currentReadout: LaneReadout {
        LaneReadout.make(
            surface: surface,
            weather: weather,
            targetDistance: targetDistance,
            gear: store.favoriteGear,
            bestDistance: store.bestDistance,
            language: language
        )
    }

    private enum PlannerField {
        case opponent
        case venue
        case format
        case notes
        case teamSearch
    }

    private var suggestedTeams: [SportTeam] {
        let query = teamSearch.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        return AppData.sportTeams
            .filter { $0.sport == teamSport }
            .filter { team in
                query.isEmpty ||
                team.name.lowercased().contains(query) ||
                team.league.lowercased().contains(query) ||
                team.region.lowercased().contains(query)
            }
            .prefix(12)
            .map { $0 }
    }

    var body: some View {
        AppScreen {
            VStack(alignment: .leading, spacing: 16) {
                SectionKick(title: L.text(.plannerTitle, language), subtitle: L.text(.plannerSubtitle, language))

                RainCard {
                    VStack(alignment: .leading, spacing: 14) {
                        Text(L.text(.newMatch, language))
                            .font(.title2.weight(.black))
                            .foregroundStyle(BrandPalette.white)

                        teamDirectory

                        TextField(
                            L.text(.opponentTeam, language),
                            text: $opponent,
                            prompt: Text(L.text(.opponentTeam, language)).foregroundColor(BrandPalette.textMuted)
                        )
                            .textFieldStyle(AppTextFieldStyle())
                            .focused($focusedField, equals: .opponent)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .venue }
                        TextField(
                            L.text(.venueLane, language),
                            text: $venue,
                            prompt: Text(L.text(.venueLane, language)).foregroundColor(BrandPalette.textMuted)
                        )
                            .textFieldStyle(AppTextFieldStyle())
                            .focused($focusedField, equals: .venue)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .format }
                        FormDatePicker(title: L.text(.date, language), date: $date)
                        TextField(
                            L.text(.matchFormat, language),
                            text: $format,
                            prompt: Text(L.text(.matchFormat, language)).foregroundColor(BrandPalette.textMuted)
                        )
                            .textFieldStyle(AppTextFieldStyle())
                            .focused($focusedField, equals: .format)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .notes }

                        SurfaceSegmentedControl(selection: $surface, language: language)

                        WeatherMenu(selection: $weather, language: language)

                        VStack(alignment: .leading, spacing: 6) {
                            Text("\(L.text(.targetDistance, language)): \(targetDistance.meters)")
                                .font(.subheadline.weight(.heavy))
                                .foregroundStyle(BrandPalette.white)
                            Slider(value: $targetDistance, in: 8...25, step: 0.5)
                                .tint(BrandPalette.gold)
                        }

                        LaneReadoutPanel(
                            readout: currentReadout,
                            actionTitle: language == .english ? "Add lane read to notes" : "Lägg banläsning i anteckningar"
                        ) {
                            appendLaneReadToNotes()
                        }

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

                        Button {
                            savePlan()
                        } label: {
                            Label(L.text(.saveMatchPlan, language), systemImage: "calendar.badge.plus")
                        }
                        .buttonStyle(PrimaryButtonStyle())
                        .disabled(opponent.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || venue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                }

                SectionKick(title: L.text(.upcoming, language), subtitle: L.text(.upcomingSubtitle, language))

                ForEach(store.upcomingPlans) { plan in
                    RainCard {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(alignment: .top) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(plan.opponent)
                                        .font(.headline.weight(.black))
                                        .foregroundStyle(BrandPalette.white)
                                    Text(plan.date.shortMatchDate)
                                        .font(.caption.weight(.heavy))
                                        .foregroundStyle(BrandPalette.gold)
                                }
                                Spacer()
                                Button {
                                    store.deletePlan(plan)
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .buttonStyle(QuietButtonStyle())
                            }
                            Text("\(plan.venue) - \(localizedFormat(plan.format))")
                                .font(.subheadline)
                                .foregroundStyle(BrandPalette.textSoft)
                            HStack(spacing: 10) {
                                StatPill(value: L.surface(plan.surface, language), label: L.text(.surface, language), color: plan.surface.color)
                                StatPill(value: L.weather(plan.weather, language), label: L.text(.weather, language), color: BrandPalette.rainBlue)
                                StatPill(value: plan.targetDistance.meters, label: L.text(.target, language), color: BrandPalette.gold)
                            }
                            if !plan.notes.isEmpty {
                                Text(plan.notes)
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

    private func savePlan() {
        focusedField = nil
        let plan = MatchPlan(
            id: UUID(),
            opponent: opponent.trimmingCharacters(in: .whitespacesAndNewlines),
            venue: venue.trimmingCharacters(in: .whitespacesAndNewlines),
            date: date,
            format: format,
            surface: surface,
            weather: weather,
            targetDistance: targetDistance,
            notes: notes.trimmingCharacters(in: .whitespacesAndNewlines)
        )
        store.addPlan(plan)
        opponent = ""
        venue = ""
        notes = ""
        targetDistance = 20
    }

    private func appendLaneReadToNotes() {
        let readout = currentReadout
        let text = ([readout.title, readout.summary] + readout.checks).joined(separator: "\n- ")
        if notes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            notes = text
        } else {
            notes += "\n\n\(text)"
        }
        focusedField = .notes
    }

    private var teamDirectory: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 7) {
                ForEach(TeamSport.allCases) { sport in
                    Button {
                        withAnimation(.spring(response: 0.24, dampingFraction: 0.82)) {
                            teamSport = sport
                            teamSearch = ""
                        }
                    } label: {
                        Label(teamSportTitle(sport), systemImage: sport.symbol)
                            .labelStyle(.iconOnly)
                            .font(.headline.weight(.black))
                            .foregroundStyle(teamSport == sport ? BrandPalette.ink : BrandPalette.textSoft)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .fill(teamSport == sport ? BrandPalette.glowBlue : BrandPalette.white.opacity(0.08))
                            )
                            .accessibilityLabel(teamSportTitle(sport))
                    }
                    .buttonStyle(.plain)
                }
            }

            TextField(
                teamSearchPrompt,
                text: $teamSearch,
                prompt: Text(teamSearchPrompt).foregroundColor(BrandPalette.textMuted)
            )
            .textFieldStyle(AppTextFieldStyle())
            .focused($focusedField, equals: .teamSearch)
            .submitLabel(.done)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(suggestedTeams) { team in
                        Button {
                            applyTeam(team)
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(team.name)
                                    .font(.caption.weight(.black))
                                    .foregroundStyle(BrandPalette.white)
                                    .lineLimit(1)
                                Text("\(team.league) - \(team.region)")
                                    .font(.caption2.weight(.bold))
                                    .foregroundStyle(BrandPalette.textSoft)
                                    .lineLimit(1)
                            }
                            .padding(.horizontal, 11)
                            .padding(.vertical, 9)
                            .frame(width: 174, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .fill(BrandPalette.ink.opacity(0.52))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                                            .stroke(BrandPalette.glowBlue.opacity(0.18), lineWidth: 1)
                                    )
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }

    private var teamSearchPrompt: String {
        switch language {
        case .english: "Search \(teamSportTitle(teamSport).lowercased()) teams"
        case .swedish: "Sök \(teamSportTitle(teamSport).lowercased())lag"
        }
    }

    private func teamSportTitle(_ sport: TeamSport) -> String {
        switch language {
        case .english:
            switch sport {
            case .football: "Football"
            case .basketball: "Basketball"
            case .hockey: "Hockey"
            }
        case .swedish:
            switch sport {
            case .football: "Fotboll"
            case .basketball: "Basket"
            case .hockey: "Hockey"
            }
        }
    }

    private func applyTeam(_ team: SportTeam) {
        opponent = team.name
        let teamNote = "\(team.name) - \(team.league), \(team.region)"
        if notes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            notes = teamNote
        } else if !notes.contains(teamNote) {
            notes += "\n\(teamNote)"
        }
        focusedField = .venue
    }

    private func localizedFormat(_ value: String) -> String {
        language == .swedish && value == "Singles to 12 throws" ? "Singel till 12 kast" : value
    }
}
