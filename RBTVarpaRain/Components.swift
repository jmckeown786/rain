import SwiftUI

struct AppScreen<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                RainBackground()
                ScrollView(showsIndicators: false) {
                    content
                        .frame(maxWidth: contentMaxWidth(for: proxy.size.width), alignment: .leading)
                        .padding(.horizontal, 18)
                        .padding(.top, topPadding(for: proxy.size.width))
                        .padding(.bottom, 30)
                        .frame(maxWidth: .infinity)
                }
                .scrollDismissesKeyboard(.interactively)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    private func contentMaxWidth(for containerWidth: CGFloat) -> CGFloat {
        guard containerWidth.isFinite, containerWidth > 36 else {
            return 0
        }

        return min(containerWidth - 36, 980)
    }

    private func topPadding(for containerWidth: CGFloat) -> CGFloat {
        guard containerWidth.isFinite else {
            return 14
        }

        return containerWidth > 760 ? 28 : 14
    }
}

struct RainBackground: View {
    var body: some View {
        ZStack {
            BrandPalette.ink.ignoresSafeArea()
            LinearGradient(
                colors: [BrandPalette.midnight, BrandPalette.ink],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            RadialGradient(
                colors: [BrandPalette.rainBlue.opacity(0.28), .clear],
                center: .topTrailing,
                startRadius: 20,
                endRadius: 420
            )
            .ignoresSafeArea()
        }
    }
}

struct RainCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(LinearGradient.rainSurface)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .stroke(BrandPalette.glowBlue.opacity(0.2), lineWidth: 1)
                    )
            )
            .shadow(color: BrandPalette.ink.opacity(0.28), radius: 12, x: 0, y: 8)
    }
}

struct BrandLockup: View {
    var compact = false

    var body: some View {
        HStack(spacing: compact ? 10 : 14) {
            LogoMark(size: compact ? 56 : 78)
            VStack(alignment: .leading, spacing: compact ? -1 : -2) {
                Text("Rbt")
                    .font(.custom("SignPainter-HouseScriptSemibold", size: compact ? 42 : 59))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color(hex: 0xF4FBFF), Color(hex: 0xB9DEFF)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .shadow(color: Color(hex: 0x020817).opacity(0.58), radius: 5, x: 0, y: 3)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                Text("VARPA RAIN")
                    .font(.system(size: compact ? 8 : 10, weight: .heavy))
                    .tracking(compact ? 3.2 : 4.4)
                    .foregroundStyle(Color(hex: 0xBEDAFF).opacity(0.88))
            }
        }
    }
}

struct LogoMark: View {
    let size: CGFloat

    var body: some View {
        Image("RBTVarpaLogo")
            .resizable()
            .scaledToFill()
        .frame(width: size, height: size)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(Color(hex: 0x8FCFFF).opacity(0.34), lineWidth: 1)
        )
        .shadow(color: Color(hex: 0x020817).opacity(0.3), radius: 8, x: 0, y: 5)
    }
}

struct SectionKick: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.title3.weight(.heavy))
                .foregroundStyle(BrandPalette.text)
            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(BrandPalette.textSoft)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct StatPill: View {
    let value: String
    let label: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(value)
                .font(.headline.weight(.black))
                .foregroundStyle(BrandPalette.white)
                .lineLimit(1)
                .minimumScaleFactor(0.62)
            Text(label)
                .font(.caption.weight(.bold))
                .foregroundStyle(BrandPalette.textSoft)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(color.opacity(0.16))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(color.opacity(0.32), lineWidth: 1))
        )
    }
}

struct AppTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.body.weight(.semibold))
            .foregroundStyle(BrandPalette.white)
            .tint(BrandPalette.glowBlue)
            .padding(.horizontal, 14)
            .padding(.vertical, 13)
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(BrandPalette.ink.opacity(0.62))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .stroke(BrandPalette.glowBlue.opacity(0.24), lineWidth: 1)
                    )
            )
    }
}

struct FormDatePicker: View {
    let title: String
    @Binding var date: Date

    var body: some View {
        HStack(spacing: 12) {
            Text(title)
                .font(.subheadline.weight(.heavy))
                .foregroundStyle(BrandPalette.white)
            Spacer()
            DatePicker("", selection: $date)
                .labelsHidden()
                .datePickerStyle(.compact)
                .colorScheme(.dark)
                .tint(BrandPalette.glowBlue)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(BrandPalette.ink.opacity(0.48))
                .overlay(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(BrandPalette.white.opacity(0.08), lineWidth: 1)
                )
        )
    }
}

struct SurfaceSegmentedControl: View {
    @Binding var selection: SurfaceType
    var language: AppLanguage = .english

    var body: some View {
        HStack(spacing: 6) {
            ForEach(SurfaceType.allCases) { item in
                Button {
                    withAnimation(.spring(response: 0.24, dampingFraction: 0.82)) {
                        selection = item
                    }
                } label: {
                    Text(L.surface(item, language))
                        .font(.caption.weight(.black))
                        .foregroundStyle(selection == item ? BrandPalette.ink : BrandPalette.textSoft)
                        .lineLimit(1)
                        .minimumScaleFactor(0.78)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 11)
                        .background(
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(selection == item ? item.color : BrandPalette.white.opacity(0.08))
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(BrandPalette.ink.opacity(0.5))
        )
    }
}

struct WeatherMenu: View {
    @Binding var selection: WeatherCondition
    var language: AppLanguage = .english
    @State private var expanded = false

    var body: some View {
        VStack(spacing: 8) {
            Button {
                withAnimation(.spring(response: 0.24, dampingFraction: 0.86)) {
                    expanded.toggle()
                }
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: selection.symbol)
                        .font(.body.weight(.black))
                        .foregroundStyle(BrandPalette.glowBlue)
                        .frame(width: 24)
                    Text(L.weather(selection, language))
                        .font(.subheadline.weight(.black))
                        .foregroundStyle(BrandPalette.white)
                    Spacer()
                    Image(systemName: expanded ? "chevron.up" : "chevron.down")
                        .font(.caption.weight(.black))
                        .foregroundStyle(BrandPalette.textSoft)
                }
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(BrandPalette.ink.opacity(0.5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .stroke(BrandPalette.glowBlue.opacity(0.18), lineWidth: 1)
                        )
                )
            }
            .buttonStyle(.plain)

            if expanded {
                VStack(spacing: 6) {
                    ForEach(WeatherCondition.allCases) { item in
                        Button {
                            withAnimation(.spring(response: 0.24, dampingFraction: 0.86)) {
                                selection = item
                                expanded = false
                            }
                        } label: {
                            HStack(spacing: 10) {
                                Image(systemName: item.symbol)
                                    .font(.body.weight(.black))
                                    .foregroundStyle(selection == item ? BrandPalette.ink : BrandPalette.glowBlue)
                                    .frame(width: 24)
                                Text(L.weather(item, language))
                                    .font(.subheadline.weight(.black))
                                    .foregroundStyle(selection == item ? BrandPalette.ink : BrandPalette.white)
                                Spacer()
                                if selection == item {
                                    Image(systemName: "checkmark")
                                        .font(.caption.weight(.black))
                                        .foregroundStyle(BrandPalette.ink)
                                }
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 11)
                            .background(
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .fill(selection == item ? BrandPalette.glowBlue : BrandPalette.ink.opacity(0.72))
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(6)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(BrandPalette.panel.opacity(0.96))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .stroke(BrandPalette.glowBlue.opacity(0.2), lineWidth: 1)
                        )
                )
            }
        }
    }
}

struct MatchLaneView: View {
    let surface: SurfaceType
    let weather: WeatherCondition
    let quality: Double

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let marker = CGPoint(x: size.width * 0.74, y: size.height * 0.42)
            let throwPoint = CGPoint(x: size.width * (0.22 + min(max(quality, 0), 1) * 0.44), y: size.height * 0.67)

            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(BrandPalette.ink.opacity(0.72))
                ForEach(0..<6) { index in
                    Path { path in
                        let y = size.height * CGFloat(index + 1) / 7
                        path.move(to: CGPoint(x: 16, y: y))
                        path.addLine(to: CGPoint(x: size.width - 16, y: y - CGFloat(index) * 2))
                    }
                    .stroke(surface.color.opacity(0.13), lineWidth: 1)
                }
                Path { path in
                    path.move(to: CGPoint(x: size.width * 0.12, y: size.height * 0.78))
                    path.addQuadCurve(to: throwPoint, control: CGPoint(x: size.width * 0.44, y: size.height * 0.18))
                }
                .stroke(BrandPalette.gold.opacity(0.8), style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [8, 8]))

                ForEach(0..<4) { index in
                    Circle()
                        .stroke(BrandPalette.rainBlue.opacity(Double(4 - index) * 0.12), lineWidth: 2)
                        .frame(width: CGFloat(118 - index * 24), height: CGFloat(118 - index * 24))
                        .position(marker)
                }
                Circle()
                    .fill(BrandPalette.rainBlue)
                    .frame(width: 10, height: 10)
                    .position(marker)
                VarpaStone(color: surface.color)
                    .frame(width: 34, height: 22)
                    .position(throwPoint)
                Image(systemName: weather.symbol)
                    .font(.caption.weight(.black))
                    .foregroundStyle(BrandPalette.textSoft)
                    .position(x: size.width - 28, y: 24)
            }
        }
        .frame(height: 168)
    }
}

struct VarpaStone: View {
    let color: Color

    var body: some View {
        Capsule()
            .fill(
                LinearGradient(
                    colors: [color.opacity(0.98), BrandPalette.white.opacity(0.66), color.opacity(0.7)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay(Capsule().stroke(BrandPalette.white.opacity(0.32), lineWidth: 1))
            .rotationEffect(.degrees(-10))
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline.weight(.bold))
            .foregroundStyle(BrandPalette.ink)
            .padding(.vertical, 13)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(LinearGradient.rainAction)
                    .opacity(configuration.isPressed ? 0.72 : 1)
            )
    }
}

struct QuietButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline.weight(.bold))
            .foregroundStyle(BrandPalette.text)
            .padding(.vertical, 11)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(BrandPalette.white.opacity(configuration.isPressed ? 0.08 : 0.12))
            )
    }
}

extension Date {
    var shortMatchDate: String {
        formatted(date: .abbreviated, time: .shortened)
    }
}

extension Double {
    var meters: String {
        String(format: "%.2f m", self)
    }
}
