import SwiftUI

struct CultureView: View {
    @AppStorage("settings.language") private var languageRawValue = AppLanguage.english.rawValue
    @State private var topic = 0
    private var language: AppLanguage {
        AppLanguage(rawValue: languageRawValue) ?? .english
    }

    var body: some View {
        AppScreen {
            VStack(alignment: .leading, spacing: 16) {
                SectionKick(title: L.text(.almanacTitle, language), subtitle: L.text(.almanacSubtitle, language))

                RainCard {
                    VStack(alignment: .leading, spacing: 15) {
                        BrandLockup(compact: true)
                        Text(L.text(.readLane, language))
                            .font(.system(size: 27, weight: .black, design: .rounded))
                            .foregroundStyle(BrandPalette.white)
                            .fixedSize(horizontal: false, vertical: true)

                        Picker("Topic", selection: $topic) {
                            Text(L.text(.articles, language)).tag(0)
                            Text(L.text(.rules, language)).tag(1)
                            Text(L.text(.glossary, language)).tag(2)
                        }
                        .pickerStyle(.segmented)
                    }
                }

                if topic == 0 {
                    articleList
                } else if topic == 1 {
                    rulesList
                } else {
                    glossaryList
                }
            }
        }
    }

    private var articleList: some View {
        VStack(spacing: 16) {
            ForEach(AppData.almanac(language: language)) { article in
                NavigationLink {
                    ArticleDetailView(article: article, language: language)
                } label: {
                    RainCard {
                        VStack(alignment: .leading, spacing: 13) {
                            AlmanacIllustration(kind: article.imageKind, accent: article.accent)
                                .frame(height: 142)
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                            HStack(alignment: .top, spacing: 14) {
                                Image(systemName: article.symbol)
                                    .font(.title2.weight(.black))
                                    .foregroundStyle(article.accent)
                                    .frame(width: 46, height: 46)
                                    .background(Circle().fill(article.accent.opacity(0.16)))

                                VStack(alignment: .leading, spacing: 7) {
                                    HStack(spacing: 8) {
                                        Text(article.title)
                                            .font(.headline.weight(.black))
                                            .foregroundStyle(BrandPalette.white)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .font(.caption.weight(.black))
                                            .foregroundStyle(BrandPalette.textMuted)
                                    }
                                    Text(article.subtitle)
                                        .font(.caption.weight(.heavy))
                                        .foregroundStyle(article.accent)
                                    Text(article.lead)
                                        .font(.subheadline)
                                        .foregroundStyle(BrandPalette.textSoft)
                                        .lineLimit(3)
                                        .fixedSize(horizontal: false, vertical: true)
                                    Text(article.readTime)
                                        .font(.caption.weight(.black))
                                        .foregroundStyle(BrandPalette.textMuted)
                                }
                            }
                        }
                    }
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var rulesList: some View {
        VStack(spacing: 16) {
            ForEach(Array(AppData.rulesChecklist(language: language).enumerated()), id: \.element.id) { index, rule in
                RainCard {
                    VStack(alignment: .leading, spacing: 13) {
                        RuleExampleIllustration(kind: rule.imageKind, language: language)
                            .frame(height: 152)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                        HStack(alignment: .top, spacing: 12) {
                            Text("\(index + 1)")
                                .font(.headline.weight(.black))
                                .foregroundStyle(BrandPalette.ink)
                                .frame(width: 34, height: 34)
                                .background(Circle().fill(BrandPalette.gold))
                            VStack(alignment: .leading, spacing: 7) {
                                Text(rule.title)
                                    .font(.headline.weight(.black))
                                    .foregroundStyle(BrandPalette.white)
                                Text(rule.summary)
                                    .font(.subheadline.weight(.bold))
                                    .foregroundStyle(BrandPalette.text)
                                    .fixedSize(horizontal: false, vertical: true)
                                Text(rule.detail)
                                    .font(.subheadline)
                                    .foregroundStyle(BrandPalette.textSoft)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                }
            }
        }
    }

    private var glossaryList: some View {
        VStack(spacing: 12) {
            ForEach(AppData.glossary(language: language)) { entry in
                RainCard {
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: entry.symbol)
                            .font(.headline.weight(.black))
                            .foregroundStyle(BrandPalette.glowBlue)
                            .frame(width: 36, height: 36)
                            .background(Circle().fill(BrandPalette.glowBlue.opacity(0.14)))

                        VStack(alignment: .leading, spacing: 6) {
                            Text(entry.term)
                                .font(.headline.weight(.black))
                                .foregroundStyle(BrandPalette.white)
                            Text(entry.definition)
                                .font(.subheadline)
                                .foregroundStyle(BrandPalette.text)
                                .fixedSize(horizontal: false, vertical: true)
                            Text(entry.usage)
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(BrandPalette.textSoft)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
            }
        }
    }
}

struct ArticleDetailView: View {
    let article: AlmanacArticle
    let language: AppLanguage

    var body: some View {
        AppScreen {
            VStack(alignment: .leading, spacing: 16) {
                AlmanacIllustration(kind: article.imageKind, accent: article.accent)
                    .frame(height: 236)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 8) {
                        Image(systemName: article.symbol)
                            .foregroundStyle(article.accent)
                        Text(article.readTime)
                            .font(.caption.weight(.black))
                            .foregroundStyle(BrandPalette.textMuted)
                    }
                    Text(article.title)
                        .font(.system(size: 32, weight: .black, design: .rounded))
                        .foregroundStyle(BrandPalette.white)
                        .fixedSize(horizontal: false, vertical: true)
                    Text(article.lead)
                        .font(.body.weight(.semibold))
                        .foregroundStyle(BrandPalette.text)
                        .fixedSize(horizontal: false, vertical: true)
                }

                ForEach(article.sections) { section in
                    RainCard {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(section.heading)
                                .font(.title3.weight(.black))
                                .foregroundStyle(article.accent)
                            ForEach(section.paragraphs, id: \.self) { paragraph in
                                Text(paragraph)
                                    .font(.body)
                                    .foregroundStyle(BrandPalette.textSoft)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                }

                RainCard {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(L.text(.fieldTakeaways, language))
                            .font(.headline.weight(.black))
                            .foregroundStyle(BrandPalette.white)
                        ForEach(article.takeaways, id: \.self) { takeaway in
                            Label(takeaway, systemImage: "checkmark.circle.fill")
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(BrandPalette.text)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
            }
        }
        .navigationTitle(article.title)
    }
}

struct AlmanacIllustration: View {
    let kind: AlmanacImageKind
    let accent: Color

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            ZStack {
                LinearGradient(
                    colors: [BrandPalette.panel, BrandPalette.ink, accent.opacity(0.34)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                switch kind {
                case .history:
                    historyScene(size: size)
                case .rules:
                    laneScene(size: size)
                case .technique:
                    techniqueScene(size: size)
                case .rain:
                    rainScene(size: size)
                case .training:
                    trainingScene(size: size)
                }
            }
        }
    }

    private func historyScene(size: CGSize) -> some View {
        ZStack {
            ForEach(0..<4) { index in
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(index.isMultiple(of: 2) ? BrandPalette.clay.opacity(0.34) : BrandPalette.mint.opacity(0.2))
                    .frame(width: size.width * 0.18, height: size.height * 0.5)
                    .rotationEffect(.degrees(Double(index * 9 - 14)))
                    .position(x: size.width * CGFloat(0.2 + Double(index) * 0.17), y: size.height * 0.58)
            }
            Image(systemName: "map.fill")
                .font(.system(size: 54, weight: .black))
                .foregroundStyle(accent.opacity(0.9))
                .position(x: size.width * 0.78, y: size.height * 0.32)
            dottedArc(size: size)
        }
    }

    private func laneScene(size: CGSize) -> some View {
        ZStack {
            laneLines(size: size)
            targetRings(size: size, point: CGPoint(x: size.width * 0.75, y: size.height * 0.45))
            VarpaStone(color: accent)
                .frame(width: 46, height: 28)
                .position(x: size.width * 0.36, y: size.height * 0.7)
        }
    }

    private func techniqueScene(size: CGSize) -> some View {
        ZStack {
            laneLines(size: size)
            Path { path in
                path.move(to: CGPoint(x: size.width * 0.18, y: size.height * 0.78))
                path.addQuadCurve(
                    to: CGPoint(x: size.width * 0.72, y: size.height * 0.45),
                    control: CGPoint(x: size.width * 0.48, y: size.height * 0.08)
                )
            }
            .stroke(BrandPalette.gold, style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: [9, 8]))
            targetRings(size: size, point: CGPoint(x: size.width * 0.76, y: size.height * 0.46))
            VarpaStone(color: BrandPalette.mint)
                .frame(width: 48, height: 26)
                .position(x: size.width * 0.58, y: size.height * 0.31)
        }
    }

    private func rainScene(size: CGSize) -> some View {
        ZStack {
            laneLines(size: size)
            ForEach(0..<18) { index in
                Capsule()
                    .fill(BrandPalette.glowBlue.opacity(0.7))
                    .frame(width: 3, height: 18)
                    .rotationEffect(.degrees(12))
                    .position(
                        x: size.width * CGFloat(0.08 + Double(index % 6) * 0.16),
                        y: size.height * CGFloat(0.16 + Double(index / 6) * 0.22)
                    )
            }
            Image(systemName: "cloud.heavyrain.fill")
                .font(.system(size: 50, weight: .black))
                .foregroundStyle(BrandPalette.glowBlue)
                .position(x: size.width * 0.28, y: size.height * 0.27)
            VarpaStone(color: BrandPalette.gold)
                .frame(width: 54, height: 28)
                .position(x: size.width * 0.72, y: size.height * 0.7)
        }
    }

    private func trainingScene(size: CGSize) -> some View {
        ZStack {
            laneLines(size: size)
            ForEach(0..<3) { index in
                targetRings(
                    size: size,
                    point: CGPoint(
                        x: size.width * CGFloat(0.35 + Double(index) * 0.18),
                        y: size.height * CGFloat(0.64 - Double(index) * 0.11)
                    )
                )
            }
            Image(systemName: "chart.line.uptrend.xyaxis")
                .font(.system(size: 48, weight: .black))
                .foregroundStyle(accent)
                .position(x: size.width * 0.26, y: size.height * 0.28)
        }
    }

    private func laneLines(size: CGSize) -> some View {
        ZStack {
            ForEach(0..<5) { index in
                Path { path in
                    let y = size.height * CGFloat(index + 2) / 7
                    path.move(to: CGPoint(x: 18, y: y))
                    path.addLine(to: CGPoint(x: size.width - 18, y: y - CGFloat(index * 3)))
                }
                .stroke(BrandPalette.white.opacity(0.1), lineWidth: 1)
            }
        }
    }

    private func targetRings(size: CGSize, point: CGPoint) -> some View {
        ZStack {
            ForEach(0..<3) { index in
                Circle()
                    .stroke(accent.opacity(Double(3 - index) * 0.17), lineWidth: 2)
                    .frame(width: CGFloat(80 - index * 22), height: CGFloat(80 - index * 22))
                    .position(point)
            }
            Circle()
                .fill(accent)
                .frame(width: 9, height: 9)
                .position(point)
        }
    }

    private func dottedArc(size: CGSize) -> some View {
        Path { path in
            path.move(to: CGPoint(x: size.width * 0.16, y: size.height * 0.34))
            path.addQuadCurve(
                to: CGPoint(x: size.width * 0.68, y: size.height * 0.64),
                control: CGPoint(x: size.width * 0.48, y: size.height * 0.05)
            )
        }
        .stroke(BrandPalette.gold.opacity(0.72), style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [5, 9]))
    }
}

struct RuleExampleIllustration: View {
    let kind: RuleImageKind
    let language: AppLanguage

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            ZStack {
                LinearGradient(
                    colors: [BrandPalette.ink, BrandPalette.panel, BrandPalette.glowBlue.opacity(0.2)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                laneBase(size: size)

                switch kind {
                case .marker:
                    markerExample(size: size)
                case .line:
                    lineExample(size: size)
                case .measuring:
                    measuringExample(size: size)
                case .equalThrows:
                    equalThrowsExample(size: size)
                case .surface:
                    surfaceExample(size: size)
                case .scoring:
                    scoringExample(size: size)
                }
            }
        }
    }

    private func laneBase(size: CGSize) -> some View {
        ZStack {
            ForEach(0..<4) { index in
                Path { path in
                    let y = size.height * CGFloat(index + 2) / 6
                    path.move(to: CGPoint(x: 14, y: y))
                    path.addLine(to: CGPoint(x: size.width - 14, y: y - CGFloat(index * 3)))
                }
                .stroke(BrandPalette.white.opacity(0.08), lineWidth: 1)
            }
        }
    }

    private func markerExample(size: CGSize) -> some View {
        ZStack {
            distanceArrow(size: size, from: 0.18, to: 0.78, y: 0.78, label: "20 m")
            marker(at: CGPoint(x: size.width * 0.78, y: size.height * 0.42), size: size)
            throwingLine(size: size, x: 0.18)
        }
    }

    private func lineExample(size: CGSize) -> some View {
        ZStack {
            throwingLine(size: size, x: 0.22)
            Image(systemName: "figure.walk")
                .font(.system(size: 42, weight: .black))
                .foregroundStyle(BrandPalette.gold)
                .position(x: size.width * 0.14, y: size.height * 0.52)
            Image(systemName: "checkmark.circle.fill")
                .font(.title.weight(.black))
                .foregroundStyle(BrandPalette.mint)
                .position(x: size.width * 0.32, y: size.height * 0.3)
        }
    }

    private func measuringExample(size: CGSize) -> some View {
        ZStack {
            marker(at: CGPoint(x: size.width * 0.66, y: size.height * 0.45), size: size)
            VarpaStone(color: BrandPalette.gold)
                .frame(width: 52, height: 28)
                .position(x: size.width * 0.42, y: size.height * 0.63)
            distanceArrow(size: size, from: 0.44, to: 0.66, y: 0.55, label: L.text(.nearestEdge, language))
        }
    }

    private func equalThrowsExample(size: CGSize) -> some View {
        HStack(spacing: 18) {
            throwStack(color: BrandPalette.mint, label: "You")
            throwStack(color: BrandPalette.rainBlue, label: "Them")
        }
        .frame(width: size.width, height: size.height)
    }

    private func surfaceExample(size: CGSize) -> some View {
        HStack(spacing: 8) {
            surfaceTile(color: BrandPalette.mint, title: "Grass")
            surfaceTile(color: BrandPalette.rainBlue, title: "Gravel")
            surfaceTile(color: BrandPalette.clay, title: "Clay")
        }
        .padding(16)
        .frame(width: size.width, height: size.height)
    }

    private func scoringExample(size: CGSize) -> some View {
        ZStack {
            marker(at: CGPoint(x: size.width * 0.56, y: size.height * 0.43), size: size)
            VarpaStone(color: BrandPalette.mint)
                .frame(width: 50, height: 26)
                .position(x: size.width * 0.48, y: size.height * 0.52)
            VarpaStone(color: BrandPalette.coral)
                .frame(width: 50, height: 26)
                .position(x: size.width * 0.78, y: size.height * 0.68)
            Label(L.text(.closestWins, language), systemImage: "star.fill")
                .font(.caption.weight(.black))
                .foregroundStyle(BrandPalette.ink)
                .padding(.horizontal, 10)
                .padding(.vertical, 7)
                .background(Capsule().fill(BrandPalette.gold))
                .position(x: size.width * 0.38, y: size.height * 0.24)
        }
    }

    private func throwingLine(size: CGSize, x: CGFloat) -> some View {
        Path { path in
            path.move(to: CGPoint(x: size.width * x, y: size.height * 0.18))
            path.addLine(to: CGPoint(x: size.width * x, y: size.height * 0.84))
        }
        .stroke(BrandPalette.gold, style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: [8, 7]))
    }

    private func marker(at point: CGPoint, size: CGSize) -> some View {
        ZStack {
            ForEach(0..<3) { index in
                Circle()
                    .stroke(BrandPalette.glowBlue.opacity(Double(3 - index) * 0.18), lineWidth: 2)
                    .frame(width: CGFloat(82 - index * 22), height: CGFloat(82 - index * 22))
            }
            Image(systemName: "mappin")
                .font(.title2.weight(.black))
                .foregroundStyle(BrandPalette.glowBlue)
        }
        .position(point)
    }

    private func distanceArrow(size: CGSize, from: CGFloat, to: CGFloat, y: CGFloat, label: String) -> some View {
        ZStack {
            Path { path in
                path.move(to: CGPoint(x: size.width * from, y: size.height * y))
                path.addLine(to: CGPoint(x: size.width * to, y: size.height * y))
            }
            .stroke(BrandPalette.gold, style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [7, 6]))
            Text(label)
                .font(.caption.weight(.black))
                .foregroundStyle(BrandPalette.ink)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Capsule().fill(BrandPalette.gold))
                .position(x: size.width * ((from + to) / 2), y: size.height * (y - 0.12))
        }
    }

    private func throwStack(color: Color, label: String) -> some View {
        VStack(spacing: 8) {
            HStack(spacing: -8) {
                ForEach(0..<3) { _ in
                    VarpaStone(color: color)
                        .frame(width: 42, height: 24)
                }
            }
            Text(label)
                .font(.caption.weight(.black))
                .foregroundStyle(BrandPalette.text)
        }
        .frame(maxWidth: .infinity)
    }

    private func surfaceTile(color: Color, title: String) -> some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(color.opacity(0.42))
                .overlay(
                    ForEach(0..<4) { index in
                        Path { path in
                            path.move(to: CGPoint(x: 8, y: CGFloat(12 + index * 15)))
                            path.addLine(to: CGPoint(x: 82, y: CGFloat(18 + index * 11)))
                        }
                        .stroke(color.opacity(0.5), lineWidth: 2)
                    }
                )
                .frame(height: 70)
            Text(title)
                .font(.caption.weight(.black))
                .foregroundStyle(BrandPalette.text)
        }
    }
}
